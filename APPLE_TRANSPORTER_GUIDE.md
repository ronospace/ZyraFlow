# 📦 Apple Transporter Submission Guide - Flow Ai

**Date**: January 14, 2025  
**Version**: 2.1.2 (Build 16)  
**IPA File**: `Flow Ai.ipa` (16 MB)  
**Status**: ✅ Ready for Upload

---

## 📱 App Information

### App Details
- **App Name**: Flow Ai
- **Bundle ID**: `com.flowai.health`
- **Version**: 2.1.2
- **Build Number**: 16
- **SKU**: flowai-health-ios-v2024
- **Apple ID**: 6751801915

### Signing
- **Team**: 9FY62NTL53
- **Signing**: Automatic (managed by Xcode)
- **Deployment Target**: iOS 16.0+

---

## 🚀 Upload to App Store via Transporter

### Step 1: Open Transporter App
1. Open **Transporter** app on your Mac
2. If not installed, download from Mac App Store

### Step 2: Sign In
1. Sign in with your **Apple Developer Account**
2. Ensure you have access to the app in App Store Connect

### Step 3: Add IPA File
1. **Drag and drop** `Flow Ai.ipa` into Transporter window
2. **OR** Click **+** button and select the IPA file

**IPA Location**: `/Users/ronos/Workspace/Projects/Active/ZyraFlow/build/ios/ipa/Flow Ai.ipa`

### Step 4: Verify App Information
Transporter will show:
- ✅ **App Name**: Flow Ai
- ✅ **Bundle Identifier**: com.flowai.health
- ✅ **Version**: 2.1.2
- ✅ **Build**: 16
- ✅ **File Size**: ~16 MB

### Step 5: Deliver to App Store
1. Click **"Deliver"** button
2. Wait for upload to complete (may take 2-10 minutes)
3. Watch for validation errors

### Step 6: Confirm Upload
After successful upload:
- ✅ Transporter shows **"Delivered"** status
- ✅ You'll receive email confirmation from Apple
- ✅ Build appears in App Store Connect within 5-15 minutes

---

## 🧪 Test Accounts for App Review

**Important**: Include these test accounts in App Store Connect for Apple reviewers.

### Primary Test Account (Recommended for Apple Review)
```
📧 Email: demo@flowai.app
🔑 Password: FlowAiDemo2025!
👤 Profile: Full features, 6 months pre-loaded data
```

### Alternative Test Accounts

**Active User Account**:
```
📧 Email: tester1@flowai.app
🔑 Password: FlowTest2025!
```

**New User Account**:
```
📧 Email: tester2@flowai.app
🔑 Password: FlowTest2025!
```

**Clean Slate (Onboarding)**:
```
📧 Email: qa@flowai.app
🔑 Password: FlowQA2025!
```

---

## 📝 App Store Connect Configuration

### After Upload Success

1. **Go to App Store Connect**
   - Visit: https://appstoreconnect.apple.com
   - Navigate to: **My Apps** → **Flow Ai**

2. **Select Build**
   - Go to **TestFlight** or **App Store** tab
   - Wait for build to appear (5-15 minutes)
   - Select **Build 16 (2.1.2)**

3. **Add Build to Version**
   - Under **App Store** tab
   - Click **+ Version** if new version
   - Or select existing version
   - Click **Build** and select **2.1.2 (16)**

4. **Complete App Information**
   - Screenshots (if needed)
   - App description
   - Keywords
   - Privacy policy URL
   - Support URL

5. **Add Test Account Info**
   - Under **App Review Information**
   - Add **demo@flowai.app / FlowAiDemo2025!**
   - Add notes about test accounts

6. **Submit for Review**
   - Click **Submit for Review**
   - Answer export compliance questions
   - Wait for Apple review (1-3 days typically)

---

## 🐛 Troubleshooting Transporter Issues

### Error: "Bundle version must be higher than previously uploaded"
**Solution**: ✅ **FIXED** - Build number incremented to 16

### Error: "No suitable application records were found"
**Possible Causes**:
- Wrong Bundle ID
- Not signed in with correct Apple ID
- App not created in App Store Connect

**Solution**:
1. Verify Bundle ID: `com.flowai.health`
2. Check App Store Connect for app existence
3. Sign in with correct developer account

### Error: "Invalid signature"
**Solution**:
1. Clean build: `flutter clean`
2. Rebuild: `flutter build ipa --release`
3. Verify signing in Xcode

### Error: "Asset validation failed"
**Known Issue**: Launch image placeholder warning (non-critical)
**Action**: Can be fixed in future build, doesn't block submission

### Upload Stuck or Slow
**Solution**:
- Check internet connection
- Try uploading during off-peak hours
- Close and reopen Transporter
- Try `xcrun altool` command-line alternative

---

## 📊 Build Information Summary

| Property | Value |
|----------|-------|
| **IPA File** | Flow Ai.ipa |
| **File Size** | 16 MB |
| **Version** | 2.1.2 |
| **Build Number** | 16 |
| **Bundle ID** | com.flowai.health |
| **Min iOS** | 16.0 |
| **Archive Size** | 243 MB |
| **Signing** | Automatic (Team 9FY62NTL53) |

---

## ✅ Pre-Upload Checklist

- [x] Build number incremented (13 → 16)
- [x] IPA built successfully (16 MB)
- [x] IPA file located and ready
- [x] Test accounts documented
- [x] Bundle ID verified (com.flowai.health)
- [x] Version verified (2.1.2)
- [ ] Signed into Transporter with correct Apple ID
- [ ] IPA uploaded via Transporter
- [ ] Build appears in App Store Connect
- [ ] Build added to app version
- [ ] Test account info added to App Review
- [ ] Submitted for review

---

## 🎯 Post-Upload Actions

### Immediate (After Upload Success)
1. ✅ Verify build appears in App Store Connect
2. ✅ Check email for Apple confirmation
3. ✅ Add test account to App Review Information
4. ✅ Complete any missing app metadata

### Before Submission
1. Add/update app screenshots (if needed)
2. Review app description and keywords
3. Verify privacy policy and support URLs
4. Test TestFlight distribution (optional)
5. Add release notes

### After Submission
1. Monitor review status in App Store Connect
2. Respond to any reviewer questions within 24 hours
3. Be ready to provide clarifications
4. Wait for approval (typically 1-3 days)

---

## 📞 Support & Resources

### Apple Resources
- **App Store Connect**: https://appstoreconnect.apple.com
- **Transporter User Guide**: https://help.apple.com/itc/transporteruserguide
- **App Review Guidelines**: https://developer.apple.com/app-store/review/guidelines

### Test Accounts Documentation
- **Complete Guide**: `TESTER_LOGIN_GUIDE_V2.md`
- **Account Details**: `TEST_ACCOUNTS.md`
- **Release Notes**: `BUILD_15_RELEASE_NOTES.md`

### Contact
- **Developer**: ZyraFlow Inc.™
- **Support**: support@flowai.app

---

## 🎉 Ready to Upload!

**Your IPA is ready for Apple Transporter upload!**

**Quick Steps**:
1. Open **Transporter** app
2. **Drag** `Flow Ai.ipa` into window
3. Click **"Deliver"**
4. Wait for confirmation
5. Go to **App Store Connect** and select build
6. Add **demo@flowai.app** test account
7. **Submit for Review**

**IPA Location**: 
```
/Users/ronos/Workspace/Projects/Active/ZyraFlow/build/ios/ipa/Flow Ai.ipa
```

**Finder window already opened** ✅

---

**Last Updated**: January 14, 2025 22:40 UTC  
**Build**: 2.1.2 (16)  
**Status**: Ready for Transporter Upload

*Good luck with your App Store submission! 🚀*
