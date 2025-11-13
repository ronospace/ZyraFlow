# Flow AI v1.0 - Comprehensive Implementation Guide

**Document Version:** 1.0  
**Created:** November 13, 2025  
**Project:** Flow AI (formerly Flow iQ)  
**Target:** App Store Resubmission & v1.0 Release  
**Bundle ID:** com.flowai.health  
**Apple ID:** 6751801915  

---

## Executive Summary

This document provides a comprehensive, phase-based implementation plan to address all outstanding issues for Flow AI v1.0, focusing on App Store compliance, rebranding consistency, UX improvements, and new feature additions. The plan is organized into 4 phases with clear priorities, dependencies, and estimated effort.

**Current Status:**
- App rejected by Apple (Guideline 1.4.1 - Missing medical citations)
- Bundle ID mismatch reported by Transporter
- Multiple branding inconsistencies (CycleSync, FlowSense, Mira)
- UX improvements needed (Settings organization, AI assistant, account management)
- New features requested (Water reminders, exercise recommendations, enhanced health dashboard)

**Success Criteria:**
- ✅ App Store approval and successful submission
- ✅ Complete rebranding consistency (Flow AI, Flow iQ, Zyra, ZyraFlow Inc.)
- ✅ Enhanced user experience with improved settings and AI interaction
- ✅ New health features integrated and functional
- ✅ No debug configurations, release-ready builds only

---

## Phase 1: Critical App Store Compliance (Priority: URGENT)
**Estimated Effort:** 8-12 hours  
**Target Completion:** Before resubmission  
**Blocking:** App Store approval

### 1.1 Medical Citations System (CRITICAL - App Store Blocker)

**Issue:** Guideline 1.4.1 violation - AI Insights lack medical citations

**Current State:**
- AI Insights display health recommendations without source attribution
- No clickable citations or reference links
- Users cannot verify information accuracy

**Required Changes:**

#### A. Create Medical Citation Models
**File:** `lib/core/models/medical_citation.dart` (Already exists, verify structure)

```dart
class MedicalCitation {
  final String id;
  final String title;
  final String source;
  final String url;
  final String organization;
  final int year;
  final CitationType type;
  
  // Predefined citation sets for different health topics
  static final List<MedicalCitation> cyclePredictionCitations = [...];
  static final List<MedicalCitation> symptomCitations = [...];
  static final List<MedicalCitation> fertilityWindowCitations = [...];
  static final List<MedicalCitation> healthConditionCitations = [...];
}

enum CitationType {
  clinicalStudy,
  medicalGuideline,
  peerReviewedJournal,
  healthOrganization,
}
```

**Citations to Add:**
1. **ACOG** (American College of Obstetricians and Gynecologists)
   - Committee Opinion 651: Menstrual Cycle as Vital Sign
   - URL: https://www.acog.org/clinical/clinical-guidance/committee-opinion/articles/2015/12/menstruation-in-girls-and-adolescents-using-the-menstrual-cycle-as-a-vital-sign

2. **WHO** (World Health Organization)
   - Reproductive Health Guidelines
   - URL: https://www.who.int/health-topics/reproductive-health

3. **NIH** (National Institutes of Health)
   - Menstrual Cycle Research
   - URL: https://www.nichd.nih.gov/health/topics/menstruation

4. **Mayo Clinic**
   - Menstrual Cycle Information
   - URL: https://www.mayoclinic.org/healthy-lifestyle/womens-health

5. **Journal References:**
   - Bull et al. (2019) - npj Digital Medicine: "Real-world menstrual cycle characteristics"
   - Fraser et al. (2011) - Seminars in Reproductive Medicine: "FIGO terminology for uterine bleeding"

#### B. Update AI Insight Widgets with Citations

**Files to Modify:**
1. `lib/features/insights/widgets/ai_insight_card.dart`
2. `lib/features/insights/widgets/cycle_regularity_card.dart`
3. `lib/features/insights/widgets/prediction_accuracy_card.dart`
4. `lib/features/insights/widgets/symptom_prediction_card.dart`
5. `lib/features/insights/widgets/fertility_window_card.dart`
6. `lib/features/insights/widgets/health_condition_card.dart`
7. `lib/features/ml/widgets/ml_insight_card.dart`

**Implementation Pattern:**
```dart
// Add to each AI Insight Card
Widget _buildCitationSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Divider(height: 24),
      Row(
        children: [
          Icon(Icons.library_books, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Text(
            'Medical Sources',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
      const SizedBox(height: 8),
      CitationWidget(citations: MedicalCitation.cyclePredictionCitations),
    ],
  );
}
```

#### C. Create Citation Display Widget

**File:** `lib/core/widgets/citation_widget.dart` (Already exists, verify implementation)

**Features:**
- Collapsible citation list
- Clickable external links
- Organization badges (ACOG, WHO, NIH)
- "View All Sources" button
- Full citation dialog with detailed information

#### D. Add Medical Disclaimer

**Update Files:**
- `lib/l10n/app_en.arb` (add disclaimer keys)
- All AI Insight screens

**Disclaimer Text:**
```
"This information is for educational purposes only and should not replace professional medical advice. Always consult your healthcare provider for personalized guidance."
```

**Display Requirements:**
- Visible on every AI Insight screen
- Prominent placement (top or bottom of card)
- Cannot be dismissed permanently
- Small info icon with full text on tap

#### E. Testing Requirements

- [ ] All AI Insights display citations
- [ ] Citations are clickable and open external URLs
- [ ] Disclaimer visible on all health-related screens
- [ ] Citation dialog displays complete information
- [ ] Works on iOS, Android, and Web
- [ ] Complies with App Store guidelines

**Acceptance Criteria:**
✅ Medical citations present on 100% of AI Insights  
✅ Citations easily discoverable (1-2 taps maximum)  
✅ External links work correctly  
✅ Disclaimer visible and clear  
✅ Passes App Store review

---

### 1.2 Bundle ID Verification & Clean Build

**Issue:** Transporter error - "No suitable application records found. Verify that your bundle identifier 'com.flowai.health.flowAi' is correct"

**Current Bundle ID Configuration:**
- **Correct:** `com.flowai.health`
- **Reported Error:** `com.flowai.health.flowAi`

**Investigation Required:**

#### A. Check iOS Project Settings
**File:** `ios/Runner.xcodeproj/project.pbxproj`

**Verify in all configurations:**
- Line 515 (Profile): `PRODUCT_BUNDLE_IDENTIFIER = com.flowai.health;` ✅ CORRECT
- Line 532 (Debug Tests): `com.flowai.health.RunnerTests`
- Line 550 (Release Tests): `com.flowai.health.RunnerTests`
- Line 567 (Profile Tests): `com.flowai.health.RunnerTests`

**Check for any `.flowAi` suffixes:**
```bash
grep -r "com.flowai.health.flowAi" ios/
grep -r "flowAi" ios/Runner.xcodeproj/
```

#### B. Clean Build Configuration

**Files to Check:**
1. `ios/Runner/Info.plist`
   - CFBundleIdentifier: Should reference `$(PRODUCT_BUNDLE_IDENTIFIER)`
   - Line 62: Currently correct

2. `ios/Flutter/Debug.xcconfig`
3. `ios/Flutter/Release.xcconfig`
4. `ios/Flutter/Profile.xcconfig`

#### C. Clean Build Process

**Commands to Execute:**
```bash
# Clean Flutter build
flutter clean

# Remove iOS build artifacts
rm -rf ios/Pods
rm -rf ios/.symlinks
rm -rf ios/Podfile.lock
rm -rf ios/build
rm -rf build/ios

# Clean Xcode derived data
rm -rf ~/Library/Developer/Xcode/DerivedData/Runner-*

# Reinstall dependencies
flutter pub get
cd ios && pod install --repo-update && cd ..

# Build release archive
flutter build ios --release --no-codesign
```

#### D. Verification Steps

1. Open Xcode: `open ios/Runner.xcworkspace`
2. Select "Runner" target
3. Go to "Signing & Capabilities"
4. Verify Bundle Identifier: `com.flowai.health`
5. Check all build configurations (Debug, Release, Profile)
6. Archive the app: Product > Archive
7. Distribute App > App Store Connect
8. Upload and verify in App Store Connect

**Acceptance Criteria:**
✅ No bundle ID warnings in Xcode  
✅ Successful archive creation  
✅ Transporter accepts IPA without errors  
✅ App appears in App Store Connect under correct bundle ID

---

### 1.3 Firebase Authentication for App Review

**Issue:** Currently using hardcoded demo account. Need to use real Firebase user for App Store reviewers.

**Current Demo Account:**
- Email: `demo@flowai.app`
- Password: `FlowAiDemo2025!`

**Proposed Solution:** Use real Firebase user

#### A. Firebase User Setup

**Access Firebase Console:**
1. Open: https://console.firebase.google.com
2. Select Flow AI project
3. Go to Authentication > Users
4. Find or create reviewer account

**Recommended Reviewer Account:**
- Email: `reviewer@flowai.app` OR existing Firebase user
- Password: Strong, secure password (not in code)
- Populated with realistic demo data

#### B. Update Demo Account Documentation

**File:** `APPLE_DEMO_LOGS.txt`

**Update to:**
```
Flow AI - App Store Reviewer Credentials

Login Method: Firebase Email/Password Authentication

Account 1 (Primary):
Email: [FIREBASE_USER_EMAIL]
Password: [PROVIDED_SEPARATELY]

Account 2 (Backup):
Email: ronos.ai@icloud.com
Password: [YOUR_EXISTING_PASSWORD]

Note: These are real user accounts with populated demo data including:
- 3+ complete menstrual cycles
- Daily symptom tracking
- AI predictions and insights
- Health dashboard data

The app uses Firebase Authentication. No special configuration needed.
```

#### C. Remove Hardcoded Demo Account

**File:** `lib/core/services/local_user_service.dart`

**Current Code (lines ~100-120):**
```dart
// Demo account creation in _createDemoUser()
```

**Action:** 
- Keep the method but mark as deprecated
- Add comment: "Use Firebase Authentication for demo accounts"
- Do NOT remove (may be used for offline testing)

#### D. Document for Apple Review

**Update:** `APP_STORE_DEMO_ACCOUNT.md` (create new file)

**Content:**
```markdown
# Flow AI - Apple App Store Review Demo Account

## Login Instructions

1. Launch the app
2. On the welcome screen, tap "Sign In"
3. Use the following credentials:

**Email:** reviewer@flowai.app  
**Password:** [Provided in App Review Notes field]

## Demo Data Included

This account contains realistic demo data:
- 3 complete menstrual cycles (spanning 90 days)
- Daily symptom tracking entries
- AI-generated predictions and insights
- Health dashboard biometric data
- Exercise and mood tracking

## Features to Test

1. **Home Screen:** View cycle calendar and current phase
2. **Tracking:** Add symptoms, mood, flow intensity
3. **AI Insights:** Review predictions and health patterns
4. **Health Dashboard:** Check biometric analysis
5. **Settings:** Explore preferences and integrations

## Alternative Account

If you encounter any issues with the primary account:

**Email:** ronos.ai@icloud.com  
**Password:** [Provided in App Review Notes]

## Support

For review support: geoffrey.rono@ue-germany.de
```

**Acceptance Criteria:**
✅ Firebase user account created and populated  
✅ Demo credentials documented for reviewers  
✅ Account works consistently across all platforms  
✅ Alternative account available as backup  
✅ Clear instructions in App Store Connect review notes

---

### 1.4 Remove All Debug Configurations

**Issue:** "No debug, always deliver in release form, ready for uploading"

**Required Actions:**

#### A. Flutter Configuration

**File:** `lib/main.dart`

**Verify:**
```dart
void main() async {
  // Ensure no debug prints in production
  if (kReleaseMode) {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }
  
  runApp(const MyApp());
}
```

**Check:** No `debugPrint`, `print`, or `log` statements in release builds

#### B. Build Configuration Files

**Files to verify:**
1. `ios/Flutter/Release.xcconfig`
2. `android/app/build.gradle.kts`

**Android Release Config:**
```kotlin
buildTypes {
    release {
        isMinifyEnabled = true
        isShrinkResources = true
        proguardFiles(
            getDefaultProguardFile("proguard-android-optimize.txt"),
            "proguard-rules.pro"
        )
        signingConfig = signingConfigs.getByName("release")
    }
}
```

#### C. Remove Debug Banners

**File:** `lib/main.dart`

**Verify MaterialApp:**
```dart
MaterialApp.router(
  debugShowCheckedModeBanner: false, // ✅ Must be false
  // ... rest of configuration
)
```

#### D. Release Build Verification

**Build Commands (ONLY USE THESE):**
```bash
# iOS Release
flutter build ios --release --no-codesign

# Android Release Bundle
flutter build appbundle --release

# Android Release APK
flutter build apk --release

# NEVER use:
# flutter build ios (defaults to debug)
# flutter run (always debug)
```

**Acceptance Criteria:**
✅ No debug banners visible  
✅ No console logs in release builds  
✅ Release configurations properly set  
✅ Build sizes optimized (minified, shrunk)  
✅ Only release builds uploaded to stores

---

## Phase 2: Rebranding Consistency (Priority: HIGH)
**Estimated Effort:** 4-6 hours  
**Target Completion:** With Phase 1  
**Blocking:** Brand consistency, user trust

### 2.1 AI Assistant Rename: Mira → Zyra

**Issue:** AI assistant currently named "Mira", should be "Zyra" to match company name

**Files to Update:**

#### A. Core AI Service
**File:** `lib/core/services/ai_conversation_service.dart`

**Find and Replace:**
```dart
// OLD
const String defaultAssistantName = 'Mira';

// NEW
const String defaultAssistantName = 'Zyra';
```

#### B. Localization Files

**Files:** All `lib/l10n/app_*.arb` files (36 languages)

**Keys to Update:**
```json
{
  "aiAssistantName": "Zyra",
  "aiAssistantGreeting": "Hi! I'm Zyra, your personal health assistant.",
  "chatWithMira": "Chat with Zyra",
  "miraWelcome": "Welcome! Zyra is here to help you.",
  // ... all instances
}
```

**Command to find all instances:**
```bash
grep -r "Mira" lib/l10n/
grep -r "mira" lib/ --include="*.dart"
```

#### C. UI Screens

**Files to check:**
1. `lib/features/ai_coach/screens/ai_coach_screen.dart`
2. `lib/features/home/screens/home_screen.dart` (AI assistant card)
3. `lib/features/settings/screens/settings_screen.dart`
4. Any dialog boxes or tooltips mentioning the AI assistant

#### D. Assets and Images

**Check for:**
- Avatar images with "Mira" name
- Icon files: `assets/images/mira_*`
- Any branding materials

**Action:** Rename or update if found

#### E. Documentation

**Files to update:**
1. `README.md`
2. `WARP.md`
3. Any user-facing help documents
4. App Store description

**Search and replace:**
```bash
find . -type f -name "*.md" -exec sed -i '' 's/Mira/Zyra/g' {} +
```

**Acceptance Criteria:**
✅ All "Mira" references replaced with "Zyra"  
✅ Localization files updated for all 36 languages  
✅ UI displays "Zyra" consistently  
✅ No residual "Mira" references in codebase  
✅ Assets renamed appropriately

---

### 2.2 Integration Rename: CycleSync → Flow iQ

**Issue:** Integration section still references "CycleSync" instead of "Flow iQ"

**Background:**
- Flow iQ is the clinical-grade companion app
- Integration allows data sharing between Flow AI and Flow iQ

**Files to Update:**

#### A. Integration Widget
**File:** `lib/features/settings/widgets/cyclesync_integration.dart`

**Actions:**
1. Rename file to: `flow_iq_integration.dart`
2. Update class name: `CycleSyncIntegration` → `FlowIqIntegration`
3. Update all internal references

**Updated Content:**
```dart
class FlowIqIntegration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.sync),
        title: Text('Flow iQ Integration'),
        subtitle: Text('Connect with Flow iQ for clinical-grade tracking'),
        trailing: Switch(...),
        onTap: () => _showFlowIqIntegrationDialog(context),
      ),
    );
  }
  
  void _showFlowIqIntegrationDialog(BuildContext context) {
    // Update dialog content
  }
}
```

#### B. Localization Updates

**File:** `lib/l10n/app_en.arb` (and all 36 languages)

**Keys to update:**
```json
{
  "cycleSyncIntegration": "Flow iQ Integration",
  "cycleSyncDescription": "Connect with Flow iQ for advanced clinical tracking",
  "cycleSyncSync": "Sync with Flow iQ",
  "cycleSyncEnable": "Enable Flow iQ Integration",
  "cycleSyncDisable": "Disable Flow iQ Integration",
  "cycleSyncSyncNow": "Sync Now with Flow iQ",
  "cycleSyncLastSync": "Last synced with Flow iQ",
  "cycleSyncGitHub": "Learn more about Flow iQ"
}
```

#### C. Settings Screen Integration

**File:** `lib/features/settings/screens/settings_screen.dart`

**Update import:**
```dart
// OLD
import '../widgets/cyclesync_integration.dart';

// NEW
import '../widgets/flow_iq_integration.dart';
```

**Update usage:**
```dart
// OLD
CycleSyncIntegration(),

// NEW
FlowIqIntegration(),
```

#### D. Service Layer

**File:** `lib/core/services/conversation_cloud_sync.dart` (if references exist)

**Update any CycleSync mentions to Flow iQ**

#### E. External Links

**Update GitHub reference:**
```dart
const String flowIqGitHubUrl = 'https://github.com/ronospace/Flow-iQ';
```

**Dialog content:**
```dart
Text(
  'Flow iQ is a clinical-grade menstrual health tracking application designed '
  'for healthcare professionals and advanced users. Connect your Flow AI account '
  'to sync your data with Flow iQ for comprehensive health monitoring.',
)
```

**Acceptance Criteria:**
✅ All "CycleSync" references replaced with "Flow iQ"  
✅ File renamed and imports updated  
✅ Localization consistent across all languages  
✅ External links point to correct repository  
✅ Integration dialog describes Flow iQ correctly

---

### 2.3 Copyright Update: ZyraFlow Inc.™

**Issue:** Copyright needs to be updated to: © 2025 ZyraFlow Inc.™ All rights reserved.

**Files to Update:**

#### A. About Screen
**File:** `lib/features/settings/screens/about_screen.dart`

**Current:**
```dart
Text('© 2024 Flow AI. All rights reserved.')
```

**Update to:**
```dart
Text(
  '© 2025 ZyraFlow Inc.™ All rights reserved.',
  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
),
Text(
  'Developed and maintained by ZyraFlow Inc.™',
  style: TextStyle(fontSize: 10, color: Colors.grey[500]),
),
```

#### B. README.md
**File:** `README.md`

**Update footer:**
```markdown
---

## 📄 License & Copyright

© 2025 ZyraFlow Inc.™ All rights reserved.

**Flow AI** is developed and maintained by ZyraFlow Inc.™

For licensing inquiries: business@zyraflow.com
```

#### C. Localization Files

**File:** `lib/l10n/app_en.arb` (and all 36 languages)

**Add/Update keys:**
```json
{
  "copyright": "© 2025 ZyraFlow Inc.™ All rights reserved.",
  "developedBy": "Developed and maintained by ZyraFlow Inc.™",
  "companyName": "ZyraFlow Inc.",
  "aboutCompany": "ZyraFlow Inc. is a women's health technology company dedicated to empowering individuals through AI-powered health tracking and insights."
}
```

#### D. App Store Metadata

**Update in App Store Connect:**
- Copyright field: `2025 ZyraFlow Inc.`
- Company name references

#### E. Legal Documents

**Files to create/update:**
1. `PRIVACY_POLICY.md` - Add ZyraFlow Inc. as data controller
2. `TERMS_OF_SERVICE.md` - Update company references
3. `LICENSE` - Update copyright holder

**Acceptance Criteria:**
✅ Copyright displays "© 2025 ZyraFlow Inc.™" everywhere  
✅ "All rights reserved" included  
✅ "Developed and maintained by" line added where appropriate  
✅ Legal documents updated  
✅ App Store metadata reflects correct company name

---

### 2.4 Fix FlowSense References in FAQs

**Issue:** Help/FAQs section still contains "FlowSense" references

**Files to Update:**

#### A. FAQ Screen
**File:** `lib/features/settings/screens/help_screen.dart` or similar

**Find all instances:**
```bash
grep -r "FlowSense" lib/features/settings/
grep -r "FlowSense" lib/l10n/
```

**Replace with:**
- "Flow AI" for the app itself
- "Flow iQ" for clinical integration features

#### B. Localization FAQ Keys

**File:** `lib/l10n/app_en.arb`

**Example updates:**
```json
{
  "faqWhatIsFlowSense": "What is Flow AI?",
  "faqFlowSenseAnswer": "Flow AI is an AI-powered menstrual health tracking application...",
  "faqFlowSenseFeatures": "Flow AI offers advanced features including...",
  "faqFlowSenseIntegration": "Flow AI integrates with Flow iQ for clinical-grade tracking..."
}
```

#### C. Context-Specific Naming

**Decision Matrix:**
| Context | Use | Example |
|---------|-----|---------|
| Main application | Flow AI | "Welcome to Flow AI" |
| Clinical features | Flow iQ | "Flow iQ integration provides..." |
| Company/Legal | ZyraFlow Inc. | "© 2025 ZyraFlow Inc." |
| AI Assistant | Zyra | "Chat with Zyra" |

**Acceptance Criteria:**
✅ No "FlowSense" references remain  
✅ Correct branding used in context  
✅ FAQs updated across all 36 languages  
✅ Help documentation consistent

---

## Phase 3: UX Improvements (Priority: MEDIUM)
**Estimated Effort:** 6-8 hours  
**Target Completion:** v1.1 or concurrent with Phase 1/2  

### 3.1 Settings Screen Reorganization

**Issue:** Multiple UX improvements requested for settings layout

#### A. Move Theme Switcher to Top

**File:** `lib/features/settings/screens/settings_screen.dart`

**Current Order:**
1. Profile section (name, email)
2. App Preferences
3. Theme switcher (buried in preferences)

**New Order:**
1. Theme Switcher Card (prominent, top)
2. Profile section
3. App Preferences
4. Other sections

**Implementation:**
```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text('Settings')),
    body: ListView(
      padding: EdgeInsets.all(16),
      children: [
        // 1. Theme Switcher Card (NEW POSITION)
        ThemeSwitcherCard(),
        SizedBox(height: 16),
        
        // 2. Profile Section
        _buildProfileSection(),
        SizedBox(height: 16),
        
        // 3. App Preferences (without theme)
        _buildAppPreferences(),
        
        // ... rest of sections
      ],
    ),
  );
}
```

**Benefits:**
- Immediate visual feedback
- Most frequently changed setting
- Better UX hierarchy

#### B. Fix Username Edit Save Functionality

**Issue:** "When you edit the username, no changes occur when you click Save. It should end and save automatically when the Save button is clicked."

**File:** `lib/features/settings/screens/settings_screen.dart` or profile edit widget

**Current Code Investigation Needed:**
```dart
// Find username edit implementation
// Look for onSaved callback or save button handler
```

**Implementation Pattern:**
```dart
void _saveUsername(String newUsername) async {
  setState(() => _isLoading = true);
  
  try {
    // Save to local user service
    await Provider.of<SettingsProvider>(context, listen: false)
        .updateUsername(newUsername);
    
    // Update Firebase if connected
    if (FirebaseAuth.instance.currentUser != null) {
      await FirebaseAuth.instance.currentUser!
          .updateDisplayName(newUsername);
    }
    
    // Close edit dialog/screen
    Navigator.pop(context);
    
    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Username updated successfully')),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error updating username: $e')),
    );
  } finally {
    setState(() => _isLoading = false);
  }
}
```

**Required Changes:**
1. Ensure Save button calls update method
2. Persist to both local storage and Firebase
3. Close edit screen automatically
4. Show confirmation feedback
5. Update UI immediately

**Testing:**
- [ ] Username updates in local storage
- [ ] Username updates in Firebase (if logged in)
- [ ] UI reflects change immediately
- [ ] Edit screen closes after save
- [ ] Error handling works

#### C. Add "Coming Soon" to Biometric Monitoring

**File:** `lib/features/settings/screens/settings_screen.dart` or biometric section

**Current:** Biometric Monitoring section exists but not functional

**Update to:**
```dart
ListTile(
  leading: Icon(Icons.monitor_heart),
  title: Row(
    children: [
      Text('Biometric Monitoring'),
      SizedBox(width: 8),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: Colors.orange[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          'Coming Soon',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: Colors.orange[800],
          ),
        ),
      ),
    ],
  ),
  subtitle: Text('Advanced health device integration'),
  enabled: false,
  onTap: () {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Biometric monitoring coming in Q2 2026!'),
        action: SnackBarAction(
          label: 'Learn More',
          onPressed: () {/* show roadmap */},
        ),
      ),
    );
  },
)
```

**Badge Styling:**
- Orange/yellow color scheme
- Small, unobtrusive
- Consistent with other "Coming Soon" badges

**Acceptance Criteria:**
✅ Theme switcher at top of settings  
✅ Username edit saves correctly and closes  
✅ "Coming Soon" badge on biometric monitoring  
✅ Disabled appearance for unavailable features  
✅ Helpful message on tap

---

### 3.2 Improve Account Management Section

**Issue:** "Improve or update account management section in settings. Make it fully functional."

**Files to Update:**
1. `lib/features/settings/screens/account_management_screen.dart` (create if missing)
2. `lib/features/settings/screens/settings_screen.dart`

#### A. Account Management Features

**Required Functionality:**

1. **Profile Information**
   - Display name (editable) ✅ Fix save functionality
   - Email address (display only or with verification)
   - Profile picture (optional)
   - Account created date

2. **Account Security**
   - Change password (if email/password auth)
   - Two-factor authentication (future)
   - Active sessions management
   - Login history

3. **Data Management**
   - Download my data (GDPR compliance)
   - Delete my account (with confirmation)
   - Data export formats (JSON, CSV, PDF)
   - Data retention settings

4. **Subscription/Premium** (if applicable)
   - Current plan
   - Upgrade options
   - Billing history
   - Cancel subscription

#### B. Implementation Structure

**Create:** `lib/features/settings/screens/account_management_screen.dart`

```dart
class AccountManagementScreen extends StatefulWidget {
  @override
  _AccountManagementScreenState createState() => _AccountManagementScreenState();
}

class _AccountManagementScreenState extends State<AccountManagementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Account Management')),
      body: ListView(
        children: [
          _buildProfileSection(),
          Divider(),
          _buildSecuritySection(),
          Divider(),
          _buildDataManagementSection(),
          Divider(),
          _buildDangerZoneSection(),
        ],
      ),
    );
  }
  
  Widget _buildProfileSection() {
    return ListTileSection(
      title: 'Profile Information',
      tiles: [
        EditableListTile(
          icon: Icons.person,
          title: 'Display Name',
          value: currentUser.displayName,
          onSave: (value) => _updateDisplayName(value),
        ),
        ListTile(
          leading: Icon(Icons.email),
          title: Text('Email'),
          subtitle: Text(currentUser.email),
          trailing: Icon(Icons.verified, color: Colors.green),
        ),
      ],
    );
  }
  
  Widget _buildSecuritySection() {
    return ListTileSection(
      title: 'Security',
      tiles: [
        ListTile(
          leading: Icon(Icons.lock),
          title: Text('Change Password'),
          trailing: Icon(Icons.chevron_right),
          onTap: () => _showChangePasswordDialog(),
        ),
        ListTile(
          leading: Icon(Icons.history),
          title: Text('Login History'),
          trailing: Icon(Icons.chevron_right),
          onTap: () => _showLoginHistory(),
        ),
      ],
    );
  }
  
  Widget _buildDataManagementSection() {
    return ListTileSection(
      title: 'Data Management',
      tiles: [
        ListTile(
          leading: Icon(Icons.download),
          title: Text('Download My Data'),
          subtitle: Text('Export your health data'),
          trailing: Icon(Icons.chevron_right),
          onTap: () => _initiateDataExport(),
        ),
        ListTile(
          leading: Icon(Icons.storage),
          title: Text('Data Storage'),
          subtitle: Text('${_calculateStorageSize()} MB used'),
        ),
      ],
    );
  }
  
  Widget _buildDangerZoneSection() {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Danger Zone',
            style: TextStyle(
              color: Colors.red[700],
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 8),
          ListTile(
            leading: Icon(Icons.delete_forever, color: Colors.red),
            title: Text('Delete Account'),
            subtitle: Text('Permanently delete your account and all data'),
            onTap: () => _showDeleteAccountDialog(),
          ),
        ],
      ),
    );
  }
}
```

#### C. Key Features Implementation

**Change Password:**
```dart
Future<void> _showChangePasswordDialog() async {
  // Show dialog with current, new, confirm password fields
  // Validate password strength
  // Re-authenticate user before change
  // Update Firebase auth
  // Show success/error message
}
```

**Download Data:**
```dart
Future<void> _initiateDataExport() async {
  // Show format selection dialog (JSON, CSV, PDF)
  // Show date range picker
  // Generate export file
  // Use share_plus to share file
  // Log export for security audit
}
```

**Delete Account:**
```dart
Future<void> _showDeleteAccountDialog() async {
  // Show warning dialog with consequences
  // Require re-authentication
  // Require typing "DELETE" to confirm
  // Delete from Firebase
  // Delete local data
  // Sign out and return to onboarding
}
```

**Acceptance Criteria:**
✅ All account information editable  
✅ Password change functional with validation  
✅ Data export works (all formats)  
✅ Account deletion requires confirmation  
✅ All operations have proper error handling  
✅ GDPR compliant (data portability, deletion)

---

### 3.3 Enhance AI Assistant UI/UX

**Issue:** "Improve AI assistant sizing and interaction by making it easier to type, sending, to avoid overlap, make it look presentable fit and easy to interact with."

**File:** `lib/features/ai_coach/screens/ai_coach_screen.dart`

#### A. Current Issues Identified

1. Input field too small or cramped
2. Send button positioning causes overlap
3. Chat bubbles not properly sized
4. Hard to type comfortably
5. Not visually appealing

#### B. Improved Chat Interface Design

**Layout Structure:**
```dart
Scaffold(
  appBar: AppBar(
    title: Text('Chat with Zyra'),
    actions: [
      IconButton(
        icon: Icon(Icons.refresh),
        onPressed: _clearConversation,
      ),
    ],
  ),
  body: Column(
    children: [
      // Chat messages area
      Expanded(
        child: _buildMessageList(),
      ),
      
      // Typing indicator (when Zyra is typing)
      if (_isTyping) _buildTypingIndicator(),
      
      // Input area
      _buildInputArea(),
    ],
  ),
)
```

#### C. Message List Improvements

```dart
Widget _buildMessageList() {
  return ListView.builder(
    reverse: true, // New messages at bottom
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    itemCount: messages.length,
    itemBuilder: (context, index) {
      final message = messages[index];
      return _buildMessageBubble(message);
    },
  );
}

Widget _buildMessageBubble(Message message) {
  final isUser = message.isUser;
  
  return Align(
    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
    child: Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.75,
      ),
      margin: EdgeInsets.symmetric(vertical: 4),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isUser 
            ? Theme.of(context).primaryColor
            : Colors.grey[200],
        borderRadius: BorderRadius.circular(20).copyWith(
          bottomRight: isUser ? Radius.circular(4) : null,
          bottomLeft: !isUser ? Radius.circular(4) : null,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message.text,
            style: TextStyle(
              color: isUser ? Colors.white : Colors.black87,
              fontSize: 15,
              height: 1.4,
            ),
          ),
          SizedBox(height: 4),
          Text(
            _formatTime(message.timestamp),
            style: TextStyle(
              color: isUser 
                  ? Colors.white.withOpacity(0.7)
                  : Colors.grey[600],
              fontSize: 11,
            ),
          ),
        ],
      ),
    ),
  );
}
```

#### D. Enhanced Input Area

```dart
Widget _buildInputArea() {
  return Container(
    decoration: BoxDecoration(
      color: Theme.of(context).scaffoldBackgroundColor,
      boxShadow: [
        BoxShadow(
          offset: Offset(0, -2),
          blurRadius: 4,
          color: Colors.black.withOpacity(0.1),
        ),
      ],
    ),
    child: SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Text input field
            Expanded(
              child: Container(
                constraints: BoxConstraints(
                  minHeight: 48,
                  maxHeight: 120, // Allow multiline expansion
                ),
                child: TextField(
                  controller: _messageController,
                  focusNode: _inputFocusNode,
                  maxLines: null, // Dynamic height
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    hintText: 'Ask Zyra anything...',
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                  onChanged: (text) {
                    setState(() => _messageText = text);
                  },
                ),
              ),
            ),
            
            SizedBox(width: 8),
            
            // Send button
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              child: Material(
                color: _messageText.trim().isEmpty
                    ? Colors.grey[300]
                    : Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(24),
                child: InkWell(
                  borderRadius: BorderRadius.circular(24),
                  onTap: _messageText.trim().isEmpty 
                      ? null 
                      : _sendMessage,
                  child: Container(
                    width: 48,
                    height: 48,
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
```

#### E. Additional Features

**Typing Indicator:**
```dart
Widget _buildTypingIndicator() {
  return Padding(
    padding: EdgeInsets.all(16),
    child: Row(
      children: [
        CircleAvatar(
          radius: 16,
          child: Icon(Icons.person, size: 16),
        ),
        SizedBox(width: 8),
        Text('Zyra is typing'),
        SizedBox(width: 8),
        _buildTypingAnimation(),
      ],
    ),
  );
}
```

**Quick Response Suggestions:**
```dart
Widget _buildQuickResponses() {
  final suggestions = [
    'What is my cycle status?',
    'When is my next period?',
    'Help with symptoms',
    'Fertility window',
  ];
  
  return Container(
    height: 50,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 16),
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(right: 8),
          child: ActionChip(
            label: Text(suggestions[index]),
            onPressed: () => _sendMessage(suggestions[index]),
          ),
        );
      },
    ),
  );
}
```

**Acceptance Criteria:**
✅ Input field expands dynamically (multiline)  
✅ Send button well-positioned, no overlap  
✅ Chat bubbles properly sized and aligned  
✅ Easy to type on mobile keyboards  
✅ Smooth animations and transitions  
✅ Quick response suggestions visible  
✅ Typing indicator shows AI activity  
✅ Professional, modern appearance

---

### 3.4 Enhanced Health Dashboard Matrix

**Issue:** "On the health dashboard matrix (real time biometric analysis), is it best we add flow intensity and mood balance in addition to the 4 - cycle status, phase, next period and cycle length?"

**File:** `lib/features/health/widgets/health_dashboard_matrix.dart` or similar

#### A. Current Dashboard Metrics (4)

1. Cycle Status
2. Current Phase
3. Next Period
4. Cycle Length

#### B. Proposed Dashboard Metrics (6)

**Optimal Order:**
1. **Cycle Status** - Primary indicator (Active/Inactive)
2. **Current Phase** - Menstrual/Follicular/Ovulation/Luteal
3. **Next Period** - Days until or date
4. **Flow Intensity** - Current flow level (if menstruating)
5. **Mood Balance** - Average mood score (last 7 days)
6. **Cycle Length** - Average cycle length

#### C. Implementation

**Layout Structure:**
```dart
Widget _buildDashboardMatrix() {
  return GridView.count(
    crossAxisCount: 2, // 2 columns
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    mainAxisSpacing: 12,
    crossAxisSpacing: 12,
    childAspectRatio: 1.5,
    children: [
      _buildMetricCard(
        icon: Icons.favorite,
        title: 'Cycle Status',
        value: _getCycleStatus(),
        color: Colors.red[400]!,
      ),
      _buildMetricCard(
        icon: Icons.wb_sunny,
        title: 'Current Phase',
        value: _getCurrentPhase(),
        color: Colors.orange[400]!,
      ),
      _buildMetricCard(
        icon: Icons.calendar_today,
        title: 'Next Period',
        value: _getNextPeriodDays(),
        color: Colors.purple[400]!,
      ),
      _buildMetricCard(
        icon: Icons.water_drop,
        title: 'Flow Intensity',
        value: _getFlowIntensity(),
        color: Colors.blue[400]!,
      ),
      _buildMetricCard(
        icon: Icons.mood,
        title: 'Mood Balance',
        value: _getMoodBalance(),
        color: Colors.green[400]!,
      ),
      _buildMetricCard(
        icon: Icons.show_chart,
        title: 'Cycle Length',
        value: _getCycleLength(),
        color: Colors.teal[400]!,
      ),
    ],
  );
}

Widget _buildMetricCard({
  required IconData icon,
  required String title,
  required String value,
  required Color color,
}) {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: color.withOpacity(0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(icon, color: color, size: 28),
        Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[700],
          ),
        ),
      ],
    ),
  );
}
```

#### D. Metric Calculations

**Flow Intensity:**
```dart
String _getFlowIntensity() {
  final today = DateTime.now();
  final currentCycle = Provider.of<CycleProvider>(context).currentCycle;
  
  if (currentCycle == null || !currentCycle.isActive) {
    return 'N/A';
  }
  
  // Get today's flow entry
  final todayFlow = currentCycle.getDailyEntry(today)?.flowIntensity;
  
  if (todayFlow == null) return 'Not tracked';
  
  return _flowIntensityLabel(todayFlow); // Light/Medium/Heavy
}
```

**Mood Balance:**
```dart
String _getMoodBalance() {
  final last7Days = List.generate(7, (i) => 
    DateTime.now().subtract(Duration(days: i))
  );
  
  final moodScores = last7Days
      .map((date) => _getMoodScore(date))
      .where((score) => score != null)
      .toList();
  
  if (moodScores.isEmpty) return 'Not tracked';
  
  final average = moodScores.reduce((a, b) => a + b) / moodScores.length;
  
  return _moodLabel(average); // Excellent/Good/Fair/Low
}
```

**Acceptance Criteria:**
✅ Dashboard displays 6 metrics in 2x3 grid  
✅ Flow Intensity shows current flow level  
✅ Mood Balance shows 7-day average  
✅ Color-coded for easy visualization  
✅ Handles missing data gracefully  
✅ Responsive layout on different screen sizes

---

## Phase 4: New Features (Priority: LOW-MEDIUM)
**Estimated Effort:** 8-10 hours  
**Target Completion:** v1.1 or v1.2  

### 4.1 Smart Water Reminder System

**Issue:** "Add a reminder to drink water. I'm not sure how many times a day, but make it smart enough."

**Files to Create/Update:**
1. `lib/core/services/water_reminder_service.dart` (new)
2. `lib/features/health/providers/water_tracking_provider.dart` (new)
3. `lib/features/health/widgets/water_intake_widget.dart` (new)

#### A. Smart Reminder Algorithm

**Factors to Consider:**
1. Cycle phase (more during menstruation)
2. Activity level (more if exercising)
3. Time of day (avoid late night)
4. User preferences
5. Climate/season (future enhancement)

**Base Recommendation:**
- **Default:** 8 glasses (2 liters) per day
- **Menstrual Phase:** +2 glasses (extra hydration)
- **Exercise Day:** +2-4 glasses depending on intensity
- **Hot Weather:** +1-2 glasses (future)

**Reminder Schedule:**
```dart
class WaterReminderSchedule {
  static List<TimeOfDay> getSmartSchedule(CyclePhase phase, bool exercisedToday) {
    final baseSchedule = [
      TimeOfDay(hour: 7, minute: 30),  // Morning
      TimeOfDay(hour: 10, minute: 0),  // Mid-morning
      TimeOfDay(hour: 12, minute: 30), // Lunch
      TimeOfDay(hour: 15, minute: 0),  // Afternoon
      TimeOfDay(hour: 17, minute: 30), // Late afternoon
      TimeOfDay(hour: 19, minute: 30), // Evening
    ];
    
    // Add extra reminders during menstruation
    if (phase == CyclePhase.menstrual) {
      baseSchedule.addAll([
        TimeOfDay(hour: 9, minute: 0),
        TimeOfDay(hour: 14, minute: 0),
      ]);
    }
    
    // Add extra reminder after exercise
    if (exercisedToday) {
      baseSchedule.add(TimeOfDay(hour: 20, minute: 0));
    }
    
    return baseSchedule..sort((a, b) => 
      a.hour * 60 + a.minute - (b.hour * 60 + b.minute)
    );
  }
}
```

#### B. Water Reminder Service

**File:** `lib/core/services/water_reminder_service.dart`

```dart
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class WaterReminderService {
  static final WaterReminderService _instance = WaterReminderService._internal();
  factory WaterReminderService() => _instance;
  WaterReminderService._internal();
  
  final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();
  
  Future<void> initialize() async {
    const androidSettings = AndroidInitializationSettings('app_icon');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    
    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    
    await _notifications.initialize(settings);
  }
  
  Future<void> scheduleSmartReminders({
    required CyclePhase currentPhase,
    required bool exercisedToday,
    required bool enabled,
  }) async {
    // Cancel existing reminders
    await cancelAllReminders();
    
    if (!enabled) return;
    
    // Get smart schedule
    final schedule = WaterReminderSchedule.getSmartSchedule(
      currentPhase,
      exercisedToday,
    );
    
    // Schedule each reminder
    for (int i = 0; i < schedule.length; i++) {
      await _scheduleReminder(
        id: i,
        time: schedule[i],
        message: _getSmartMessage(currentPhase, i),
      );
    }
  }
  
  Future<void> _scheduleReminder({
    required int id,
    required TimeOfDay time,
    required String message,
  }) async {
    final now = DateTime.now();
    var scheduledDate = DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );
    
    // If time has passed today, schedule for tomorrow
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(Duration(days: 1));
    }
    
    await _notifications.zonedSchedule(
      id,
      '💧 Hydration Reminder',
      message,
      tz.TZDateTime.from(scheduledDate, tz.local),
      NotificationDetails(
        android: AndroidNotificationDetails(
          'water_reminders',
          'Water Reminders',
          channelDescription: 'Smart hydration reminders based on your cycle',
          importance: Importance.high,
          priority: Priority.high,
          icon: 'water_drop',
        ),
        iOS: DarwinNotificationDetails(),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
  
  String _getSmartMessage(CyclePhase phase, int reminderIndex) {
    final messages = [
      'Time to hydrate! Your body needs water 💧',
      'Stay hydrated for better health',
      'Drink a glass of water to keep your energy up',
      'Hydration break! Your body will thank you',
      'Remember to drink water throughout the day',
    ];
    
    if (phase == CyclePhase.menstrual) {
      messages.addAll([
        'Extra hydration during your period helps reduce cramps',
        'Drinking water can help ease period symptoms',
      ]);
    }
    
    return messages[reminderIndex % messages.length];
  }
  
  Future<void> cancelAllReminders() async {
    await _notifications.cancelAll();
  }
}
```

#### C. Water Tracking Widget

**File:** `lib/features/health/widgets/water_intake_widget.dart`

```dart
class WaterIntakeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<WaterTrackingProvider>(
      builder: (context, provider, child) {
        final progress = provider.todayIntake / provider.dailyGoal;
        
        return Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Water Intake',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(Icons.water_drop, color: Colors.blue),
                  ],
                ),
                SizedBox(height: 16),
                
                // Progress bar
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.blue[50],
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                  minHeight: 8,
                ),
                SizedBox(height: 8),
                
                Text(
                  '${provider.todayIntake} / ${provider.dailyGoal} glasses',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                SizedBox(height: 16),
                
                // Quick add buttons
                Wrap(
                  spacing: 8,
                  children: [
                    _buildQuickAddButton(
                      context,
                      '+ 1 Glass',
                      () => provider.addGlass(1),
                    ),
                    _buildQuickAddButton(
                      context,
                      '+ 2 Glasses',
                      () => provider.addGlass(2),
                    ),
                    if (provider.todayIntake > 0)
                      _buildQuickAddButton(
                        context,
                        'Reset',
                        () => provider.reset(),
                        color: Colors.red[100],
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  
  Widget _buildQuickAddButton(
    BuildContext context,
    String label,
    VoidCallback onPressed,
    {Color? color}
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Colors.blue[50],
        foregroundColor: Colors.blue[700],
        elevation: 0,
      ),
      child: Text(label),
    );
  }
}
```

#### D. Settings Integration

**Add to Settings Screen:**
```dart
SwitchListTile(
  title: Text('Water Reminders'),
  subtitle: Text('Smart hydration reminders based on your cycle'),
  value: _waterRemindersEnabled,
  onChanged: (value) async {
    setState(() => _waterRemindersEnabled = value);
    await WaterReminderService().scheduleSmartReminders(
      currentPhase: currentCyclePhase,
      exercisedToday: todayExerciseLogged,
      enabled: value,
    );
  },
),
```

**Acceptance Criteria:**
✅ Smart reminder schedule based on cycle phase  
✅ Extra reminders during menstruation  
✅ Activity-aware (more if exercising)  
✅ User can enable/disable  
✅ Customizable frequency in settings  
✅ Helpful, varied reminder messages  
✅ Water intake tracking widget  
✅ Quick add buttons for logging

---

### 4.2 Cycle-Specific Exercise Recommendations

**Issue:** "Exercises during the entire cycle: Recommend accordingly."

**Files to Create/Update:**
1. `lib/core/services/exercise_recommendation_service.dart` (new)
2. `lib/features/health/widgets/exercise_recommendation_card.dart` (new)

#### A. Exercise Recommendations by Phase

**Menstrual Phase (Days 1-5):**
```dart
class ExerciseRecommendation {
  static const menstrualPhase = [
    Exercise(
      name: 'Gentle Yoga',
      description: 'Light stretching and restorative poses',
      duration: '20-30 minutes',
      intensity: ExerciseIntensity.low,
      benefits: ['Reduces cramps', 'Relieves tension', 'Improves circulation'],
      examples: ['Child\'s pose', 'Cat-cow stretch', 'Legs up the wall'],
    ),
    Exercise(
      name: 'Walking',
      description: 'Easy-paced walking or nature walks',
      duration: '20-40 minutes',
      intensity: ExerciseIntensity.low,
      benefits: ['Gentle movement', 'Fresh air', 'Mood boost'],
      examples: ['Park walk', 'Nature trail', 'Light stroll'],
    ),
    Exercise(
      name: 'Swimming',
      description: 'Gentle swimming or water aerobics',
      duration: '20-30 minutes',
      intensity: ExerciseIntensity.lowToModerate,
      benefits: ['Low impact', 'Full body workout', 'Relaxing'],
      examples: ['Easy laps', 'Water walking', 'Floating exercises'],
    ),
    Exercise(
      name: 'Pilates',
      description: 'Core strengthening with gentle movements',
      duration: '25-35 minutes',
      intensity: ExerciseIntensity.low,
      benefits: ['Core strength', 'Flexibility', 'Mind-body connection'],
      examples: ['Pelvic tilts', 'Leg circles', 'Spine stretch'],
    ),
  ];
}
```

**Follicular Phase (Days 6-14):**
```dart
static const follicularPhase = [
  Exercise(
    name: 'Running',
    description: 'Moderate to high intensity cardio',
    duration: '30-45 minutes',
    intensity: ExerciseIntensity.moderate,
    benefits: ['Builds endurance', 'Energy boost', 'Cardiovascular health'],
    examples: ['Interval training', 'Steady pace runs', 'Hill sprints'],
  ),
  Exercise(
    name: 'Strength Training',
    description: 'Progressive weight lifting',
    duration: '40-60 minutes',
    intensity: ExerciseIntensity.moderate,
    benefits: ['Muscle building', 'Bone density', 'Metabolism boost'],
    examples: ['Squats', 'Deadlifts', 'Bench press', 'Rows'],
  ),
  Exercise(
    name: 'Dance Cardio',
    description: 'High-energy dance classes',
    duration: '30-45 minutes',
    intensity: ExerciseIntensity.moderate,
    benefits: ['Fun', 'Full body workout', 'Coordination'],
    examples: ['Zumba', 'Hip hop', 'Ballet fitness'],
  ),
  Exercise(
    name: 'Cycling',
    description: 'Indoor or outdoor cycling',
    duration: '40-60 minutes',
    intensity: ExerciseIntensity.moderate,
    benefits: ['Lower body strength', 'Endurance', 'Joint-friendly'],
    examples: ['Spin class', 'Road cycling', 'Mountain biking'],
  ),
];
```

**Ovulation Phase (Days 15-17):**
```dart
static const ovulationPhase = [
  Exercise(
    name: 'HIIT Training',
    description: 'High-intensity interval training',
    duration: '20-30 minutes',
    intensity: ExerciseIntensity.high,
    benefits: ['Maximum calorie burn', 'Peak performance', 'Efficiency'],
    examples: ['Burpees', 'Mountain climbers', 'Jump squats', 'Sprints'],
  ),
  Exercise(
    name: 'CrossFit',
    description: 'Varied functional movements at high intensity',
    duration: '45-60 minutes',
    intensity: ExerciseIntensity.high,
    benefits: ['Full body conditioning', 'Strength and cardio combo'],
    examples: ['WODs', 'Olympic lifts', 'Box jumps'],
  ),
  Exercise(
    name: 'Power Yoga',
    description: 'Dynamic, challenging yoga flows',
    duration: '45-60 minutes',
    intensity: ExerciseIntensity.moderate,
    benefits: ['Strength', 'Flexibility', 'Balance'],
    examples: ['Vinyasa', 'Ashtanga', 'Power flows'],
  ),
];
```

**Luteal Phase (Days 18-28):**
```dart
static const lutealPhase = [
  Exercise(
    name: 'Moderate Strength Training',
    description: 'Lower intensity resistance work',
    duration: '30-45 minutes',
    intensity: ExerciseIntensity.lowToModerate,
    benefits: ['Maintains strength', 'Manages energy levels'],
    examples: ['Light weights', 'Bodyweight exercises', 'Resistance bands'],
  ),
  Exercise(
    name: 'Yoga',
    description: 'Balanced yoga practice',
    duration: '45-60 minutes',
    intensity: ExerciseIntensity.low,
    benefits: ['Stress relief', 'Flexibility', 'Hormone balance'],
    examples: ['Hatha yoga', 'Yin yoga', 'Restorative yoga'],
  ),
  Exercise(
    name: 'Barre',
    description: 'Low-impact ballet-inspired workout',
    duration: '45-60 minutes',
    intensity: ExerciseIntensity.low,
    benefits: ['Toning', 'Posture', 'Core strength'],
    examples: ['Pliés', 'Leg lifts', 'Core work'],
  ),
  Exercise(
    name: 'Tai Chi',
    description: 'Gentle martial arts movements',
    duration: '30-45 minutes',
    intensity: ExerciseIntensity.low,
    benefits: ['Stress reduction', 'Balance', 'Mindfulness'],
    examples: ['Slow movements', 'Breathing exercises', 'Balance poses'],
  ),
];
```

#### B. Exercise Recommendation Widget

**File:** `lib/features/health/widgets/exercise_recommendation_card.dart`

```dart
class ExerciseRecommendationCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cycleProvider = Provider.of<CycleProvider>(context);
    final currentPhase = cycleProvider.currentPhase;
    final recommendations = _getRecommendationsForPhase(currentPhase);
    
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.fitness_center, color: Theme.of(context).primaryColor),
                SizedBox(width: 8),
                Text(
                  'Recommended Exercises',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'Best for ${_getPhaseLabel(currentPhase)} phase',
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 16),
            
            // Exercise list
            ...recommendations.map((exercise) => _buildExerciseTile(
              context,
              exercise,
            )).toList(),
            
            SizedBox(height: 8),
            TextButton(
              onPressed: () => _showDetailedRecommendations(context, currentPhase),
              child: Text('View All Recommendations'),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildExerciseTile(BuildContext context, Exercise exercise) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: _getIntensityColor(exercise.intensity).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          Icons.directions_run,
          color: _getIntensityColor(exercise.intensity),
        ),
      ),
      title: Text(exercise.name),
      subtitle: Text('${exercise.duration} • ${exercise.description}'),
      trailing: Chip(
        label: Text(
          _getIntensityLabel(exercise.intensity),
          style: TextStyle(fontSize: 10),
        ),
        backgroundColor: _getIntensityColor(exercise.intensity).withOpacity(0.2),
      ),
      onTap: () => _showExerciseDetails(context, exercise),
    );
  }
}
```

**Acceptance Criteria:**
✅ Recommendations change based on cycle phase  
✅ Intensity appropriate for each phase  
✅ Clear benefits listed for each exercise  
✅ Examples provided for each recommendation  
✅ Beautiful, informative UI  
✅ Detailed view with full information  
✅ Option to mark as completed/log

---

### 4.3 Update Coming Soon Timeline

**Issue:** "Update the coming soon in future plans quarter years from 2025 to 2026 and so forth."

**Files to Update:**
1. `lib/features/settings/screens/roadmap_screen.dart` or similar
2. Any "Coming Soon" feature lists

**Current Timeline (2025):**
- Q1 2025: ...
- Q2 2025: ...
- Q3 2025: ...
- Q4 2025: ...

**Updated Timeline (2026+):**

```dart
class AppRoadmap {
  static final List<RoadmapQuarter> quarters = [
    RoadmapQuarter(
      year: 2026,
      quarter: 1,
      title: 'Q1 2026 - Healthcare Integration',
      features: [
        'HealthKit deep integration',
        'Wearable device sync (Apple Watch, Fitbit)',
        'Medical provider data sharing',
        'Advanced biometric tracking',
      ],
    ),
    RoadmapQuarter(
      year: 2026,
      quarter: 2,
      title: 'Q2 2026 - Community & Social',
      features: [
        'Private community forums',
        'Anonymous peer support groups',
        'Expert Q&A sessions',
        'Experience sharing (optional)',
      ],
    ),
    RoadmapQuarter(
      year: 2026,
      quarter: 3,
      title: 'Q3 2026 - AI Enhancements',
      features: [
        'Voice-activated Zyra assistant',
        'Image recognition for symptom tracking',
        'Personalized nutrition recommendations',
        'Sleep quality analysis',
      ],
    ),
    RoadmapQuarter(
      year: 2026,
      quarter: 4,
      title: 'Q4 2026 - Advanced Features',
      features: [
        'Fertility treatment support',
        'Pregnancy mode',
        'Partner app for shared tracking',
        'Telehealth integration',
      ],
    ),
    RoadmapQuarter(
      year: 2027,
      quarter: 1,
      title: 'Q1 2027 - Global Expansion',
      features: [
        'Additional language support (50+ languages)',
        'Regional health guidelines',
        'Currency and unit localization',
        'Healthcare provider network expansion',
      ],
    ),
  ];
}
```

**Acceptance Criteria:**
✅ Timeline updated to 2026 and beyond  
✅ Realistic feature roadmap  
✅ Clear quarter-by-quarter breakdown  
✅ Features aligned with company vision

---

## Phase 5: Testing & Validation (Priority: CRITICAL)
**Estimated Effort:** 4-6 hours  
**Target Completion:** Before each store submission  

### 5.1 Comprehensive Testing Checklist

#### A. Medical Citations Testing
- [ ] All AI Insight cards display citations
- [ ] Citations clickable and open correct URLs
- [ ] Disclaimer visible on all health screens
- [ ] Citation dialog shows complete information
- [ ] Works on iOS, Android, Web

#### B. Bundle ID & Build Testing
- [ ] Bundle ID correct in all configurations
- [ ] Clean build completes without errors
- [ ] Archive creates successfully
- [ ] IPA uploads to Transporter without errors
- [ ] App appears correctly in App Store Connect

#### C. Branding Testing
- [ ] No "Mira" references remain
- [ ] All "CycleSync" changed to "Flow iQ"
- [ ] No "FlowSense" references in FAQs
- [ ] Copyright shows "© 2025 ZyraFlow Inc.™"
- [ ] All branding consistent across 36 languages

#### D. UX Testing
- [ ] Theme switcher at top of settings
- [ ] Username edit saves and closes correctly
- [ ] "Coming Soon" badge on biometric monitoring
- [ ] Account management fully functional
- [ ] AI assistant input/send works smoothly
- [ ] Health dashboard shows 6 metrics correctly

#### E. New Features Testing
- [ ] Water reminders schedule correctly
- [ ] Exercise recommendations change by phase
- [ ] All new widgets display properly
- [ ] No performance degradation

#### F. Cross-Platform Testing
- [ ] iOS simulator/device testing
- [ ] Android emulator/device testing
- [ ] Web browser testing
- [ ] Different screen sizes/orientations

#### G. Release Build Testing
- [ ] No debug banners
- [ ] No console logs
- [ ] Optimized performance
- [ ] Correct version numbers

---

## Implementation Execution Plan

### Week 1: Critical Fixes (Phase 1 & 2)
**Days 1-2:** Medical Citations System
- Implement citation models
- Update all AI Insight widgets
- Add medical disclaimers
- Test thoroughly

**Days 3-4:** Bundle ID & Rebranding
- Clean build configuration
- Mira → Zyra rename
- CycleSync → Flow iQ
- FlowSense → Flow AI in FAQs
- Copyright updates

**Day 5:** Firebase Auth & Testing
- Configure Firebase reviewer account
- Remove hardcoded demo
- Test authentication flow
- Prepare submission documents

### Week 2: UX Improvements (Phase 3)
**Days 1-2:** Settings Reorganization
- Move theme switcher to top
- Fix username edit save
- Add "Coming Soon" badges
- Test all settings functionality

**Days 3-4:** AI Assistant & Dashboard
- Improve AI chat UI/UX
- Add health dashboard metrics
- Test interaction flows

**Day 5:** Account Management
- Implement full account management screen
- Add password change, data export, delete account
- Test all account features

### Week 3: New Features (Phase 4)
**Days 1-2:** Water Reminders
- Implement smart reminder service
- Create water tracking widget
- Test notification scheduling

**Days 3-4:** Exercise Recommendations
- Implement cycle-specific recommendations
- Create exercise widgets
- Update roadmap timeline

**Day 5:** Final Testing & Submission
- Run full test suite
- Build release artifacts
- Upload to stores
- Submit for review

---

## Priority Summary

### URGENT (Must fix before resubmission)
1. ✅ Medical Citations System
2. ✅ Bundle ID Verification
3. ✅ Firebase Authentication for Reviewers
4. ✅ Remove Debug Configurations
5. ✅ AI Rename (Mira → Zyra)
6. ✅ Integration Rename (CycleSync → Flow iQ)
7. ✅ Copyright Update (ZyraFlow Inc.)
8. ✅ Fix FlowSense References

### HIGH (Include in v1.0 if possible)
9. ⏭️ Theme Switcher Position
10. ⏭️ Username Edit Fix
11. ⏭️ "Coming Soon" Badges
12. ⏭️ Health Dashboard 6 Metrics

### MEDIUM (v1.1 Release)
13. ⏭️ Account Management Enhancement
14. ⏭️ AI Assistant UI Improvements
15. ⏭️ Water Reminder System
16. ⏭️ Exercise Recommendations
17. ⏭️ Coming Soon Timeline Update

---

## Success Metrics

**App Store Approval:**
- ✅ Guideline 1.4.1 compliance (medical citations)
- ✅ Successful IPA upload via Transporter
- ✅ App accepted for review
- ✅ No rejection issues

**Brand Consistency:**
- ✅ 100% rebranding completion
- ✅ No legacy names remaining
- ✅ Professional, consistent appearance

**User Experience:**
- ✅ Improved settings organization
- ✅ Better AI interaction
- ✅ Enhanced health dashboard
- ✅ Positive user feedback

**Feature Completeness:**
- ✅ Smart reminders functional
- ✅ Exercise recommendations accurate
- ✅ Account management fully operational

---

## Next Steps

1. **Review this document** with stakeholders
2. **Prioritize changes** based on App Store deadline
3. **Begin Phase 1** implementation immediately
4. **Test continuously** throughout implementation
5. **Document all changes** in commit messages
6. **Prepare submission materials** (screenshots, descriptions, demo account)
7. **Submit to App Store** once Phase 1 & 2 complete
8. **Plan v1.1 release** with Phase 3 & 4 features

---

**Document Prepared By:** AI Development Assistant  
**Date:** November 13, 2025  
**Version:** 1.0  
**Status:** Ready for Review and Execution

---

*This comprehensive guide serves as the single source of truth for all Flow AI v1.0 implementation work. All team members should reference this document for task prioritization and execution details.*