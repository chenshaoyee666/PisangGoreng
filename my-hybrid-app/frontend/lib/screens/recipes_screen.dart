import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/app_state.dart';
import '../utils/app_theme.dart';
import '../utils/translations.dart';
import '../models/recipe.dart';
import 'recipe_detail_screen.dart';
import 'ai_recipe_screen.dart';

class _BubbleBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..isAntiAlias = true;

    paint.color = const Color(0xFFFFE0B2).withOpacity(0.4); // light orange
    canvas.drawCircle(Offset(size.width * 0.2, size.height * 0.15), 60, paint);

    paint.color = const Color(0xFFB2DFDB).withOpacity(0.4); // light teal
    canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.10), 40, paint);

    paint.color = const Color(0xFFFFF9C4).withOpacity(0.4); // light yellow
    canvas.drawCircle(Offset(size.width * 0.7, size.height * 0.7), 80, paint);

    paint.color = const Color(0xFFD1C4E9).withOpacity(0.4); // light purple
    canvas.drawCircle(Offset(size.width * 0.1, size.height * 0.8), 50, paint);

    paint.color = const Color(0xFFB2DFDB).withOpacity(0.4); // light teal
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.5), 35, paint);

    paint.color = const Color(0xFFFFE0B2).withOpacity(0.4); // light orange
    canvas.drawCircle(Offset(size.width * 0.18, size.height * 0.97), 40, paint);

    paint.color = const Color(0xFFD1C4E9).withOpacity(0.4); // light purple
    canvas.drawCircle(Offset(size.width * 0.85, size.height * 0.93), 32, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({super.key});

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  String _selectedCategory = 'All';
  List<Recipe> _recipes = [];
  List<Recipe> _filteredRecipes = [];
  final List<String> _userIngredients = [];
  bool _showIngredientSearch = false;
  final TextEditingController _ingredientController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  @override
  void dispose() {
    _ingredientController.dispose();
    super.dispose();
  }

  void _loadRecipes() {
    setState(() {
      _recipes = RecipeDatabase.getAllRecipes();
      _filterRecipes();
    });
  }

  void _filterRecipes() {
    setState(() {
      if (_userIngredients.isNotEmpty) {
        _filteredRecipes = RecipeDatabase.searchRecipesByIngredients(_userIngredients);
        if (_selectedCategory != 'All') {
          _filteredRecipes = _filteredRecipes
              .where((recipe) => recipe.category == _selectedCategory)
              .toList();
        }
      } else {
        _filteredRecipes = _selectedCategory == 'All'
            ? _recipes
            : RecipeDatabase.getRecipesByCategory(_selectedCategory);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        final lang = appState.selectedLanguage;
        return Scaffold(
          backgroundColor: const Color(0xFFFFF9EC),
          body: Stack(
            children: [

              Positioned.fill(
                child: CustomPaint(
                  painter: _BubbleBackgroundPainter(),
                ),
              ),

              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Translations.get('recipe_discovery', lang),
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                                color: Color(0xFF4E342E), // dark brown
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                _showIngredientSearch ? Icons.list : Icons.search,
                                color: Color(0xFF4E342E), // dark brown
                              ),
                              onPressed: () {
                                setState(() {
                                  _showIngredientSearch = !_showIngredientSearch;
                                  if (!_showIngredientSearch) {
                                    _userIngredients.clear();
                                    _filterRecipes();
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        if (_showIngredientSearch) ...[
                          Text(
                            Translations.get('what_ingredients', lang),
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppTheme.textSecondary,
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
                                    hintText: 'Enter ingredient (e.g., chicken, rice)',
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(color: Color(0xFF5D4037), width: 1.5),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(color: Color(0xFF5D4037), width: 2),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(color: Color(0xFF5D4037), width: 1.5),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(color: Color(0xFF5D4037), width: 2),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                  ),
                                  onSubmitted: _addIngredient,
                                ),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () => _addIngredient(_ingredientController.text),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF5D4037),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Icon(Icons.add, color: Colors.white),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          if (_userIngredients.isNotEmpty) ...[
                            Wrap(
                              spacing: 8,
                              runSpacing: 4,
                              children: _userIngredients.map((ingredient) {
                                return Chip(
                                  label: Text(ingredient, style: const TextStyle(fontFamily: 'Poppins')),
                                  onDeleted: () => _removeIngredient(ingredient),
                                  deleteIcon: const Icon(Icons.close, size: 16),
                                  backgroundColor: AppTheme.primaryGreen.withValues(alpha: 0.1),
                                  deleteIconColor: const Color(0xFF5D4037),
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 8),
                          ]
                          else ...[
                            Text(
                              'Find delicious recipes using your ingredients',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppTheme.textSecondary,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ],
                      ],
                    ),
                  ),

                  Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: RecipeDatabase.getAllCategories().length,
                      itemBuilder: (context, index) {
                        final category = RecipeDatabase.getAllCategories()[index];
                        final isSelected = _selectedCategory == category;
                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: FilterChip(
                            label: Text(category),
                            selected: isSelected,
                            onSelected: (selected) {
                              setState(() {
                                _selectedCategory = category;
                                _filterRecipes();
                              });
                            },
                            selectedColor: const Color(0xFF5D4037).withValues(alpha: 0.2),
                            checkmarkColor: const Color(0xFF5D4037),
                            labelStyle: TextStyle(
                              color: isSelected ? const Color(0xFF5D4037) : AppTheme.textSecondary,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                              fontFamily: 'Poppins',
                            ),
                            side: BorderSide(
                              color: isSelected ? const Color(0xFF5D4037) : Colors.grey.shade300,
                              width: 1,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Text(
                          '${_filteredRecipes.length} recipes found',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.textSecondary,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        if (_userIngredients.isNotEmpty) ...[
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _userIngredients.clear();
                                _filterRecipes();
                              });
                            },
                            child: const Text('Clear ingredients', style: TextStyle(fontFamily: 'Poppins')),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: _filteredRecipes.isEmpty
                        ? _buildEmptyState()
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: _filteredRecipes.length,
                            itemBuilder: (context, index) {
                              final recipe = _filteredRecipes[index];
                              return _buildRecipeCard(recipe);
                            },
                          ),
                  ),
                ],
              ),

              Positioned(
                bottom: 16,
                right: 16,
                child: FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AIRecipeScreen(),
                      ),
                    );
                  },
                  backgroundColor: const Color(0xFF5D4037),
                  elevation: 4,
                  icon: const Icon(Icons.auto_awesome, color: Colors.white),
                  label: const Text(
                    'AI Chef',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.restaurant_menu,
            size: 80,
            color: AppTheme.textSecondary.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No recipes found',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppTheme.textSecondary,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _userIngredients.isNotEmpty
                ? 'Try different ingredients or categories'
                : 'Try selecting a different category',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
              fontFamily: 'Poppins',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildRecipeCard(Recipe recipe) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeDetailScreen(recipe: recipe),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [

              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: recipe.title == 'Leftover Rice Breakfast Bowl'
                      ? Image.asset(
                          'assets/images/leftover rice bowl.jpg',
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        )
                      : recipe.title == 'Banana Pancakes'
                          ? Image.asset(
                              'assets/images/banana pancakes.jpg',
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            )
                          : recipe.title == 'Veggie Scramble'
                              ? Image.asset(
                                  'assets/images/veggie scramble.jpg',
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                )
                              : recipe.title == 'Leftover Chicken Fried Rice'
                                  ? Image.asset(
                                      'assets/images/chicken fried rice.webp',
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    )
                                  : recipe.title == 'Quick Vegetable Soup'
                                      ? Image.asset(
                                          'assets/images/quick vege soup.webp',
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover,
                                        )
                                      : recipe.title == 'Pasta with Leftover Meat'
                                          ? Image.asset(
                                              'assets/images/pasta.jpg',
                                              width: 80,
                                              height: 80,
                                              fit: BoxFit.cover,
                                            )
                                          : recipe.title == 'Grain Bowl with Roasted Vegetables'
                                              ? Image.asset(
                                                  'assets/images/grain bowl.webp',
                                                  width: 80,
                                                  height: 80,
                                                  fit: BoxFit.cover,
                                                )
                                              : recipe.title == 'One-Pot Chicken and Rice'
                                                  ? Image.asset(
                                                      'assets/images/one pot.jpeg',
                                                      width: 80,
                                                      height: 80,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : recipe.title == 'Vegetable Stir-fry'
                                                      ? Image.asset(
                                                          'assets/images/vege stir fry.webp',
                                                          width: 80,
                                                          height: 80,
                                                          fit: BoxFit.cover,
                                                        )
                                                      : recipe.title == 'Fish with Lemon Herbs'
                                                          ? Image.asset(
                                                              'assets/images/fish.webp',
                                                              width: 80,
                                                              height: 80,
                                                              fit: BoxFit.cover,
                                                            )
                                                          : recipe.title == 'Fruit and Nut Energy Balls'
                           ? Image.asset(
                               'assets/images/ball.webp',
                               width: 80,
                               height: 80,
                               fit: BoxFit.cover,
                             )
                                                          : recipe.title == 'Vegetable Chips'
                                                              ? Image.asset(
                                                                  'assets/images/vege chips.jpg',
                                                                  width: 80,
                                                                  height: 80,
                                                                  fit: BoxFit.cover,
                                                                )
                                                          : recipe.title == 'Quick Hummus'
                                                                ? Image.asset(
                                                                    'assets/images/hummas.jpg',
                                                                  width: 80,
                                                                  height: 80,
                                                                  fit: BoxFit.cover,
                                                                )
                                                          : recipe.title == 'Banana Nice Cream'
                                                              ? Image.asset(
                                                                  'assets/images/banana cream.jpg',
                                                                  width: 80,
                                                                  height: 80,
                                                                  fit: BoxFit.cover,
                                                                )
                                                          : recipe.title == 'No-Bake Chocolate Oat Cookies'
                                                              ? Image.asset(
                                                                  'assets/images/cookies.jpg',
                                                                  width: 80,
                                                                  height: 80,
                                                                  fit: BoxFit.cover,
                                                                )
                                                              : Image.asset(
                                                                  recipe.imageUrl,
                                                                  width: 80,
                                                                  height: 80,
                                                                  fit: BoxFit.cover,
                                                                  errorBuilder: (context, error, stackTrace) {
                                                                    return Container(
                                                                      width: 80,
                                                                      height: 80,
                                                                      decoration: BoxDecoration(
                                                                        color: AppTheme.primaryGreen.withValues(alpha: 0.1),
                                                                        borderRadius: BorderRadius.circular(8),
                                                                      ),
                                                                      child: const Icon(
                                                                        Icons.restaurant,
                                                                        color: Color(0xFF5D4037),
                                                                        size: 40,
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                ),
              ),
              
              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    
                    Text(
                      recipe.category,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: const Color(0xFF5D4037),
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    
                    const SizedBox(height: 8),
                    
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 16,
                          color: AppTheme.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${recipe.cookTimeMinutes} min',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.textSecondary,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        const SizedBox(width: 16),
                        Icon(
                          _getDifficultyIcon(recipe.difficulty),
                          size: 16,
                          color: _getDifficultyColor(recipe.difficulty),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          recipe.difficulty,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: _getDifficultyColor(recipe.difficulty),
                            fontFamily: 'Poppins',
                          ),
                        ),
                    ],
                  ),
                  
                  if (_userIngredients.isNotEmpty && recipe.matchPercentage > 0) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF5D4037).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '${recipe.matchPercentage}% match',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: const Color(0xFF5D4037),
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              
              const Icon(
                Icons.arrow_forward_ios,
                color: AppTheme.textSecondary,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getDifficultyIcon(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return Icons.star;
      case 'medium':
        return Icons.star_half;
      case 'hard':
        return Icons.star_border;
      default:
        return Icons.star;
    }
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return const Color(0xFF5D4037);
      case 'medium':
        return const Color(0xFFDA650B);
      case 'hard':
        return AppTheme.warningRed;
      default:
        return AppTheme.textSecondary;
    }
  }

  void _addIngredient(String ingredient) {
    if (ingredient.trim().isNotEmpty && !_userIngredients.contains(ingredient.trim())) {
      setState(() {
        _userIngredients.add(ingredient.trim());
        _ingredientController.clear();
        _filterRecipes();
      });
    }
  }

  void _removeIngredient(String ingredient) {
    setState(() {
      _userIngredients.remove(ingredient);
      _filterRecipes();
    });
  }
}