# 🔐 Flow Ai Test Accounts

**Last Updated**: January 14, 2025 02:11 UTC  
**App Version**: 2.1.2 (Build 14)  
**Status**: ✅ Multiple Pre-registered Accounts Available

---

## 📧 Pre-Registered Test Accounts

These accounts are **automatically created** when the app starts. Testers can login immediately without creating new accounts.

### Account 1: Demo Reviewer (Full Features)
```
📧 Email: demo@flowai.app
🔑 Password: FlowAiDemo2025!
👤 Name: Demo User for App Review
```
**Pre-loaded Data**:
- ✅ 6 months of realistic cycle data
- ✅ Sample symptoms and mood logs
- ✅ AI predictions calibrated
- ✅ Onboarding completed

**Use Case**: App Store reviewers, quick feature testing

---

### Account 2: Test User 1 (Active Tracker)
```
📧 Email: tester1@flowai.app
🔑 Password: FlowTest2025!
👤 Name: Sarah Test User
```
**Pre-loaded Data**:
- ✅ 3 months of cycle data
- ✅ Regular symptom tracking
- ✅ Moderate AI prediction history
- ✅ Onboarding completed

**Use Case**: QA testing, regular user simulation

---

### Account 3: Test User 2 (New User)
```
📧 Email: tester2@flowai.app
🔑 Password: FlowTest2025!
👤 Name: Emma Test User
```
**Pre-loaded Data**:
- ✅ 1 month of cycle data
- ✅ Minimal symptom logs
- ✅ Fresh AI predictions
- ✅ Onboarding completed

**Use Case**: New user experience testing

---

### Account 4: QA Tester (Clean Slate)
```
📧 Email: qa@flowai.app
🔑 Password: FlowQA2025!
👤 Name: QA Test Account
```
**Pre-loaded Data**:
- ❌ NO pre-loaded data
- ✅ Onboarding NOT completed
- ✅ Clean slate for testing onboarding flow

**Use Case**: Testing first-time user experience, onboarding flow

---

### Account 5: Developer Test (Debug)
```
📧 Email: dev@flowai.app
🔑 Password: FlowDev2025!
👤 Name: Developer Test Account
```
**Pre-loaded Data**:
- ✅ 12 months of comprehensive data
- ✅ All symptom types logged
- ✅ Full AI prediction history
- ✅ All features enabled

**Use Case**: Developer testing, edge case scenarios

---

## 🔄 Account Persistence

**How It Works**:
- All accounts are created on **first app launch**
- Stored in local SQLite database
- **Persist across app restarts**
- **Survive app updates**
- Independent of Firebase (works offline)

**Data Isolation**:
- Each account has completely separate data
- Logging out preserves account data
- Logging into different account switches context
- No data mixing between accounts

---

## 🧪 Testing Workflow

### Test Account Login
1. **Launch Flow Ai app**
2. **Choose any test account** from list above
3. **Enter credentials** on login screen
4. **Tap Sign In**
5. **Explore features** with pre-loaded data

### Test Account Switching
1. **Settings** → **Account Management**
2. **Tap Sign Out**
3. **Login with different test account**
4. **Verify data is different**

### Test New User Flow
1. **Use QA account** (qa@flowai.app)
2. **Experience complete onboarding**
3. **Add first cycle manually**
4. **Watch AI learn over time**

---

## 🔐 Password Reset

**Current Status**: Not implemented yet

**Workaround**: Test accounts have fixed passwords (listed above). If testing password reset flow, create a custom account with email signup.

---

## 📊 Account Data Summary

| Account | Email | Cycle Data | Symptoms | AI Ready | Onboarding |
|---------|-------|------------|----------|----------|------------|
| **Demo** | demo@flowai.app | 6 months | Full | ✅ Yes | ✅ Done |
| **Tester 1** | tester1@flowai.app | 3 months | Regular | ✅ Yes | ✅ Done |
| **Tester 2** | tester2@flowai.app | 1 month | Minimal | ⚠️ Learning | ✅ Done |
| **QA** | qa@flowai.app | None | None | ❌ No | ❌ Not Done |
| **Dev** | dev@flowai.app | 12 months | Complete | ✅ Yes | ✅ Done |

---

## 🎯 Use Cases by Account

### **App Store Review** → Use **demo@flowai.app**
- Full features visible immediately
- Rich data for all app sections
- No setup required

### **QA Testing** → Use **tester1@flowai.app** or **tester2@flowai.app**
- Realistic user data
- Multiple data states for testing
- Typical user experience

### **Onboarding Testing** → Use **qa@flowai.app**
- Clean slate
- Test first-time user flow
- Verify onboarding steps

### **Developer/Edge Cases** → Use **dev@flowai.app**
- Maximum data for stress testing
- All features populated
- Edge case scenarios

---

## 🚨 Important Notes

### Account Creation
- ✅ **Automatic**: All accounts created on first launch
- ✅ **Persistent**: Accounts remain after logout
- ✅ **Reliable**: Local storage, no internet required
- ✅ **Isolated**: Each account has separate data

### Session Management
- **30-day sessions**: Stay logged in for convenience
- **Manual logout**: Available in Settings
- **Auto-logout**: After 30 days of inactivity
- **Re-login**: Use same credentials anytime

### Data Management
- **Logout**: Preserves account data
- **Delete Account**: Removes all data permanently
- **Switch Accounts**: Instant context switching
- **Export Data**: Available for all accounts

---

## 🐛 Troubleshooting

### "No account found with this email"
**Solution**:
- Force close and reopen app (triggers account creation)
- Check spelling of email (case-insensitive)
- Wait 5 seconds after app launch for initialization
- Check debug logs for account creation confirmation

### "Invalid password"
**Solution**:
- Passwords are **case-sensitive**
- Copy exact password from this document
- Check Caps Lock is OFF
- Try demo@flowai.app / FlowAiDemo2025! first

### Accounts not appearing
**Solution**:
1. Uninstall app completely
2. Reinstall fresh APK
3. Launch app and wait 10 seconds
4. Check debug logs: should see "✅ Test accounts created"

### Data not persisting after logout
**Solution**:
- This is **expected behavior** - accounts persist, data persists
- Login again with same credentials to restore data
- Each account maintains its own data independently

---

## 🔧 For Developers

### Account Creation Code
Located in: `lib/core/services/local_user_service.dart`

Method: `_ensureTestAccountsExist()`

### Debug Logging
When app starts, check logs for:
```
✅ Demo account verified: demo@flowai.app
✅ Test account 1 verified: tester1@flowai.app  
✅ Test account 2 verified: tester2@flowai.app
✅ QA account verified: qa@flowai.app
✅ Dev account verified: dev@flowai.app
```

### Manual Account Creation
If needed, testers can still create custom accounts:
1. Tap "Create Account" on login screen
2. Enter any email + password
3. Complete setup
4. Custom account works alongside test accounts

---

## 📞 Support

### Issues with Test Accounts
- **Email**: support@flowai.app
- **GitHub**: https://github.com/ronospace/ZyraFlow/issues
- **Documentation**: See TESTER_LOGIN_GUIDE.md

### Share These Credentials
All test accounts can be safely shared with:
- ✅ App Store reviewers
- ✅ QA testers
- ✅ Beta users
- ✅ Development team
- ✅ Stakeholders

**Passwords are public** - these are test accounts only, no real user data.

---

## ✅ Quick Reference Card

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        FLOW AI TEST ACCOUNTS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎭 DEMO (Full Features)
   demo@flowai.app / FlowAiDemo2025!

👤 TESTER 1 (Active User)
   tester1@flowai.app / FlowTest2025!

👤 TESTER 2 (New User)
   tester2@flowai.app / FlowTest2025!

🔬 QA (Clean Slate)
   qa@flowai.app / FlowQA2025!

💻 DEV (All Features)
   dev@flowai.app / FlowDev2025!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
All accounts auto-created on first launch
Persist across sessions • Work offline
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

**Last Updated**: January 14, 2025 02:11 UTC  
**Next Build**: Will include all 5 test accounts  
**Status**: Ready for distribution to testers
