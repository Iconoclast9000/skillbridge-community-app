# Troubleshooting Guide

## Common Setup Issues

### Flutter Installation

1. **Flutter Not Found**
   - Verify Path in Environment Variables
   - Restart VS Code/Terminal
   - Run `where flutter` to check installation

2. **Android Studio Issues**
   - Reinstall Android Studio
   - Verify SDK installation
   - Run SDK Manager and install missing components

3. **Emulator Problems**
   - Check virtualization in BIOS
   - Verify HAXM installation
   - Try creating new virtual device

4. **Java Version Conflicts**
   - Verify Java 17 installation
   - Check JAVA_HOME path
   - Run `java -version`

## Build Issues

1. **Gradle Sync Failed**
   ```bash
   flutter clean
   flutter pub get
   cd android
   ./gradlew clean
   cd ..
   flutter run
   ```

2. **Missing Dependencies**
   ```bash
   flutter pub cache repair
   flutter pub get
   ```

3. **Platform Issues**
   ```bash
   flutter create .
   flutter pub get
   ```

## Runtime Issues

1. **Hot Reload Not Working**
   - Restart VS Code
   - Stop and restart app
   - Check for syntax errors

2. **Performance Issues**
   - Check debug flags
   - Verify emulator settings
   - Close unnecessary applications

For unresolved issues, create a GitHub issue with:
- Error message
- Steps to reproduce
- Environment details (`flutter doctor -v` output)
