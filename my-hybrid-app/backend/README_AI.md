# AI Recipe Suggestion Service

This Python service uses Google's Gemini 2.0 Flash model to provide intelligent recipe suggestions based on available ingredients.

## Setup

1. **Install Python dependencies:**
   ```bash
   pip install -r requirements.txt
   ```

2. **Configure API Key:**
   - Open `.env` file
   - Replace `your_gemini_api_key_here` with your actual Gemini API key
   - Get your API key from: https://makersuite.google.com/app/apikey

3. **Run the service:**
   ```bash
   python main.py
   ```

   The service will start on `http://localhost:5000`

## API Endpoints

### 1. Health Check
```
GET /health
```
Check if the service is running.

### 2. Generate Recipe Suggestion
```
POST /api/recipe/suggest
Content-Type: application/json

{
  "ingredients": ["chicken", "tomatoes", "pasta"],
  "dietary_preferences": "vegetarian",  // optional
  "cuisine_type": "Italian"              // optional
}
```

### 3. Quick Suggestion (GET)
```
GET /api/recipe/quick-suggest?ingredients=chicken,tomatoes,pasta&cuisine=Italian
```

### 4. Chat About Recipe
```
POST /api/recipe/chat
Content-Type: application/json

{
  "question": "How do I know when chicken is cooked?",
  "recipe_context": {...}  // optional
}
```

## Testing

Test the AI service directly:
```bash
python ai_recipe_suggest.py
```

## Example Usage from Flutter

```dart
// In your Flutter app
final response = await http.post(
  Uri.parse('http://localhost:5000/api/recipe/suggest'),
  headers: {'Content-Type': 'application/json'},
  body: jsonEncode({
    'ingredients': ['chicken', 'garlic', 'pasta'],
    'cuisine_type': 'Italian',
  }),
);

final data = jsonDecode(response.body);
if (data['success']) {
  final recipe = data['recipe'];
  print('Recipe: ${recipe['recipe_name']}');
}
```

## Environment Variables

- `GEMINI_API_KEY`: Your Google Gemini API key (required)
- `PYTHON_PORT`: Port for Flask server (default: 5000)
- `FLASK_DEBUG`: Enable debug mode (default: False)
