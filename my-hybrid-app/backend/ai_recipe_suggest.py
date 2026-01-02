import os
import json
import google.generativeai as genai
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

# Configure Gemini API
genai.configure(api_key=os.getenv('GEMINI_API_KEY'))

class AIRecipeSuggester:
    def __init__(self):
        self.model = genai.GenerativeModel('gemini-2.0-flash-exp')
        self.system_prompt = """You are a professional chef with expertise in global cuisines and creative cooking. 
Your role is to suggest delicious recipes based on the ingredients provided by users.

Guidelines:
- Provide practical, detailed step-by-step cooking instructions
- Include preparation time, cooking time, and serving size
- Suggest ingredient substitutions when relevant
- Include helpful cooking tips and techniques
- Be creative but realistic with the ingredients available
- Format responses clearly with sections for ingredients and steps
- Consider dietary preferences or restrictions if mentioned
"""

    def generate_recipe(self, ingredients, dietary_preferences=None, cuisine_type=None):
        """
        Generate a recipe suggestion based on ingredients
        
        Args:
            ingredients (list): List of available ingredients
            dietary_preferences (str, optional): E.g., 'vegetarian', 'vegan', 'gluten-free'
            cuisine_type (str, optional): E.g., 'Italian', 'Asian', 'Mexican'
        
        Returns:
            dict: Recipe with name, ingredients, steps, cooking time, etc.
        """
        try:
            # Build the user prompt
            ingredients_text = ", ".join(ingredients)
            user_prompt = f"I have these ingredients: {ingredients_text}."
            
            if dietary_preferences:
                user_prompt += f" I prefer {dietary_preferences} recipes."
            
            if cuisine_type:
                user_prompt += f" I'd like to make {cuisine_type} cuisine."
            
            user_prompt += "\n\nPlease suggest a delicious recipe with detailed instructions. Format your response as JSON with the following structure:\n"
            user_prompt += """
{
  "recipe_name": "Name of the dish",
  "description": "Brief description",
  "prep_time": "X minutes",
  "cook_time": "X minutes",
  "servings": X,
  "ingredients": [
    "ingredient 1 with quantity",
    "ingredient 2 with quantity"
  ],
  "steps": [
    "Step 1 instruction",
    "Step 2 instruction"
  ],
  "tips": [
    "Helpful tip 1",
    "Helpful tip 2"
  ]
}
"""
            
            # Generate response
            response = self.model.generate_content(
                self.system_prompt + "\n\n" + user_prompt,
                generation_config={
                    'temperature': 0.7,
                    'top_p': 0.95,
                    'max_output_tokens': 2048,
                }
            )
            
            # Parse the response
            recipe_text = response.text.strip()
            
            # Remove markdown code blocks if present
            if recipe_text.startswith('```json'):
                recipe_text = recipe_text.replace('```json', '').replace('```', '').strip()
            elif recipe_text.startswith('```'):
                recipe_text = recipe_text.replace('```', '').strip()
            
            recipe_data = json.loads(recipe_text)
            
            return {
                'success': True,
                'recipe': recipe_data
            }
            
        except json.JSONDecodeError as e:
            # If JSON parsing fails, return the raw text
            return {
                'success': True,
                'recipe': {
                    'recipe_name': 'AI Generated Recipe',
                    'description': response.text,
                    'raw_response': True
                }
            }
        except Exception as e:
            return {
                'success': False,
                'error': str(e)
            }

    def chat_about_recipe(self, question, recipe_context=None):
        """
        Chat with AI about cooking questions or recipe modifications
        
        Args:
            question (str): User's cooking question
            recipe_context (dict, optional): Current recipe context
        
        Returns:
            dict: AI response
        """
        try:
            prompt = self.system_prompt + "\n\n"
            
            if recipe_context:
                prompt += f"Recipe context: {json.dumps(recipe_context)}\n\n"
            
            prompt += f"User question: {question}"
            
            response = self.model.generate_content(
                prompt,
                generation_config={
                    'temperature': 0.8,
                    'top_p': 0.95,
                    'max_output_tokens': 1024,
                }
            )
            
            return {
                'success': True,
                'response': response.text
            }
            
        except Exception as e:
            return {
                'success': False,
                'error': str(e)
            }


if __name__ == "__main__":
    # Test the AI recipe suggester
    suggester = AIRecipeSuggester()
    
    # Test recipe generation
    print("Testing recipe generation...")
    print("-" * 50)
    
    test_ingredients = ["chicken", "tomatoes", "onions", "garlic", "pasta"]
    result = suggester.generate_recipe(
        ingredients=test_ingredients,
        dietary_preferences=None,
        cuisine_type="Italian"
    )
    
    if result['success']:
        recipe = result['recipe']
        print(f"\n✓ Recipe Generated: {recipe.get('recipe_name', 'Unknown')}")
        print(json.dumps(recipe, indent=2))
    else:
        print(f"\n✗ Error: {result['error']}")
    
    # Test chat functionality
    print("\n" + "=" * 50)
    print("Testing chat functionality...")
    print("-" * 50)
    
    chat_result = suggester.chat_about_recipe(
        "How do I know when the chicken is fully cooked?"
    )
    
    if chat_result['success']:
        print(f"\n✓ Chat Response:\n{chat_result['response']}")
    else:
        print(f"\n✗ Error: {chat_result['error']}")
