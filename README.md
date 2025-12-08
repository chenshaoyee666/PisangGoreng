Prerequisites

Before running this project, make sure you have:

Flutter SDK installed
https://flutter.dev/docs/get-started/install

Android Studio installed (for Android emulator)
https://developer.android.com/studio

Visual Studio Code (optional, recommended for editing)
https://code.visualstudio.com/

Android device or emulator

Enable USB debugging on your physical device, or

Create an Android Virtual Device (AVD) via Android Studio

Ensure your system meets Flutter requirements:

flutter doctor


Fix any errors reported.

Project Structure
frontend/
├── lib/                 # Flutter Dart code
├── android/             # Android module
├── ios/                 # iOS module
├── test/                # Unit tests
├── pubspec.yaml         # Dependencies
├── pubspec.lock
├── .dart_tool/
└── README.md


lib/ → contains all the app source code

android/ & ios/ → platform-specific files

pubspec.yaml → defines all packages and assets

Setup Instructions

Open Terminal / PowerShell

cd "path_to_your_project\my-hybrid-app\frontend"


Install dependencies

flutter pub get


Check available devices

flutter devices


You should see your Android emulator or connected device.

Run the app

flutter run


Use -d <device_id> to specify a device if multiple are listed.
Example: flutter run -d emulator-5554

Optional: Enable Web or Windows support

If you want to run the app on Windows or web browser:

flutter create .
flutter run -d windows   # for Windows
flutter run -d chrome    # for web


Note: Some mobile-specific features may not work on web/desktop.

Modifying the Project

Open the frontend/ folder in VS Code or Android Studio.

Modify the Flutter code inside lib/.

Save changes and run:

flutter run


Add dependencies using pubspec.yaml and run flutter pub get.

Backend Integration

The backend is located in the backend/ folder.

Ensure it is running before testing API calls from the Flutter frontend.

Check the backend README for setup instructions.

Common Issues
Problem	Solution
No supported devices connected	Start an Android emulator or connect a device
flutter command not recognized	Install Flutter and add it to PATH
Dependencies fail	Run flutter pub get inside frontend/
Contributing

Fork the repository

Create a new branch for your feature or bugfix

Commit changes with clear messages

Submit a pull request
