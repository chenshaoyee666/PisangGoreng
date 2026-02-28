# SmartBite - Food Sharing Platform

Submitted for KITAHACK 2026 - Google Developer Groups Hackathon

## Overview

SmartBite is a mobile application that connects food donors with recipients to reduce food waste and help communities in need. The platform enables users to share surplus food, discover nearby available items, and get AI-powered recipe suggestions based on available ingredients.

## Addressing SDG 2: Zero Hunger

This project directly contributes to the United Nations Sustainable Development Goal 2 - Zero Hunger. SmartBite tackles food insecurity and waste through:

- **Reducing Food Waste** - Preventing edible surplus food from going to landfills by connecting donors with those who need it
- **Improving Food Access** - Providing a platform for communities to access nutritious food that would otherwise be discarded
- **Promoting Food Security** - Enabling efficient redistribution of food resources to address hunger in local communities
- **Maximizing Food Utilization** - AI-powered recipe suggestions help users make the most of available ingredients, reducing waste while ensuring nutritious meals

By leveraging technology to bridge the gap between food surplus and food scarcity, SmartBite works toward a future where no one goes hungry while addressing the global food waste crisis.

## Key Features

### Food Sharing Network
Users can share excess food items with others in their community, helping reduce waste while supporting those in need. The platform facilitates connections between food donors (sharers) and recipients through an intuitive mobile interface.

### Real-Time QR Code System
Seamless food item verification and tracking through QR code scanning technology, ensuring secure and verified transactions between sharers and recipients.

### AI-Powered Recipe Suggestions
Intelligent recipe generation system that helps users create meals from available ingredients. The AI assistant provides personalized cooking recommendations, detailed instructions, and answers culinary questions.

### Multi-Language Support
Application interface available in English, Malay, and Chinese to serve diverse communities and ensure accessibility for all users.

### Delivery Tracking
Real-time tracking system for food deliveries, allowing users to monitor the status and location of shared food items throughout the distribution process.

### Interactive Recipe Database
Comprehensive collection of recipes with detailed instructions, ingredient lists, cooking times, and difficulty ratings. Users can filter recipes based on available ingredients and dietary preferences.

### Dashboard Analytics
Visual insights and statistics showing user impact, including meals shared, waste prevented, and community reach metrics.

## Tech Stack

### Frontend
- **Flutter** - Cross-platform mobile development framework for building the Android and iOS applications with a unified codebase
- Provider - State management
- HTTP - API communication
- Mobile Scanner - QR code functionality
- Image Picker - Camera integration

### Backend
- **Python Flask** - REST API server handling AI recipe generation endpoints
- **Google AI Studio (Gemini 2.5 Flash)** - Powers the AI recipe suggestion system and culinary Q&A features
- Node.js/Express - Application server for user management and data operations
- CORS - Cross-origin resource sharing

### Development Tools
- Android Studio - Android application testing
- VS Code - Development environment
- Git - Version control

## Google Technologies Used

This project leverages Google technologies as required for KITAHACK 2026:

- **Flutter Framework** - Used to build the entire mobile application frontend, powering all user interfaces including the welcome screen, dashboards, food upload forms, recipe browsers, QR scanner, and AI recipe generator. Flutter enables smooth cross-platform development with a single codebase for both Android and iOS.

- **Google AI Studio (Gemini API)** - Integrated in the backend AI service to provide intelligent recipe suggestions. The Gemini 2.5 Flash model analyzes user-provided ingredients, dietary preferences, and cuisine types to generate detailed recipes with cooking instructions, ingredient measurements, preparation times, and helpful cooking tips.

## Setup Instructions

### Prerequisites
- Flutter SDK installed
- Python 3.8+ installed
- Node.js installed
- Android Studio with Android SDK

### Backend Setup
```bash
cd backend
pip install -r requirements.txt
npm install
```

Create a .env file with your Gemini API key:
```
GEMINI_API_KEY=your_api_key_here
PYTHON_PORT=5000
PORT=3000
```

Start the services:
```bash
python main.py
node server.js
```

### Frontend Setup
```bash
cd frontend
flutter pub get
flutter run
```

## Team

Team PisangGoreng
