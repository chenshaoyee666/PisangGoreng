🧩 SMARTBITE – AI PROTOTYPE PROMPT (Frontend Only)

Prompt:

You are designing the frontend prototype only for an AI-powered food waste reduction app called SmartBite.
Focus purely on the UI/UX flow, screens, buttons, layout, and user experience — do not include business analysis, SDG text, or impact summaries directly in the frontend.
The prototype should look like a real working mobile app with logical screens, buttons, and fake data flow (but no backend integration).

🧠 OVERVIEW

SmartBite is a community-based food management app that allows people to donate or receive near-expiry food safely.
The app has two user roles:

Donor → (Use nicer label: “Sharer”) — people who upload or share food.

Recipient — people in need who can request or claim food.

The app emphasizes:

Reducing food waste

Supporting hunger relief

Protecting privacy and safety of all users

The design must be clean, friendly, and trust-driven, with soft green or pastel orange tones to represent sustainability and warmth.

🧩 MAIN FEATURES (Frontend Modules)
1️⃣ Food Scanning & Upload

Page where the Sharer can upload a photo or manually fill in:

Food name

Category

HALAL / Non-HALAL option

Expiry date

Approximate price or value

Option to either Scan (AI simulation) or Manual Input.

For scanning, simulate a “fake searching animation screen” (like a loading bar or “Detecting food type…” popup).

Show detected info automatically filled in the form (e.g. “Detected: Chicken Breast, expires in 3 days”).

Include “Edit details” button for correction.

2️⃣ Action Choice Page

After detecting food, users see two large options:

Option 1: Deliver / Share

Option 2: Cook

Option 1 – Deliver Flow

User clicks “Deliver to Community Hub.”

Show a confirmation popup like “A driver will be arranged to pick up your food safely.”

Then transition to a mock map page:

Fake driver icon moving toward pickup point.

ETA countdown (e.g., “Driver arriving in 7 mins”).

“Track Driver” button.

Delivery progress stages: Picked up → On the way → Delivered to Hub.

Add note: “All donors are verified for safety. NRIC verification is required but simple and secure (upload + instant check).”

Small reminder: “SmartBite’s community hubs are managed with our partner NGOs and sponsors.”

Option 2 – Cook Flow

Users can explore recipe suggestions based on detected food.

Include filter bar: Popular | Clean | Vegan | Snacks | Trending.

Display AI-suggested cards (hardcoded examples are fine):

“Leftover Chicken Fried Rice”

“Crispy Vegan Patties”

“No-Oven Banana Cake”

Each recipe card: image + short cooking time + category tag.

Include “Save Recipe” and “Share Recipe” buttons.

3️⃣ Recipient Flow

At the welcome page, show two login buttons:

“Continue as Sharer” (donor role)

“Continue as Recipient”

Recipient flow UI should emphasize privacy and dignity.

After login, the recipient dashboard includes:

“My Claimed Items” — showing list of items with expiry countdowns.

“This Week Claimed” — a tracker (e.g., “RM 45 worth of food claimed”).

Button: “Scan QR to Claim” — opens camera UI to simulate QR scanning.

Simple note: “Each account may claim limited food value per month to ensure fair distribution.”

When claiming, show Claim Confirmation Screen with QR checkmark animation and item details (fake values OK).

4️⃣ About Us Page

Create a simple “About Us” or “Our Mission” page with:

Vision: Reduce food wastage and feed communities through smart technology.

Mission: Empower households to share surplus food and support those in need securely.

Collaborating Partners: logos or name placeholders (e.g., GrabExpress, FoodPanda Donate, ZeroHunger NGO, Tesco, Lotus’s).

Multilingual toggle: Chinese 🇨🇳, English 🇬🇧, Malay 🇲🇾.

5️⃣ Navigation / Tabs

Bottom tab bar or sidebar with:

Home

Scan / Upload

Recipes

Donation Map

About Us

🏗️ LOGIC TO FOLLOW (Frontend Behavior Only)

Emphasize expiry dates visually (colored labels: red = expiring soon, green = safe).

Multilingual toggle should affect all text instantly.

Fake progress animations for scanning, searching, and delivery (no backend).

Store sample data in mock states only (no database).

Avoid text about SDGs or business impact directly on screens — only design consistent with SDG 2 and SDG 12 goals.

💼 BUSINESS VALUE (Instruction for Logic, not for Display)

The prototype should reflect:

Low commission fee logic (~1–2%) for sustainability.

Partnerships and sponsorship sections visually represented via logos.

Donor trust mechanisms (e.g., NRIC upload UI that looks easy and fast).

Recipient privacy emphasized (no public identity display).

Simulated logistics handled via “SmartBite Community Hubs”.

✅ DESIGN STYLE

Color Palette: soft green (#7BC67E), warm orange (#F9A03F), white background, subtle grey text.

Typography: clean, rounded, friendly (like Poppins or Nunito).

Layout: card-based, generous padding, visual hierarchy for clarity.

Tone: caring, helpful, inclusive.

Iconography: minimal, expressive (use icons for food, truck, cooking, and QR).

⚙️ TECH HINTS (for the agent, not displayed)

Assume standard mobile viewport (iPhone 14 size).

Keep components responsive.

Use placeholder assets or auto-generated icons.

Use fake transitions (fade, slide, progress bar).

Final instruction:

Focus ONLY on the frontend user experience and screen flow.
Don’t include text like “business model,” “impact,” or “SDG” in the visible app.
Just ensure the design reflects the mission of reducing food waste and feeding people sustainably.