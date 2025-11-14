# 🔐 Tester Login Guide - Flow Ai v2.1.2

**Last Updated**: January 14, 2025 01:33 UTC  
**App Version**: 2.1.2 (Build 13+)  
**Authentication**: Local Offline-First System  
**Status**: ✅ Demo Account Fixed & Verified

---

## 🎯 Quick Start for Testers

### **Option 1: Demo Account (Recommended for Quick Testing)**

The app **automatically creates and verifies** a demo account on EVERY app launch:

```
📧 Email: demo@flowai.app
🔑 Password: FlowAiDemo2025!
```

**✅ VERIFIED WORKING** - Demo account is now created/verified on every app start with explicit debug logging.

**Pre-loaded Features**:
- ✅ 6 months of sample cycle data
- ✅ AI predictions already calibrated
- ✅ Sample symptoms and notes
- ✅ Onboarding already completed
- ✅ All features immediately accessible

**How to Use**:
1. Launch Flow Ai app
2. On login screen, enter:
   - Email: `demo@flowai.app`
   - Password: `FlowAiDemo2025!`
3. Tap **Sign In**
4. Start exploring immediately!

---

## 👤 Option 2: Create Your Own Account

For personalized testing with your own data:

### Steps to Create Account:

1. **Launch App** - Open Flow Ai on your device
2. **Tap "Create Account"** or "Sign Up"
3. **Enter Details**:
   - Email: `your.email@example.com`
   - Display Name: `Your Name`
   - Password: `YourSecurePassword`
   - Confirm Password
4. **Tap "Create Account"**
5. **Complete Onboarding** (or skip):
   - Choose "Use Demo Data" for instant preview
   - OR "Complete Setup" for personalized experience

### Account Features:
- ✅ **Local Storage**: All data stored on device
- ✅ **Privacy-First**: No cloud sync required
- ✅ **Data Isolation**: Each account has separate data
- ✅ **Biometric Auth**: Enable Face ID/Touch ID after setup
- ✅ **30-Day Session**: Stay logged in for convenience

---

## 🔒 Authentication System

### How It Works

**Local Offline-First**:
- All user data stored locally using SharedPreferences
- No internet connection required for login
- No Firebase authentication (iOS build optimization)
- Accounts are device-specific

**Session Management**:
- **Session Duration**: 30 days
- **Auto-Login**: Enabled if session valid
- **Secure Storage**: Password hashed (not stored in plain text)
- **Multi-Account**: Create multiple accounts on same device

### Account Types

| Type | Email | Password | Pre-loaded Data | Best For |
|------|-------|----------|-----------------|----------|
| **Demo** | demo@flowai.app | FlowAiDemo2025! | ✅ 6 months | Quick review |
| **Personal** | Your email | Your password | ❌ Clean slate | Full testing |

---

## 📱 First Launch Flow

### Scenario A: First-Time User

1. **App Opens** → Welcome/Splash screen
2. **Onboarding Prompt** → "Welcome to Flow Ai"
3. **Choose Path**:
   - **"Use Demo Data"** → Auto-login as demo user
   - **"Get Started"** → Create account or sign in
4. **Setup Complete** → Access main app

### Scenario B: Returning User

1. **App Opens** → Auto-login (if session valid)
2. **Direct to Home** → Calendar/Dashboard view
3. **No Login Required** → Seamless experience

### Scenario C: Session Expired

1. **App Opens** → Login screen
2. **Enter Credentials** → Email + Password
3. **Tap Sign In** → Restore previous session
4. **Data Restored** → All previous data available

---

## 🧪 Testing Scenarios

### Test 1: Demo Account Login
```
✅ Use: demo@flowai.app / FlowAiDemo2025!
✅ Verify: Pre-loaded cycle data appears
✅ Check: AI predictions display
✅ Test: All features accessible
```

### Test 2: New Account Creation
```
✅ Create: New account with unique email
✅ Verify: Clean slate (no pre-existing data)
✅ Complete: Onboarding flow
✅ Add: First cycle data manually
```

### Test 3: Multiple Accounts
```
✅ Create: Account A (user1@test.com)
✅ Sign Out
✅ Create: Account B (user2@test.com)
✅ Sign Out
✅ Sign In: As Account A
✅ Verify: Account A's data loads (data isolation)
```

### Test 4: Session Persistence
```
✅ Sign In: Any account
✅ Close: App completely
✅ Re-open: App
✅ Verify: Auto-logged in (no login screen)
✅ Data: Previous session data intact
```

### Test 5: Password Reset
```
⚠️ Currently: Manual account recreation required
❌ Reset: Feature not yet implemented
✅ Workaround: Create new account with different email
```

---

## 🎭 Demo Account Details

### Pre-configured Profile

**User Information**:
- **Name**: Demo User for App Review
- **Username**: demo_reviewer
- **Age**: 28 years old
- **Account Created**: Auto-generated on app first launch

**Cycle Data**:
- **Average Cycle**: 28 days
- **Last Period**: 15 days ago (from today)
- **Tracking Duration**: 6 months simulated
- **Data Quality**: Realistic sample data

**Sample Content**:
```
📝 Notes:
- "Welcome to Flow Ai! This is a demo account..."
- "You can explore all features..."
- "This account has sample data..."

🩺 Symptoms:
- "Mild cramping (Day 1)"
- "Light flow (Day 2-3)"  
- "Energy boost (Day 7)"
```

**Onboarding Status**: ✅ Completed (skip onboarding)

---

## 🔓 Account Management

### Sign Out
1. Open **Settings**
2. Scroll to **Account Management**
3. Tap **Sign Out**
4. Confirm sign out
5. Returns to login screen

### Switch Accounts
1. Sign out from current account
2. On login screen, enter different credentials
3. Sign in to different account
4. Data switches to new account context

### Account Data Export
1. **Settings** → **Account Management**
2. Tap **Export My Data**
3. Choose format: PDF, CSV, or JSON
4. Share via email/cloud
5. All cycle data exported

### Delete Account
1. **Settings** → **Account Management**
2. Scroll to **Danger Zone**
3. Tap **Delete Account**
4. Confirm deletion
5. All data permanently removed

---

## 🐛 Troubleshooting Login Issues

### "No account found with this email"
**Solution**:
- Check email spelling (case-insensitive)
- Ensure account was created on THIS device
- Try creating new account

### "Invalid password"
**Solution**:
- Re-enter password carefully
- Check Caps Lock is off
- Passwords are case-sensitive
- For demo account: exact password is `FlowAiDemo2025!`

### "Local storage not initialized"
**Solution**:
- Force close and reopen app
- Clear app cache (Settings > Clear Cache)
- Reinstall app if persists

### Auto-login not working
**Solution**:
- Session may have expired (30 days)
- App cache may have been cleared
- Just sign in again manually

### Demo account not found
**Solution**:
- Should auto-create on first app launch
- If missing, create manually with exact credentials
- Force close and reopen app to trigger auto-creation

---

## 📊 Account Features Overview

### Available in All Accounts

| Feature | Description | Demo | Personal |
|---------|-------------|------|----------|
| **Cycle Tracking** | Log periods, symptoms, mood | ✅ Pre-filled | ✅ Manual |
| **AI Predictions** | Cycle forecasts, insights | ✅ Ready | ✅ After 3 cycles |
| **Calendar View** | Visual cycle timeline | ✅ | ✅ |
| **Health Dashboard** | Biometric data, analytics | ✅ | ✅ |
| **AI Assistant** | Chat with Zyra AI | ✅ | ✅ |
| **Settings** | Themes, language, preferences | ✅ | ✅ |
| **Biometric Lock** | Face ID/Touch ID security | ✅ | ✅ |
| **Data Export** | PDF/CSV/JSON export | ✅ | ✅ |
| **Multi-Language** | 36 languages supported | ✅ | ✅ |

---

## 🔐 Security Features

### Password Requirements
- **Minimum Length**: 6 characters (recommended: 12+)
- **Complexity**: No specific requirements (demo purposes)
- **Storage**: Hashed (not plain text)
- **Recovery**: Not yet implemented

### Biometric Authentication
- **Face ID** (iOS): Enable in Settings > Privacy
- **Touch ID** (iOS): Enable in Settings > Privacy
- **Fingerprint** (Android): Enable in Settings > Privacy
- **Quick Unlock**: Use biometric instead of password

### Session Security
- **Duration**: 30 days auto-logout
- **Device-Specific**: Sessions don't sync across devices
- **Manual Logout**: Available anytime in Settings
- **Data Encryption**: Local data stored securely

---

## 📞 Support for Testers

### Need Help?
- **In-App Help**: Settings → Help & Support
- **Email**: support@flowai.app
- **Demo Issues**: Check password exact match: `FlowAiDemo2025!`
- **Account Issues**: Create new account or use demo

### Testing Checklist
- [ ] Login with demo account
- [ ] Explore pre-loaded data
- [ ] Create personal account
- [ ] Complete onboarding
- [ ] Log first cycle
- [ ] Check AI predictions
- [ ] Test biometric auth
- [ ] Try theme switching
- [ ] Test multi-language
- [ ] Export data
- [ ] Sign out and back in

---

## 🎉 Ready to Test!

### Quick Commands

**Demo Login**:
```
Email: demo@flowai.app
Password: FlowAiDemo2025!
Tap: Sign In
```

**New Account**:
```
Tap: Create Account
Enter: Your details
Tap: Create Account
Choose: Demo data or manual setup
```

**Fast Testing**:
```
1. Use demo account (instant access)
2. Explore all features
3. No onboarding delays
4. Full functionality preview
```

---

**Last Updated**: January 14, 2025  
**App Version**: Flow Ai v2.1.2 (Build 13)  
**Developer**: ZyraFlow Inc.™

*For App Store reviewers and quality assurance testers*
