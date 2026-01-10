import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/app_theme.dart';
import '../utils/api_config.dart';

class AIRecipeScreen extends StatefulWidget {
  const AIRecipeScreen({super.key});

  @override
  State<AIRecipeScreen> createState() => _AIRecipeScreenState();
}

class _AIRecipeScreenState extends State<AIRecipeScreen> {
  static const bool _forceOfflineAi = bool.fromEnvironment(
    'AI_OFFLINE',
    defaultValue: true,
  );

  final TextEditingController _ingredientController = TextEditingController();
  final List<String> _ingredients = [];
  String? _selectedCuisine;
  String? _selectedDietary;
  bool _isLoading = false;
  Map<String, dynamic>? _generatedRecipe;
  bool _isDemoMode = _forceOfflineAi;

  final List<String> _cuisineTypes = [
    'Italian',
    'Chinese',
    'Mexican',
    'Indian',
    'Japanese',
    'Thai',
    'French',
    'American',
    'Mediterranean',
  ];

  final List<String> _dietaryOptions = [
    'Vegetarian',
    'Vegan',
    'Gluten-free',
    'Dairy-free',
    'Low-carb',
    'Keto',
  ];

  @override
  void dispose() {
    _ingredientController.dispose();
    super.dispose();
  }

  Future<void> _generateRecipe() async {
    if (_ingredients.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please add at least one ingredient'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _generatedRecipe = null;
    });

    try {
      if (_forceOfflineAi) {
        await Future<void>.delayed(const Duration(milliseconds: 600));
        setState(() {
          _generatedRecipe = _buildMockRecipe(
            ingredients: _ingredients,
            cuisineType: _selectedCuisine,
            dietaryPreferences: _selectedDietary,
          );
          _isDemoMode = true;
        });
        return;
      }

      final response = await http
          .post(
            Uri.parse(ApiConfig.recipeUrl),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'ingredients': _ingredients,
              if (_selectedCuisine != null) 'cuisine_type': _selectedCuisine,
              if (_selectedDietary != null)
                'dietary_preferences': _selectedDietary,
            }),
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          setState(() {
            _generatedRecipe = data['recipe'];
            _isDemoMode = false;
          });
        } else {
          _useMockFallback();
        }
      } else {
        _useMockFallback();
      }
    } catch (e) {
      _useMockFallback();
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _useMockFallback() {
    setState(() {
      _generatedRecipe = _buildMockRecipe(
        ingredients: _ingredients,
        cuisineType: _selectedCuisine,
        dietaryPreferences: _selectedDietary,
      );
      _isDemoMode = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Demo mode: showing offline recipe suggestion'),
        backgroundColor: const Color(0xFF5D4037),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Map<String, dynamic> _buildMockRecipe({
    required List<String> ingredients,
    String? cuisineType,
    String? dietaryPreferences,
  }) {
    final cleanedIngredients = ingredients
        .map((i) => i.trim())
        .where((i) => i.isNotEmpty)
        .toList();

    cleanedIngredients.sort(
      (a, b) => a.toLowerCase().compareTo(b.toLowerCase()),
    );

    final cuisine = (cuisineType?.trim().isNotEmpty ?? false)
        ? cuisineType!.trim()
        : 'Fusion';
    final dietary = (dietaryPreferences?.trim().isNotEmpty ?? false)
        ? dietaryPreferences!.trim()
        : null;
    final main = cleanedIngredients.isNotEmpty
        ? _titleCase(cleanedIngredients.first)
        : 'Pantry';

    final servings = cleanedIngredients.length <= 2
        ? 2
        : (cleanedIngredients.length <= 5 ? 3 : 4);
    final prepMinutes = 8 + (cleanedIngredients.length * 2);
    final cookMinutes = 12 + (cleanedIngredients.length * 3);

    final recipeName = dietary == null
        ? '$cuisine $main Bowl'
        : '$cuisine $main Bowl (${dietary})';

    final descriptionParts = <String>[
      'A quick $cuisine-inspired recipe built from your ingredients.',
      if (dietary != null) 'Designed to fit a $dietary lifestyle.',
      'Great for a smooth offline demo — no server needed.',
    ];

    final ingredientLines = <String>[
      for (final ingredient in cleanedIngredients)
        '• 1 portion ${_titleCase(ingredient)}',
      '• 1 tbsp cooking oil',
      '• 1 clove garlic (optional)',
      '• Salt & pepper to taste',
      if (cuisine.toLowerCase().contains('italian'))
        '• 1 tsp dried herbs (oregano/basil)',
      if (cuisine.toLowerCase().contains('chinese'))
        '• 1 tbsp soy sauce (optional)',
      if (cuisine.toLowerCase().contains('mexican'))
        '• 1/2 tsp chili powder (optional)',
      if (cuisine.toLowerCase().contains('indian'))
        '• 1/2 tsp curry powder (optional)',
    ];

    final steps = <String>[
      'Prep: rinse/chop your ingredients and keep them ready.',
      'Heat a pan over medium heat and add oil.',
      'Add garlic (optional) and stir for 20–30 seconds.',
      'Add the main ingredients and cook until aromatic and heated through.',
      'Season with salt & pepper and add any $cuisine-style optional seasoning.',
      'Serve warm in a bowl. Adjust taste and enjoy.',
    ];

    final tips = <String>[
      'Cut ingredients into similar sizes for even cooking.',
      'If it feels dry, add a splash of water or stock while cooking.',
      'Finish with a squeeze of lime/lemon or herbs for freshness.',
    ];

    return {
      'recipe_name': recipeName,
      'description': descriptionParts.join(' '),
      'prep_time': '$prepMinutes minutes',
      'cook_time': '$cookMinutes minutes',
      'servings': servings,
      'ingredients': ingredientLines,
      'steps': steps,
      'tips': tips,
    };
  }

  String _titleCase(String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return trimmed;
    return trimmed[0].toUpperCase() + trimmed.substring(1);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 5),
      ),
    );
  }

  void _addIngredient() {
    final ingredient = _ingredientController.text.trim();
    if (ingredient.isNotEmpty && !_ingredients.contains(ingredient)) {
      setState(() {
        _ingredients.add(ingredient);
        _ingredientController.clear();
      });
    }
  }

  void _removeIngredient(String ingredient) {
    setState(() {
      _ingredients.remove(ingredient);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9EC),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'AI Recipe Generator',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF5D4037),
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Column(
        children: [
          if (_isDemoMode) _buildDemoBanner(),
          Expanded(
            child: _generatedRecipe == null
                ? _buildInputForm()
                : _buildRecipeResult(),
          ),
        ],
      ),
    );
  }

  Widget _buildDemoBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: const Color(0xFF5D4037),
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: Colors.white),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Demo mode: offline recipe suggestions (no backend required)',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontSize: 13,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _isDemoMode = false;
              });
            },
            style: TextButton.styleFrom(foregroundColor: Colors.white70),
            child: const Text('Hide', style: TextStyle(fontFamily: 'Poppins')),
          ),
        ],
      ),
    );
  }

  Widget _buildInputForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF5D4037).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.auto_awesome,
                  color: const Color(0xFF5D4037),
                  size: 32,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Tell me what ingredients you have, and I\'ll suggest a delicious recipe!',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: const Color(0xFF5D4037),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Ingredients input
          Text(
            'Your Ingredients',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _ingredientController,
                  decoration: InputDecoration(
                    hintText: 'e.g., chicken, rice, tomatoes',
                    hintStyle: const TextStyle(fontFamily: 'Poppins'),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xFF5D4037),
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xFF5D4037),
                        width: 2,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  onSubmitted: (_) => _addIngredient(),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: _addIngredient,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5D4037),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(14),
                ),
                child: const Icon(Icons.add),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Ingredients chips
          if (_ingredients.isNotEmpty) ...[
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _ingredients.map((ingredient) {
                return Chip(
                  label: Text(
                    ingredient,
                    style: const TextStyle(fontFamily: 'Poppins'),
                  ),
                  onDeleted: () => _removeIngredient(ingredient),
                  deleteIcon: const Icon(Icons.close, size: 18),
                  backgroundColor: const Color(0xFF5D4037).withOpacity(0.1),
                  deleteIconColor: const Color(0xFF5D4037),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
          ],

          // Cuisine type
          Text(
            'Cuisine Type (Optional)',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _cuisineTypes.map((cuisine) {
              final isSelected = _selectedCuisine == cuisine;
              return FilterChip(
                label: Text(
                  cuisine,
                  style: const TextStyle(fontFamily: 'Poppins'),
                ),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    _selectedCuisine = selected ? cuisine : null;
                  });
                },
                selectedColor: const Color(0xFF5D4037).withOpacity(0.2),
                checkmarkColor: const Color(0xFF5D4037),
                labelStyle: TextStyle(
                  color: isSelected
                      ? const Color(0xFF5D4037)
                      : Colors.grey[700],
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),

          // Dietary preferences
          Text(
            'Dietary Preferences (Optional)',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _dietaryOptions.map((dietary) {
              final isSelected = _selectedDietary == dietary;
              return FilterChip(
                label: Text(
                  dietary,
                  style: const TextStyle(fontFamily: 'Poppins'),
                ),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    _selectedDietary = selected ? dietary : null;
                  });
                },
                selectedColor: const Color(0xFF5D4037).withOpacity(0.2),
                checkmarkColor: const Color(0xFF5D4037),
                labelStyle: TextStyle(
                  color: isSelected
                      ? const Color(0xFF5D4037)
                      : Colors.grey[700],
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 32),

          // Generate button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _generateRecipe,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5D4037),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.auto_awesome),
                        SizedBox(width: 8),
                        Text(
                          'Generate Recipe with AI',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipeResult() {
    if (_generatedRecipe == null) return const SizedBox();

    final recipeName = _generatedRecipe!['recipe_name'] ?? 'Generated Recipe';
    final description = _generatedRecipe!['description'] ?? '';
    final prepTime = _generatedRecipe!['prep_time'] ?? 'N/A';
    final cookTime = _generatedRecipe!['cook_time'] ?? 'N/A';
    final servings = _generatedRecipe!['servings']?.toString() ?? 'N/A';
    final ingredients =
        (_generatedRecipe!['ingredients'] as List?)?.cast<String>() ?? [];
    final steps = (_generatedRecipe!['steps'] as List?)?.cast<String>() ?? [];
    final tips = (_generatedRecipe!['tips'] as List?)?.cast<String>() ?? [];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Recipe header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF5D4037),
                  const Color(0xFF5D4037).withOpacity(0.8),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.auto_awesome,
                      color: Colors.white,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _isDemoMode ? 'Demo AI (Offline)' : 'AI Generated',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontFamily: 'Poppins',
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  recipeName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                if (description.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Time and servings info
          Row(
            children: [
              Expanded(child: _buildInfoCard(Icons.schedule, 'Prep', prepTime)),
              const SizedBox(width: 12),
              Expanded(child: _buildInfoCard(Icons.timer, 'Cook', cookTime)),
              const SizedBox(width: 12),
              Expanded(
                child: _buildInfoCard(Icons.restaurant, 'Serves', servings),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Ingredients
          if (ingredients.isNotEmpty) ...[
            _buildSectionTitle('Ingredients'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                children: ingredients.asMap().entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.check_circle,
                          size: 20,
                          color: Color(0xFF5D4037),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            entry.value,
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),
          ],

          // Steps
          if (steps.isNotEmpty) ...[
            _buildSectionTitle('Instructions'),
            const SizedBox(height: 12),
            ...steps.asMap().entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: const Color(0xFF5D4037),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${entry.key + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        entry.value,
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 24),
          ],

          // Tips
          if (tips.isNotEmpty) ...[
            _buildSectionTitle('Chef\'s Tips'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF9C4),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFFDD835)),
              ),
              child: Column(
                children: tips.map((tip) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.lightbulb,
                          size: 20,
                          color: Color(0xFFF57C00),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            tip,
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],

          const SizedBox(height: 32),

          // Action buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    setState(() {
                      _generatedRecipe = null;
                      _ingredients.clear();
                      _selectedCuisine = null;
                      _selectedDietary = null;
                    });
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text(
                    'New Recipe',
                    style: TextStyle(fontFamily: 'Poppins'),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF5D4037),
                    side: const BorderSide(color: Color(0xFF5D4037)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.check),
                  label: const Text(
                    'Done',
                    style: TextStyle(fontFamily: 'Poppins'),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5D4037),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFF5D4037), size: 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey[600],
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins',
      ),
    );
  }
}
