from flask import Flask, request, jsonify
from flask_cors import CORS
from ai_recipe_suggest import AIRecipeSuggester
import os
from dotenv import load_dotenv

load_dotenv()

app = Flask(__name__)
CORS(app)

ai_suggester = AIRecipeSuggester()

@app.route('/health', methods=['GET'])
def health_check():
    return jsonify({
        'status': 'OK',
        'message': 'AI Recipe Service is running',
        'model': 'gemini-2.0-flash-exp'
    }), 200

@app.route('/api/recipe/suggest', methods=['POST'])
def suggest_recipe():
    try:
        data = request.get_json()
        
        if not data or 'ingredients' not in data:
            return jsonify({
                'success': False,
                'error': 'Ingredients list is required'
            }), 400
        
        ingredients = data.get('ingredients', [])
        dietary_preferences = data.get('dietary_preferences')
        cuisine_type = data.get('cuisine_type')
        
        if not ingredients or len(ingredients) == 0:
            return jsonify({
                'success': False,
                'error': 'Please provide at least one ingredient'
            }), 400
        
        result = ai_suggester.generate_recipe(
            ingredients=ingredients,
            dietary_preferences=dietary_preferences,
            cuisine_type=cuisine_type
        )
        
        if result['success']:
            return jsonify(result), 200
        else:
            return jsonify(result), 500
            
    except Exception as e:
        return jsonify({
            'success': False,
            'error': str(e)
        }), 500

@app.route('/api/recipe/chat', methods=['POST'])
def recipe_chat():
    try:
        data = request.get_json()
        
        if not data or 'question' not in data:
            return jsonify({
                'success': False,
                'error': 'Question is required'
            }), 400
        
        question = data.get('question')
        recipe_context = data.get('recipe_context')
        
        result = ai_suggester.chat_about_recipe(
            question=question,
            recipe_context=recipe_context
        )
        
        if result['success']:
            return jsonify(result), 200
        else:
            return jsonify(result), 500
            
    except Exception as e:
        return jsonify({
            'success': False,
            'error': str(e)
        }), 500

@app.route('/api/recipe/quick-suggest', methods=['GET'])
def quick_suggest():
    try:
        ingredients_str = request.args.get('ingredients', '')
        
        if not ingredients_str:
            return jsonify({
                'success': False,
                'error': 'Please provide ingredients as query parameter'
            }), 400
        
        ingredients = [i.strip() for i in ingredients_str.split(',')]
        cuisine_type = request.args.get('cuisine')
        dietary = request.args.get('dietary')
        
        result = ai_suggester.generate_recipe(
            ingredients=ingredients,
            dietary_preferences=dietary,
            cuisine_type=cuisine_type
        )
        
        if result['success']:
            return jsonify(result), 200
        else:
            return jsonify(result), 500
            
    except Exception as e:
        return jsonify({
            'success': False,
            'error': str(e)
        }), 500

if __name__ == '__main__':
    port = int(os.getenv('PYTHON_PORT', 5000))
    debug = os.getenv('FLASK_DEBUG', 'False').lower() == 'true'
    
    print(f"Starting AI Recipe Service on port {port}")
    print(f"Using Gemini 2.5 Flash model")
    print(f"Debug mode: {debug}")
    
    app.run(
        host='0.0.0.0',
        port=port,
        debug=debug
    )
