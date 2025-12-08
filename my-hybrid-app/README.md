# My Hybrid App

A Flutter mobile app with Node.js backend for UMPSA Hackathon.

## Project Structure

```
my-hybrid-app/
├── frontend/              # Flutter mobile app
│   ├── lib/
│   ├── android/
│   ├── ios/
│   └── pubspec.yaml
├── backend/              # Node.js API server
│   ├── src/
│   ├── package.json
│   └── server.js
└── README.md
```

## Prerequisites

### 1. Install Flutter SDK
1. Download Flutter SDK from https://flutter.dev/docs/get-started/install/windows
2. Extract to `C:\flutter` 
3. Add `C:\flutter\bin` to your PATH environment variable
4. Run `flutter doctor` to verify installation

### 2. Install Android Studio
1. Download from https://developer.android.com/studio
2. Install with Android SDK
3. Create Android Virtual Device (AVD) for emulator

### 3. Install Node.js (for backend)
- Download LTS version from https://nodejs.org

## VS Code Extensions Installed
- ✅ Dart
- ✅ Flutter  
- ✅ Flutter Widget Snippets
- ✅ Pubspec Assist
- ✅ GitLens

## Quick Setup Commands

### After installing Flutter SDK:
```powershell
# Verify Flutter installation
flutter doctor

# Create Flutter project (run this in my-hybrid-app folder)
flutter create frontend --platforms android,ios

# Install backend dependencies
cd backend
npm install

# Run backend server
npm run dev

# Run Flutter app (in frontend folder)
cd ../frontend
flutter run
```

## Development Workflow
1. Start backend server: `cd backend && npm run dev`
2. Start Flutter app: `cd frontend && flutter run`
3. Use VS Code with Flutter extension for hot reload
4. Backend API will be available at http://localhost:3000

## API Endpoints (Backend)
- GET `/api/health` - Health check
- GET `/api/users` - Get all users
- POST `/api/users` - Create user
- GET `/api/data` - Get app data

## Flutter Project Features
- Clean architecture with separate folders
- HTTP client for API calls  
- State management (Provider/Riverpod)
- UI components and screens
- Navigation routing