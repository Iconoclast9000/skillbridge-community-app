# Complete Setup Guide for SkillBridge App Development

## 1. Development Environment Setup

### Install Git
1. Download Git from https://git-scm.com/download/windows
2. Run the installer
3. Select "Git from the command line and also from 3rd-party software"
4. Keep default settings for other options
5. Verify installation:
   ```bash
   git --version
   ```

### Install Flutter
1. Download Flutter SDK from https://docs.flutter.dev/get-started/install/windows
2. Create `C:\development` folder
3. Extract Flutter ZIP to `C:\development\flutter`
4. Add Flutter to Path:
   - Win + R, type `sysdm.cpl`
   - Advanced → Environment Variables
   - Under "User variables" → Path
   - Add `C:\development\flutter\bin`
   - Click OK on all windows

### Install Android Studio
1. Download from https://developer.android.com/studio
2. Run installer
3. Check "Android Virtual Device" during installation
4. After installation:
   - Open Android Studio
   - Go to Tools → SDK Manager
   - Install Android SDK (latest version)
   - Install Android SDK Command-line Tools
   - Install Android SDK Build-Tools

### Install Java 17
1. Download from https://adoptium.net/ (Temurin 17)
2. Run installer
3. Add JAVA_HOME:
   - System Properties → Environment Variables
   - Add new System Variable:
     - Name: JAVA_HOME
     - Value: Path to Java installation (e.g., C:\Program Files\Eclipse Adoptium\jdk-17.0.x)
4. Configure Flutter:
   ```bash
   flutter config --jdk-dir="C:\Program Files\Eclipse Adoptium\jdk-17.0.x"
   ```

### VS Code Setup
1. Install VS Code from https://code.visualstudio.com/
2. Install extensions:
   - Flutter
   - Dart
   - Flutter Intl
   - Git History
   - GitLens

## 2. Project Setup

### Clone Repository
```bash
git clone https://github.com/Iconoclast9000/skillbridge-community-app.git
cd skillbridge-community-app
```

### Initialize Flutter Project
```bash
flutter create .
flutter clean
flutter pub get
```

### Setup Android Emulator
1. Open Android Studio
2. Tools → Device Manager
3. Create Virtual Device
4. Select Pixel 2
5. Download recommended system image
6. Complete setup and start emulator

### Verify Setup
```bash
flutter doctor
flutter run
```

## 3. Common Issues and Solutions

### Flutter Doctor Issues
- **Android licenses not accepted**:
  ```bash
  flutter doctor --android-licenses
  ```
  Accept all licenses

- **Android Studio not found**:
  - Verify Android Studio installation
  - Check Environment Variables

### Emulator Issues
- **No devices available**:
  ```bash
  flutter config --enable-android
  flutter doctor
  ```

- **Emulator not showing**:
  - Restart Android Studio
  - Verify SDK installation

### Build Issues
- **Gradle sync failed**:
  - Check Java installation
  - Verify JAVA_HOME path
  - Run:
    ```bash
    flutter clean
    flutter pub get
    ```

## 4. Project Structure
```
skillbridge-community-app/
├── lib/
│   ├── core/
│   │   ├── constants/
│   │   ├── theme/
│   │   └── utils/
│   ├── features/
│   │   ├── auth/
│   │   │   ├── data/
│   │   │   └── domain/
│   │   └── skills/
│   │       ├── data/
│   │       └── domain/
│   └── main.dart
├── test/
└── pubspec.yaml
```

## 5. Development Workflow
1. Create new branch for feature:
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. Make changes and test:
   ```bash
   flutter test
   flutter run
   ```

3. Commit changes:
   ```bash
   git add .
   git commit -m "Description of changes"
   ```

4. Push changes:
   ```bash
   git push origin feature/your-feature-name
   ```

## 6. Next Steps
1. Review project structure in VS Code
2. Run initial app on emulator
3. Start developing features
4. Follow contribution guidelines

For any issues, check the troubleshooting section or create an issue on GitHub.