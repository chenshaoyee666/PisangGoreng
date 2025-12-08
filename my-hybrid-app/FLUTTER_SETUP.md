# Flutter Installation Instructions for Windows

## Step 1: Download Flutter SDK
1. Go to https://flutter.dev/docs/get-started/install/windows
2. Download the Flutter SDK zip file (flutter_windows_3.x.x-stable.zip)
3. Extract it to `C:\flutter` (create the folder if it doesn't exist)

## Step 2: Update PATH Environment Variable

### Method 1: Using Windows Settings (Easiest)
1. Press `Win + I` to open Windows Settings
2. Search for "environment" in the search box
3. Click "Edit environment variables for your account"
4. In the Environment Variables window, find "Path" in User variables
5. Click "Edit" → "New" → Add `C:\flutter\bin`
6. Click OK to save

### Method 2: Using System Properties
1. Press `Win + R`, type `sysdm.cpl`, press Enter
2. Click "Environment Variables" button
3. In "User variables", find and edit PATH
4. Add `C:\flutter\bin` to your PATH
5. Click OK to save

### Method 3: Using PowerShell (Advanced)
```powershell
# Add Flutter to user PATH (run as regular user, not admin)
$userPath = [Environment]::GetEnvironmentVariable("Path", "User")
[Environment]::SetEnvironmentVariable("Path", $userPath + ";C:\flutter\bin", "User")
```

## Step 3: Install Android SDK (Without Android Studio)

### Option A: Command Line Tools Only (Recommended for VS Code)
1. Go to https://developer.android.com/studio#command-tools
2. Download "Command line tools only" for Windows
3. Create folder `C:\Android\cmdline-tools` 
4. Extract the zip to `C:\Android\cmdline-tools\latest\`
5. Add to PATH: `C:\Android\cmdline-tools\latest\bin`

### Option B: Android Studio (if you change your mind)
1. Download from https://developer.android.com/studio
2. Run installer but you can skip opening it after install
3. Android SDK will be at `C:\Users\{username}\AppData\Local\Android\Sdk`

## Step 4: Verify Installation
Open PowerShell and run:
```powershell
flutter doctor
```

This will show what's installed and what's missing.

## Step 5: Setup Android SDK Components
```powershell
# Accept licenses
flutter doctor --android-licenses

# Install required SDK components via command line
sdkmanager "platform-tools" "platforms;android-33" "build-tools;33.0.0"
```

## Step 6: Create Android Emulator (VS Code Compatible)

### Option A: Use Physical Device (Easiest)

#### For Redmi Note 11 Pro 5G (MIUI):

**Step 1: Enable Developer Options**
1. Settings → About phone → Tap "MIUI version" 7 times rapidly
2. You'll see "You are now a developer!" message

**Step 2: Enable USB Debugging** 
1. Go back to main Settings
2. Additional settings → Developer options
3. Turn on "USB debugging"
4. Turn on "Install via USB" (also recommended)

**Step 3: Connect & Authorize**
1. Connect phone via USB cable
2. On phone: Select "File Transfer" when USB connection popup appears
3. Allow USB debugging when prompted on phone
4. Check "Always allow from this computer"

**Step 4: Test Connection**
```powershell
flutter devices
```

#### Other Android Brands (if needed):

**Samsung:**
- Settings → About phone → Software information → Tap "Build number" 7 times

**OnePlus/Oppo:**
- Settings → About phone → Tap "Build number" 7 times

**Huawei:**
- Settings → About phone → Tap "Build number" 7 times

**Google Pixel:**
- Settings → About phone → Tap "Build number" 7 times

**Vivo:**
- Settings → About phone → Software information → Tap "Build number" 7 times

**Can't find Build Number?**
- Try: Settings → System → About phone → Build number
- Or: Settings → About device → Build number
- Search "Build" in your Settings search bar

#### Step 2: Enable USB Debugging
1. Go back to main Settings
2. Look for "Developer options" (should now be visible)
3. Enable "USB debugging"
4. Connect phone via USB cable

#### Step 3: Test Connection
```powershell
flutter devices
```

### Option B: Command Line Emulator
```powershell
# Create AVD via command line
avdmanager create avd -n flutter_emulator -k "system-images;android-33;google_apis;x86_64"

# Start emulator
emulator -avd flutter_emulator
```

### Option C: Use Android Studio AVD Manager (if needed)
- You can install Android Studio just for the AVD Manager
- Create virtual device through the GUI
- Then use VS Code for all development

## Quick Commands After Installation:
```powershell
# Check Flutter status
flutter doctor

# Create the Flutter project
cd "C:\Users\user\OneDrive\Documents\UMPSA Hackathon\my-hybrid-app"
flutter create frontend --platforms android,ios

# Run the app
cd frontend
flutter run
```