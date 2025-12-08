import 'package:flutter/material.dart';
import '../utils/app_theme.dart';
import '../models/recipe.dart';
import 'recipe_detail_screen.dart';

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
    return Scaffold(
      body: Column(
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
                      'Recipe Discovery',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        _showIngredientSearch ? Icons.list : Icons.search,
                        color: AppTheme.primaryGreen,
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
                    'What ingredients do you have?',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textSecondary,
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
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
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
                          backgroundColor: AppTheme.primaryGreen,
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
                          label: Text(ingredient),
                          onDeleted: () => _removeIngredient(ingredient),
                          deleteIcon: const Icon(Icons.close, size: 16),
                          backgroundColor: AppTheme.primaryGreen.withValues(alpha: 0.1),
                          deleteIconColor: AppTheme.primaryGreen,
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 8),
                  ],
                ] else ...[
                  Text(
                    'Find delicious recipes using your ingredients',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
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
                    selectedColor: AppTheme.primaryGreen.withValues(alpha: 0.2),
                    checkmarkColor: AppTheme.primaryGreen,
                    labelStyle: TextStyle(
                      color: isSelected ? AppTheme.primaryGreen : AppTheme.textSecondary,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
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
                    child: const Text('Clear ingredients'),
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
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _userIngredients.isNotEmpty
                ? 'Try different ingredients or categories'
                : 'Try selecting a different category',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
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
              // Recipe image
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
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
                          color: AppTheme.primaryGreen,
                          size: 40,
                        ),
                      );
                    },
                  ),
                ),
              ),
              
              const SizedBox(width: 16),
              
              // Recipe details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    
                    Text(
                      recipe.category,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.primaryGreen,
                        fontWeight: FontWeight.w500,
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
                          color: AppTheme.successGreen.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '${recipe.matchPercentage}% match',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.successGreen,
                            fontWeight: FontWeight.w600,
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
        return AppTheme.successGreen;
      case 'medium':
        return AppTheme.accentOrange;
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