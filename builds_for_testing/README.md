# FlowSense - Testing Builds

Welcome to the FlowSense testing builds! This directory contains ready-to-install versions of the FlowSense app for both Android and iOS devices.

## 📁 Files Included

### Android APKs
- **`FlowSense-debug.apk`** (202MB) - Debug build for development testing
- **`FlowSense-release.apk`** (57MB) - Optimized release build for production-like testing

### iOS App
- **`FlowSense.ipa`** (11MB) - iOS app bundle for iPhone/iPad testing

## 📱 Installation Instructions

### Android Installation

#### Method 1: Direct APK Installation
1. **Enable Unknown Sources:**
   - Go to `Settings > Security > Unknown Sources` and enable it
   - On newer Android versions: `Settings > Apps > Special App Access > Install Unknown Apps`

2. **Install the APK:**
   - Transfer the APK file to your Android device
   - Use a file manager to navigate to the APK file
   - Tap on the APK file and follow the installation prompts
   - **Recommended:** Use `FlowSense-release.apk` for better performance

#### Method 2: ADB Installation (Developer)
```bash
adb install FlowSense-release.apk
```

### iOS Installation

#### Method 1: Xcode/iOS Simulator
1. Open Xcode
2. Open the iOS Simulator
3. Drag and drop `FlowSense.ipa` onto the simulator

#### Method 2: Physical Device (Requires Developer Account)
1. Use Xcode to install the IPA on a registered device
2. Or use tools like iOS App Signer for ad-hoc distribution

**Note:** The iOS IPA is not code-signed, so it requires additional steps for physical device installation.

## 🔧 System Requirements

### Android
- **Minimum SDK:** Android 8.0 (API 26)
- **Target SDK:** Latest Android version
- **Architecture:** ARM64, ARM32, x64
- **Storage:** ~60-210MB (depending on build)

### iOS
- **Minimum Version:** iOS 12.0+
- **Device:** iPhone, iPad
- **Storage:** ~15-20MB

## ✨ Features Included

- 🌍 **Multi-language Support:** German, Italian, Portuguese, Dutch, Russian, Japanese, Korean, Chinese, English, French, Spanish
- 🤖 **AI-Powered Insights:** Smart cycle predictions and health recommendations
- 📊 **Comprehensive Tracking:** Symptoms, mood, flow, and cycle patterns
- 📅 **Smart Calendar:** Visual cycle tracking and predictions
- 🔔 **Notifications:** Customizable reminders and insights
- 🎨 **Themes:** Light, Dark, and System themes
- 📱 **Modern UI:** Material Design with smooth animations

## 🧪 Testing Focus Areas

When testing the app, please pay special attention to:

1. **Localization:** Test language switching and verify translations
2. **AI Features:** Check cycle predictions and AI insights
3. **Data Persistence:** Ensure data saves correctly between sessions
4. **UI/UX:** Test theme switching and navigation
5. **Notifications:** Verify reminder functionality
6. **Performance:** Check app startup and navigation speed

## 🐛 Reporting Issues

If you encounter any issues during testing:

1. **Take screenshots** of any problems
2. **Note the device model and OS version**
3. **Describe the steps to reproduce** the issue
4. **Check the app logs** if possible

## 📝 Build Information

- **Build Date:** August 17, 2025
- **Flutter Version:** 3.32.8
- **Target Platforms:** Android (API 26+), iOS (12.0+)
- **Architecture:** Universal (ARM64, ARM32, x64)

## 🔒 Privacy & Security

This is a testing build and should not be used with real personal health data. The app includes:
- Local data storage
- Health app integrations (when available)
- AI processing capabilities

---

**Happy Testing! 🚀**

For any questions or issues, please contact the development team.
