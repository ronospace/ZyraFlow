# 🔐 Fix App Store Distribution Signing

**Issue**: Invalid Provisioning Profile - Missing code-signing certificate  
**Current**: Only Development certificate found  
**Needed**: Distribution certificate + App Store provisioning profile

---

## 🎯 Problem Analysis

**Current Signing Status**:
```
❌ Distribution Certificate: NOT FOUND
✅ Development Certificate: Apple Development: ronos.ai@icloud.com (7K89CSJAXF)
```

**Error Message**:
> Invalid Provisioning Profile. The provisioning profile included in the com.flowai.health bundle is invalid. [Missing code-signing certificate]. A distribution provisioning profile should be used when uploading apps to App Store Connect.

---

## ✅ Solution: Create Distribution Certificate & Provisioning Profile

### Option 1: Automatic Signing (Recommended - Easiest)

Use Xcode to automatically manage certificates and profiles:

#### Step 1: Open Project in Xcode
```bash
open ios/Runner.xcworkspace
```

#### Step 2: Configure Signing in Xcode
1. Select **Runner** project in left sidebar
2. Select **Runner** target
3. Go to **Signing & Capabilities** tab
4. **Uncheck** "Automatically manage signing"
5. **Re-check** "Automatically manage signing"
6. Select your **Team**: 9FY62NTL53
7. Wait for Xcode to download/create certificates

#### Step 3: Verify Archive
1. In Xcode menu: **Product** → **Archive**
2. Wait for archive to complete
3. **Organizer** window opens automatically
4. Select your archive
5. Click **Distribute App**
6. Choose **App Store Connect**
7. Click **Next** through all steps
8. Click **Upload**

This method lets Xcode handle all certificate and profile creation automatically.

---

### Option 2: Manual Certificate Creation (Advanced)

If automatic signing fails, create certificates manually:

#### Step 1: Create Distribution Certificate

1. **Go to Apple Developer Portal**:
   - Visit: https://developer.apple.com/account/resources/certificates/list
   - Sign in with your Apple ID

2. **Create Distribution Certificate**:
   - Click **+** button
   - Select **"Apple Distribution"**
   - Click **Continue**

3. **Generate Certificate Signing Request (CSR)**:
   - Open **Keychain Access** on Mac
   - Menu: **Keychain Access** → **Certificate Assistant** → **Request a Certificate from a Certificate Authority**
   - Enter your email: `ronos.ai@icloud.com`
   - Select **"Saved to disk"**
   - Click **Continue**
   - Save as: `FlowAi_Distribution.certSigningRequest`

4. **Upload CSR**:
   - Back in Developer Portal
   - Upload the `.certSigningRequest` file
   - Click **Continue**
   - Download the certificate: `distribution.cer`

5. **Install Certificate**:
   - Double-click `distribution.cer`
   - Certificate installs in Keychain Access
   - Verify it appears under "My Certificates"

#### Step 2: Create App Store Provisioning Profile

1. **Go to Provisioning Profiles**:
   - Visit: https://developer.apple.com/account/resources/profiles/list

2. **Create Profile**:
   - Click **+** button
   - Select **"App Store"** under Distribution
   - Click **Continue**

3. **Select App ID**:
   - Choose **"Flow Ai"** or `com.flowai.health`
   - Click **Continue**

4. **Select Certificate**:
   - Choose the **Distribution** certificate you just created
   - Click **Continue**

5. **Name Profile**:
   - Name: `Flow Ai App Store Distribution`
   - Click **Generate**
   - Download: `Flow_Ai_App_Store.mobileprovision`

6. **Install Profile**:
   - Double-click the `.mobileprovision` file
   - Or drag to Xcode icon in Dock

#### Step 3: Configure Xcode to Use Manual Profiles

1. Open `ios/Runner.xcworkspace` in Xcode
2. Select **Runner** project → **Runner** target
3. **Signing & Capabilities** tab
4. **Uncheck** "Automatically manage signing"
5. Under **Provisioning Profile**:
   - Select **"Flow Ai App Store Distribution"**
6. Under **Signing Certificate**:
   - Select **"Apple Distribution"**

#### Step 4: Rebuild Archive

```bash
cd /Users/ronos/Workspace/Projects/Active/ZyraFlow
flutter clean
flutter build ipa --release --export-options-plist=ios/ExportOptions.plist
```

---

### Option 3: Command Line with xcrun (Alternative)

If you have valid certificates but Transporter fails:

```bash
# Navigate to project
cd /Users/ronos/Workspace/Projects/Active/ZyraFlow

# Build archive
flutter build ipa --release

# Validate IPA before upload
xcrun altool --validate-app \
  --file "build/ios/ipa/Flow Ai.ipa" \
  --type ios \
  --apiKey YOUR_API_KEY \
  --apiIssuer YOUR_ISSUER_ID

# Upload IPA
xcrun altool --upload-app \
  --file "build/ios/ipa/Flow Ai.ipa" \
  --type ios \
  --apiKey YOUR_API_KEY \
  --apiIssuer YOUR_ISSUER_ID
```

**Note**: Requires App Store Connect API key from: https://appstoreconnect.apple.com/access/api

---

## 🔍 Verify Signing After Setup

Check that distribution certificate is installed:

```bash
security find-identity -v -p codesigning
```

**Expected Output**:
```
1) XXXXXXXX "Apple Development: ronos.ai@icloud.com (7K89CSJAXF)"
2) YYYYYYYY "Apple Distribution: [Your Name or Company] (9FY62NTL53)"
   2 valid identities found
```

---

## 📝 ExportOptions.plist Configuration

Ensure your `ios/ExportOptions.plist` is configured for App Store:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>method</key>
    <string>app-store</string>
    <key>teamID</key>
    <string>9FY62NTL53</string>
    <key>uploadBitcode</key>
    <false/>
    <key>uploadSymbols</key>
    <true/>
    <key>signingStyle</key>
    <string>automatic</string>
    <key>provisioningProfiles</key>
    <dict>
        <key>com.flowai.health</key>
        <string>Flow Ai App Store Distribution</string>
    </dict>
</dict>
</plist>
```

Create this file if missing:

```bash
cat > ios/ExportOptions.plist << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>method</key>
    <string>app-store</string>
    <key>teamID</key>
    <string>9FY62NTL53</string>
    <key>uploadBitcode</key>
    <false/>
    <key>uploadSymbols</key>
    <true/>
    <key>signingStyle</key>
    <string>automatic</string>
</dict>
</plist>
EOF
```

---

## 🚀 Recommended Workflow

**Best approach for first-time App Store submission**:

### Step 1: Use Xcode Automatic Signing
```bash
# Open workspace
open ios/Runner.xcworkspace
```

### Step 2: Archive in Xcode
1. Menu: **Product** → **Scheme** → Select **Runner**
2. Menu: **Product** → **Destination** → Select **Any iOS Device (arm64)**
3. Menu: **Product** → **Archive**
4. Wait for archive to complete (~5 minutes)

### Step 3: Distribute from Organizer
1. **Organizer** opens automatically after archive
2. Click **Distribute App**
3. Select **App Store Connect**
4. Select **Upload**
5. Choose **Automatically manage signing**
6. Click **Upload**

This is the **easiest and most reliable** method for first App Store submission.

---

## 🐛 Common Issues & Solutions

### Issue: "No valid signing identities found"
**Solution**: Create Distribution certificate in Apple Developer Portal (Option 2 above)

### Issue: "Provisioning profile doesn't include signing certificate"
**Solution**: 
1. Delete old profiles: `rm ~/Library/MobileDevice/Provisioning\ Profiles/*`
2. Refresh profiles in Xcode: Preferences → Accounts → Download Manual Profiles

### Issue: "Xcode can't download provisioning profiles"
**Solution**:
1. Sign out of Apple ID in Xcode
2. Sign back in
3. Let Xcode re-sync

### Issue: "Team has no distribution certificate"
**Solution**: Admin of team must create certificate or give you admin access

---

## ✅ Success Checklist

After following Option 1 (Xcode Automatic):
- [ ] Xcode downloaded/created Distribution certificate
- [ ] Xcode created App Store provisioning profile
- [ ] Archive succeeded in Xcode
- [ ] "Distribute App" showed no errors
- [ ] Upload completed successfully
- [ ] Email received from Apple confirming upload
- [ ] Build appears in App Store Connect within 15 minutes

---

## 📞 Need Help?

### Apple Resources
- **Certificates Portal**: https://developer.apple.com/account/resources/certificates
- **Profiles Portal**: https://developer.apple.com/account/resources/profiles
- **App Store Connect**: https://appstoreconnect.apple.com

### Team Information
- **Team ID**: 9FY62NTL53
- **Bundle ID**: com.flowai.health
- **Apple ID**: 6751801915
- **SKU**: flowai-health-ios-v2024

---

## 🎯 Next Steps

**Right now, follow Option 1**:

1. Open Terminal:
   ```bash
   cd /Users/ronos/Workspace/Projects/Active/ZyraFlow
   open ios/Runner.xcworkspace
   ```

2. In Xcode:
   - Enable "Automatically manage signing"
   - Select Team: 9FY62NTL53
   - **Product** → **Archive**
   - **Distribute App** → **App Store Connect** → **Upload**

3. Wait for email from Apple

4. Go to App Store Connect and submit for review

**This is the simplest path to App Store submission!** ✅

---

**Last Updated**: January 14, 2025  
**Status**: Awaiting Distribution Certificate Setup
