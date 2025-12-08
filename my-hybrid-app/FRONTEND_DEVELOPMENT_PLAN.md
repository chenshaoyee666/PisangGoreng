# 🧩 SmartBite Frontend Development Plan

## 📋 Project Overview
**App Name:** SmartBite - AI-powered food waste reduction app  
**Target:** Flutter mobile app with clean, friendly UI  
**Theme:** Sustainability (soft green) + warmth (pastel orange)  
**Core Users:** Sharers (donors) + Recipients  

---

## 🎨 Design System & Setup

### Color Palette
- **Primary Green:** `#7BC67E` (sustainability)
- **Accent Orange:** `#F9A03F` (warmth) 
- **Background:** `#FFFFFF`
- **Text:** Subtle grey variations
- **Status Colors:** Red (expiring), Green (safe)

### Typography & Style
- **Font:** Poppins/Nunito (rounded, friendly)
- **Layout:** Card-based with generous padding
- **Icons:** Minimal, expressive (food, truck, cooking, QR)
- **Animations:** Fade, slide, progress bars

---

## 📱 Screen Architecture & Navigation

### Bottom Navigation Tabs
1. **Home** - Dashboard/welcome
2. **Scan/Upload** - Food detection & upload
3. **Recipes** - AI cooking suggestions  
4. **Donation Map** - Community hubs tracking
5. **About Us** - Mission & partners

### User Role Flow
```
Welcome Screen
├── "Continue as Sharer" → Sharer Dashboard
└── "Continue as Recipient" → Recipient Dashboard
```

---

## 🔥 Phase 1: Core Screens Setup (Foundation)

### 1.1 Welcome & Authentication Screens
- [ ] **Welcome Screen**
  - Two large buttons: "Continue as Sharer" / "Continue as Recipient"
  - App logo and tagline
  - Language toggle (🇬🇧 🇨🇳 🇲🇾)

- [ ] **Role Selection Logic**
  - Store user role in app state
  - Route to appropriate dashboard

### 1.2 Basic Navigation Structure
- [ ] **Bottom Navigation Bar**
  - 5 tabs with icons
  - Active/inactive states
  - Role-based visibility (some tabs hidden for recipients)

- [ ] **Drawer/Sidebar** (if needed)
  - User profile section
  - Settings
  - Language switcher
  - Logout option

---

## 🔥 Phase 2: Sharer (Donor) Flow

### 2.1 Food Scanning & Upload Screen
- [ ] **Camera Integration**
  - Camera preview widget
  - Capture button with animation
  - Gallery selection option
  
- [ ] **Scan vs Manual Toggle**
  - Two tabs: "AI Scan" / "Manual Input"
  - Switch between camera and form

- [ ] **AI Scanning Simulation**
  - Loading animation: "Detecting food type..."
  - Progress bar (3-5 seconds fake delay)
  - "Food detected!" success animation

- [ ] **Food Details Form**
  - Food name (auto-filled from scan)
  - Category dropdown (Fruits, Vegetables, Meat, etc.)
  - Halal/Non-Halal toggle switch
  - Expiry date picker with calendar
  - Approximate value input (RM)
  - "Edit Details" button for scan corrections

### 2.2 Action Choice Screen
- [ ] **Two Large Action Cards**
  - "Deliver to Community" card with delivery icon
  - "Cook with AI Recipes" card with cooking icon
  - Visual hierarchy with clear CTAs

### 2.3 Delivery Flow Screens
- [ ] **Delivery Confirmation Popup**
  - "A driver will be arranged to pick up your food safely"
  - NRIC verification note (trust building)
  - "Confirm Pickup" button

- [ ] **Driver Tracking Screen**
  - Mock map widget with driver icon
  - ETA countdown timer
  - Driver details card
  - Progress stages: "Driver assigned" → "Picking up" → "Delivered"
  - "Track Driver" floating action button

- [ ] **Delivery Success Screen**
  - Success checkmark animation
  - "Food delivered to Community Hub!"
  - Impact summary (fake metrics)
  - "Share Achievement" button

---

## 🔥 Phase 3: Recipe Suggestion Flow

### 3.1 Recipe Discovery Screen
- [ ] **Filter Bar**
  - Horizontal scrollable chips: Popular, Clean, Vegan, Snacks, Trending
  - Active filter highlighting

- [ ] **Recipe Cards Grid**
  - Image placeholder + title + cooking time
  - Category tags
  - Grid/List view toggle

- [ ] **Sample Recipe Data**
  - "Leftover Chicken Fried Rice" (15 mins)
  - "Crispy Vegan Patties" (20 mins) 
  - "No-Oven Banana Cake" (30 mins)
  - More hardcoded examples

### 3.2 Recipe Detail Screen
- [ ] **Recipe Header**
  - Large food image
  - Title and cooking time
  - Difficulty level
  - "Save Recipe" heart icon

- [ ] **Ingredients List**
  - Checkable ingredient items
  - Quantity and unit display

- [ ] **Cooking Steps**
  - Numbered step cards
  - Clear instructions
  - Timer buttons for each step

- [ ] **Action Buttons**
  - "Start Cooking" (timer mode)
  - "Share Recipe" 
  - "Save to Favorites"

---

## 🔥 Phase 4: Recipient Flow

### 4.1 Recipient Dashboard
- [ ] **Privacy-First Design**
  - No personal info display
  - Anonymous user icon
  - Privacy emphasis in copy

- [ ] **My Claimed Items Widget**
  - List of claimed food items
  - Expiry countdown timers
  - Color-coded urgency (red/green)

- [ ] **Monthly Tracker**
  - "This Week Claimed: RM 45 worth"
  - Progress bar toward monthly limit
  - Fair distribution messaging

- [ ] **QR Scan Button**
  - Large, prominent "Scan QR to Claim" button
  - Camera icon with scan animation

### 4.2 QR Scanning & Claiming
- [ ] **QR Scanner Screen**
  - Camera overlay with scan frame
  - "Point camera at QR code" instruction
  - Flashlight toggle

- [ ] **Claim Confirmation Screen**
  - Success checkmark animation
  - Item details display
  - Expiry information
  - "Claimed successfully!" message

- [ ] **Claimed Items List**
  - Chronological order
  - Item photos and details
  - Countdown timers
  - "Use before" reminders

---

## 🔥 Phase 5: About Us & Supporting Screens

### 5.1 About Us Screen
- [ ] **Mission Section**
  - Vision statement
  - Mission description
  - Values showcase

- [ ] **Partners Section**
  - Logo grid/carousel
  - Partner names: GrabExpress, FoodPanda Donate, ZeroHunger NGO, Tesco, Lotus's
  - Placeholder logos with proper spacing

### 5.2 Settings & Preferences
- [ ] **Language Settings**
  - Toggle between Chinese 🇨🇳, English 🇬🇧, Malay 🇲🇾
  - Instant UI language switching
  - Localized text constants

- [ ] **Notification Settings**
  - Push notification toggles
  - Delivery updates
  - Recipe suggestions
  - Expiry reminders

### 5.3 Help & Support
- [ ] **FAQ Section**
  - Expandable question cards
  - Search functionality
  - Categories: Sharing, Claiming, Safety, etc.

- [ ] **Contact Support**
  - Chat bubble simulation
  - Contact form
  - Emergency contact info

---

## 🔥 Phase 6: Interactive Features & Animations

### 6.1 Loading & Progress Animations
- [ ] **Food Scanning Animation**
  - Shimmer effect during scan
  - Progress percentage
  - Success/failure animations

- [ ] **Delivery Tracking**
  - Moving driver icon on map
  - ETA countdown with smooth updates
  - Progress indicator dots

### 6.2 Micro-Interactions
- [ ] **Button Press Feedback**
  - Subtle scale animations
  - Color transitions
  - Haptic feedback simulation

- [ ] **Card Animations**
  - Slide-in transitions
  - Swipe gestures for recipe cards
  - Pull-to-refresh on lists

### 6.3 State Management
- [ ] **User Role State**
  - Persist sharer/recipient choice
  - Show/hide relevant screens

- [ ] **Form State Management**
  - Auto-save draft entries
  - Validation feedback
  - Error handling

---

## 🔥 Phase 7: Data & Content Management

### 7.1 Mock Data Structure
- [ ] **Food Categories**
```dart
enum FoodCategory { fruits, vegetables, meat, dairy, grains, prepared }
```

- [ ] **Sample Food Items**
```dart
List<FoodItem> mockFoodItems = [
  FoodItem(name: "Chicken Breast", category: meat, expiryDays: 3),
  // More samples...
]
```

- [ ] **Recipe Database**
```dart
List<Recipe> mockRecipes = [
  Recipe(title: "Leftover Chicken Fried Rice", cookTime: 15),
  // More samples...
]
```

### 7.2 Localization Strings
- [ ] **English Strings**
- [ ] **Chinese Translations** 
- [ ] **Malay Translations**
- [ ] **Dynamic Language Switching**

---

## 🔥 Phase 8: Final Polish & Testing

### 8.1 UI Consistency Check
- [ ] **Color Scheme Compliance**
  - All screens use defined color palette
  - Consistent spacing and typography
  - Proper contrast ratios

- [ ] **Responsive Design**
  - Test on different screen sizes
  - Landscape mode handling
  - Safe area considerations

### 8.2 User Experience Flow
- [ ] **Complete User Journey Testing**
  - Sharer flow: Upload → Action Choice → Delivery/Recipe
  - Recipient flow: Login → Browse → Claim → Track
  - Navigation consistency

### 8.3 Performance Optimization
- [ ] **Image Optimization**
  - Placeholder images
  - Lazy loading for lists
  - Smooth scrolling

- [ ] **Animation Performance**
  - 60fps animations
  - Reduced motion options
  - Memory management

---

## 📦 Deliverables Checklist

### Core Screens (Must Have)
- [ ] Welcome & Role Selection
- [ ] Food Upload & Scanning
- [ ] Action Choice (Deliver/Cook)
- [ ] Delivery Tracking
- [ ] Recipe Suggestions
- [ ] Recipient Dashboard
- [ ] QR Scanning & Claiming
- [ ] About Us

### Enhanced Features (Nice to Have)
- [ ] Advanced animations
- [ ] Multiple language support
- [ ] Detailed recipe instructions
- [ ] Partner showcases
- [ ] Help & support sections

### Technical Requirements
- [ ] Clean, maintainable code structure
- [ ] Proper state management
- [ ] Responsive design
- [ ] Mock data integration
- [ ] Navigation flow consistency

---

## ⏱️ Estimated Timeline

**Phase 1-2:** Foundation & Sharer Flow (2-3 days)  
**Phase 3:** Recipe Features (1-2 days)  
**Phase 4:** Recipient Flow (1-2 days)  
**Phase 5-6:** Supporting Screens & Animations (1-2 days)  
**Phase 7-8:** Polish & Testing (1 day)

**Total Estimated Time:** 6-10 days for complete frontend prototype

---

## 🎯 Success Criteria

1. **Visual Appeal:** Clean, friendly UI matching design requirements
2. **User Flow:** Logical navigation between all screens  
3. **Feature Completeness:** All major features implemented with mock data
4. **Performance:** Smooth animations and responsive interactions
5. **Accessibility:** Proper contrast, readable text, intuitive icons
6. **Sustainability Theme:** Green/orange color scheme consistently applied

This frontend prototype will demonstrate the complete SmartBite user experience without backend integration, perfect for showcasing the app concept and user journey!