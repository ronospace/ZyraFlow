# 📋 Flow-Ai Comprehensive TODO List
**Last Updated**: November 22, 2024  
**Priority**: Apple App Store approval first, then features

---

## 🔴 PHASE 1: CRITICAL - APPLE APP STORE FIXES (This Week)

### ✅ Task 1.3: Remove Premium Features from Description [COMPLETED]
**Status**: ✅ DONE  
**Files Modified**:
- `APP_STORE_DESCRIPTION.txt` - Removed premium section, added "ALL FEATURES INCLUDED FREE"
- `APP_STORE_COPY.txt` - Same changes

**Next Action**: Update App Store Connect listing

---

### ⏳ Task 1.1: Add HealthKit UI Identification (Guideline 2.5.1)
**Priority**: 🔴 CRITICAL  
**Estimated Time**: 2-3 hours  
**Status**: ⏳ TODO  

**Files to Modify**:
1. `lib/features/biometric/screens/biometric_dashboard_screen.dart`
2. `lib/features/health/screens/health_sync_screen.dart` (if exists)
3. `lib/features/settings/screens/settings_screen.dart`

**What to Add**:
- [ ] "Connected to Apple Health" badge/indicator
- [ ] Info button explaining HealthKit integration
- [ ] Dialog showing what data is being read
- [ ] Visual indicator when data syncs

**Implementation Guide**: See `APPLE_REJECTION_FIXES.md` lines 24-98

---

### ⏳ Task 1.2: Add Citations to AI Insights (Guideline 1.4.1)
**Priority**: 🔴 CRITICAL  
**Estimated Time**: 4-5 hours  
**Status**: ⏳ TODO  

**Files to Modify**:
1. `lib/features/insights/screens/insights_screen.dart`
2. `lib/features/insights/screens/analytics_dashboard_screen.dart`
3. Create: `lib/features/insights/widgets/citation_button_widget.dart`
4. Create: `lib/features/insights/dialogs/citation_dialog.dart`

**What to Add**:
- [ ] Citation button (science icon) on every AI insight
- [ ] Citation dialog with sources list
- [ ] Sources for cycle predictions (ACOG, WHO, ML models)
- [ ] Sources for symptom correlations (research papers)
- [ ] Sources for fertility predictions
- [ ] Sources for health condition detection

**Implementation Guide**: See `APPLE_REJECTION_FIXES.md` lines 102-186

---

### ⏳ Task 1.4: Test All Fixes
**Priority**: 🔴 CRITICAL  
**Estimated Time**: 2 hours  
**Status**: ⏳ TODO  

**Testing Checklist**:
- [ ] HealthKit indicators visible on all relevant screens
- [ ] Info dialogs work and explain HealthKit clearly
- [ ] Citation buttons visible on all AI insights
- [ ] Citation dialogs show correct sources
- [ ] No crashes or UI glitches
- [ ] Test on iOS simulator
- [ ] Test on physical iOS device

---

### ⏳ Task 1.5: Build & Submit to Apple
**Priority**: 🔴 CRITICAL  
**Estimated Time**: 1-2 hours  
**Status**: ⏳ TODO  

**Steps**:
- [ ] Increment version in `pubspec.yaml` to `2.1.2+17`
- [ ] Run `flutter clean`
- [ ] Run `flutter pub get`
- [ ] Run `flutter build ipa --release`
- [ ] Open Xcode: `open ios/Runner.xcworkspace`
- [ ] Product → Archive
- [ ] Distribute App → App Store Connect → Upload
- [ ] Open Transporter app
- [ ] Upload IPA
- [ ] Go to App Store Connect
- [ ] Add build 17 to submission
- [ ] Update app description (remove premium features)
- [ ] Add review notes (see `APPLE_REJECTION_FIXES.md` lines 280-305)
- [ ] Submit for review

---

## 🟠 PHASE 2: HIGH PRIORITY USER-REQUESTED FEATURES

### ⏳ Task 2.1: Today's Journal - Enable Multiple Choice Selection
**Priority**: 🟠 HIGH  
**Estimated Time**: 2-3 hours  
**Status**: ⏳ TODO  

**Problem**: Currently, selecting one option makes others disappear. Users want to select multiple symptoms/moods at once.

**Files to Modify**:
1. `lib/features/cycle/screens/tracking_screen.dart` (or wherever journal quick notes is)
2. Look for Radio widgets, replace with CheckboxListTile

**Changes**:
- [ ] Find journal quick notes UI
- [ ] Change from Radio (single-select) to Checkbox (multi-select)
- [ ] Update state management to handle List<String> instead of String
- [ ] Update data model to save multiple selections
- [ ] Test that multiple selections save correctly

**Code Example**:
```dart
// Before: Single select
Radio<String>(
  value: option,
  groupValue: selectedOption,
  onChanged: (value) => setState(() => selectedOption = value),
)

// After: Multi-select
CheckboxListTile(
  title: Text(option),
  value: selectedOptions.contains(option),
  onChanged: (bool? value) {
    setState(() {
      if (value == true) {
        selectedOptions.add(option);
      } else {
        selectedOptions.remove(option);
      }
    });
  },
)
```

---

### ⏳ Task 2.2: Improve Settings Icon Visibility
**Priority**: 🟠 HIGH  
**Estimated Time**: 1-2 hours  
**Status**: ⏳ TODO  

**Problem**: Settings icon is last in bottom nav, almost unnoticeable unless you swipe.

**Current Bottom Nav**: Home → Calendar → Track → Insights → Heart → Settings

**Solution Options**:

**Option A (Quick)**: Make settings icon more prominent
- [ ] Increase icon size
- [ ] Add label "Settings" below icon
- [ ] Use brighter color
- [ ] Add subtle animation

**Option B (Better - RECOMMENDED)**: Add settings button to home screen
- [ ] Add gear icon in top-right of home screen app bar
- [ ] Keep settings in bottom nav too
- [ ] Make it always visible

**Files to Modify**:
1. `lib/features/cycle/screens/home_screen.dart` - Add AppBar actions
2. `lib/core/router/app_router.dart` - Ensure settings route works

**Implementation**:
```dart
// In home_screen.dart AppBar
AppBar(
  title: Text('Flow Ai'),
  actions: [
    IconButton(
      icon: Icon(Icons.settings),
      tooltip: 'Settings',
      onPressed: () => context.go('/settings'),
    ),
  ],
)
```

---

## 🟡 PHASE 3: MEDIUM PRIORITY - AUTH & FLOW-IQ

### ⏳ Task 3.1: Enable Google & Apple Sign In/Up
**Priority**: 🟡 MEDIUM  
**Estimated Time**: 6-8 hours  
**Status**: ⏳ TODO  

**Dependencies to Add**:
```yaml
dependencies:
  google_sign_in: ^6.2.1
  sign_in_with_apple: ^6.1.0
  firebase_auth: ^latest  # if not already added
```

**Files to Modify**:
1. `pubspec.yaml` - Add dependencies
2. `lib/core/services/auth_service.dart` - Add Google/Apple auth methods
3. `lib/features/onboarding/screens/login_screen.dart` - Add sign-in buttons
4. `ios/Runner/Info.plist` - Add URL schemes for Google
5. `android/app/build.gradle` - Add Google services config

**Implementation Steps**:
- [ ] Add dependencies to pubspec.yaml
- [ ] Run `flutter pub get`
- [ ] Configure Google Sign-In in Firebase Console
- [ ] Configure Apple Sign-In (Xcode capabilities)
- [ ] Implement GoogleSignIn in auth_service.dart
- [ ] Implement AppleSignIn in auth_service.dart
- [ ] Add UI buttons to login screen
- [ ] Test on iOS (Apple required for App Store)
- [ ] Test on Android

**Resources**:
- Google Sign-In docs: https://pub.dev/packages/google_sign_in
- Apple Sign-In docs: https://pub.dev/packages/sign_in_with_apple

---

### ⏳ Task 3.2: Enable Flow-iQ Integration Button
**Priority**: 🟡 MEDIUM  
**Estimated Time**: 20-30 hours (major feature)  
**Status**: ⏳ TODO  

**Sub-Tasks**:
1. **Create Flow-iQ API Connection** (8 hours)
   - [ ] Define API endpoints (RESTful or GraphQL)
   - [ ] Create API client service
   - [ ] Implement authentication (JWT tokens)
   - [ ] Test API connectivity

2. **Clinician Account System** (6 hours)
   - [ ] Create clinician registration flow
   - [ ] Clinician login screen
   - [ ] Profile management
   - [ ] Verification system (optional)

3. **Anonymized Dashboard** (6 hours)
   - [ ] Patient list (anonymized IDs)
   - [ ] Population-level statistics
   - [ ] Cycle irregularity alerts
   - [ ] Health trend visualizations

4. **Data Sharing & Consent** (4 hours)
   - [ ] User consent flow (GDPR-compliant)
   - [ ] Data anonymization before sending
   - [ ] User control panel (who has access)
   - [ ] Revoke access functionality

5. **Research Reporting** (3 hours)
   - [ ] Export aggregate data
   - [ ] Research-grade datasets
   - [ ] Statistical reports

6. **Integration Button in Settings** (2 hours)
   - [ ] "Connect to Flow-iQ" section in settings
   - [ ] Status indicator (connected/disconnected)
   - [ ] Manage clinician access screen

**Files to Create/Modify**:
- `lib/core/services/flow_iq_service.dart` - API client
- `lib/features/flow_iq/` - New feature directory
- `lib/features/settings/screens/flow_iq_settings_screen.dart`

**Architecture**:
```
Flow-Ai (Consumer) 
    ↓ REST API
Flow-iQ Backend (Django/FastAPI)
    ↓ PostgreSQL
Clinician Dashboard (Web/React)
```

**Note**: This is a major feature. Break into smaller sprints after Apple approval.

---

## 🟢 PHASE 4: LOWER PRIORITY IMPROVEMENTS

### ⏳ Task 4.1: Firebase Re-enablement
**Priority**: 🟢 LOW  
**Estimated Time**: 4-6 hours  
**Status**: ⏳ BLOCKED (waiting for Firebase SDK fix)  

**Current Issue**: Firebase Core 3.15.2 has Objective-C parse errors on Xcode 15.5+

**When to do**: Wait for Firebase Core 4.x release or Xcode fix

**Steps**:
- [ ] Update Firebase dependencies in pubspec.yaml
- [ ] Uncomment Firebase imports in main.dart
- [ ] Re-configure iOS (ios/Runner/GoogleService-Info.plist)
- [ ] Test Firebase Auth, Firestore, Analytics
- [ ] Enable cloud sync features

---

### ⏳ Task 4.2: Advanced Data Export
**Priority**: 🟢 LOW  
**Estimated Time**: 6-8 hours  
**Status**: ⏳ TODO  

**Features to Add**:
- [ ] PDF reports with graphs and charts
- [ ] CSV export with all cycle data
- [ ] JSON export (already exists?)
- [ ] Chart/graph exports as PNG
- [ ] Email export functionality
- [ ] Date range selection for exports
- [ ] Medical visit templates

**Files to Modify**:
- `lib/core/services/data_export_service.dart` (if exists)
- Create PDF generation with `pdf` package
- Add email functionality with `mailer` package

---

### ⏳ Task 4.3: Notification System Upgrade
**Priority**: 🟢 LOW  
**Estimated Time**: 4-6 hours  
**Status**: ⏳ TODO  

**Features**:
- [ ] Smart notification timing (ML-based)
- [ ] Customizable notification messages
- [ ] Action buttons (log symptom, snooze)
- [ ] Notification history
- [ ] Silent hours (do not disturb)
- [ ] Multiple notification templates

**Files to Modify**:
- `lib/core/services/notification_service.dart`

---

### ⏳ Task 4.4: Dark Mode Polish
**Priority**: 🟢 LOW  
**Estimated Time**: 2-3 hours  
**Status**: ⏳ TODO  

**Tasks**:
- [x] Complete dark theme (DONE)
- [ ] Fine-tune OLED colors
- [ ] Add auto-switch based on time
- [ ] Custom theme colors (future premium?)
- [ ] Improve contrast ratios (accessibility)

---

### ⏳ Task 4.5: Bug Fixes
**Priority**: 🟠 HIGH (but after Apple approval)  
**Estimated Time**: 4-6 hours  
**Status**: ⏳ TODO  

**Known Issues**:
- [ ] Notification delays on Android 14+
- [ ] Dark mode contrast issues on some screens
- [ ] 80 deprecated API warnings
- [ ] Launch image warning on iOS
- [ ] Rare crash on biometric auth failure

---

## 📊 SUMMARY

### **Immediate This Week (Nov 22-25)**
1. ✅ Remove premium from App Store description (DONE)
2. ⏳ Add HealthKit UI indicators
3. ⏳ Add citations to AI insights
4. ⏳ Test all fixes
5. ⏳ Build & submit to Apple (Build 17)

### **After Apple Approval (Week of Dec 1)**
6. ⏳ Journal multi-select fix
7. ⏳ Settings visibility improvement
8. ⏳ Start Google/Apple sign-in

### **December (Longer-term)**
9. ⏳ Flow-iQ integration (multi-week project)
10. ⏳ Bug fixes and polish
11. ⏳ Advanced data export
12. ⏳ Premium features implementation (Option B)

---

## 🎯 Success Metrics

**App Store Approval**: Target within 7 days of resubmission  
**User Satisfaction**: Fix journal & settings issues within 2 weeks  
**Feature Completion**: Flow-iQ integration by end of December  
**Thesis Integration**: Research data collection begins after approval (30-100 users)

---

## 📁 Key Documents Reference

- `APPLE_REJECTION_FIXES.md` - Detailed Apple fix implementation
- `FLOW_AI_STATUS_REPORT.md` - Overall project status
- `MISSIONS_PENDING.md` - Original feature backlog
- `COMING_SOON.md` - Long-term roadmap
- `THESIS_FINAL_REALISTIC.md` - Academic thesis (separate from app dev)

---

**Last Updated**: November 22, 2024  
**Next Review**: November 23, 2024 (after HealthKit & Citations implemented)  
**Owner**: Geoffrey Rono (solo developer)

---

## ✅ Quick Action Checklist (Today)

- [x] Create comprehensive todo list
- [x] Remove premium from App Store description
- [ ] Commit changes to git (don't create new branches)
- [ ] Start HealthKit UI implementation
- [ ] Start citations implementation
- [ ] Test fixes tomorrow
- [ ] Build 17 & submit by Nov 25

---

**Focus**: Get Apple approval first. Everything else waits.
