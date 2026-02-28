import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../utils/app_theme.dart';
import '../widgets/background_bubbles.dart';

class RecipeDetailScreen extends StatefulWidget {
  final Recipe recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  bool _isSaved = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9EC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF9EC),
        title: Text(widget.recipe.title, style: const TextStyle(fontFamily: 'Poppins')),
        actions: [
          IconButton(
            onPressed: _toggleSaved,
            icon: Icon(
              _isSaved ? Icons.favorite : Icons.favorite_border,
              color: _isSaved ? Colors.red : AppTheme.textSecondary,
            ),
          ),
          IconButton(
            onPressed: _shareRecipe,
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: Stack(
        children: [

          BackgroundBubbles(
            bubbles: [
              BubbleData(top: 50, left: 30, size: 100, color: Color(0xFFFFF6E5)),
              BubbleData(bottom: 100, right: 20, size: 80, color: Color(0xFFBCA17A)),
              BubbleData(top: 200, right: -30, size: 90, color: Color(0xFFFFEE8C)),
              BubbleData(bottom: 300, left: -20, size: 70, color: Color(0xFFF8F4FF)),
              BubbleData(top: 400, left: 40, size: 60, color: Color(0xFFFFEE8C)),
              BubbleData(bottom: 150, left: 10, size: 50, color: Color(0xFFBCA17A)),
              BubbleData(top: 600, right: 30, size: 75, color: Color(0xFFF8F4FF)),
              BubbleData(bottom: 50, right: -25, size: 65, color: Color(0xFFFFF6E5)),
            ],
          ),
          SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 250,
              width: double.infinity,
              child: Stack(
                children: [
                  widget.recipe.title == 'Leftover Rice Breakfast Bowl'
                      ? Image.asset(
                          'assets/images/leftover rice bowl.jpg',
                          height: 250,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : widget.recipe.title == 'Banana Pancakes'
                          ? Image.asset(
                              'assets/images/banana pancakes.jpg',
                              height: 250,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            )
                          : widget.recipe.title == 'Veggie Scramble'
                              ? Image.asset(
                                  'assets/images/veggie scramble.jpg',
                                  height: 250,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                )
                              : widget.recipe.title == 'Leftover Chicken Fried Rice'
                                  ? Image.asset(
                                      'assets/images/chicken fried rice.webp',
                                      height: 250,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    )
                                  : widget.recipe.title == 'Quick Vegetable Soup'
                                      ? Image.asset(
                                          'assets/images/quick vege soup.webp',
                                          height: 250,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        )
                                      : widget.recipe.title == 'Pasta with Leftover Meat'
                                          ? Image.asset(
                                              'assets/images/pasta.jpg',
                                              height: 250,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            )
                                          : widget.recipe.title == 'Grain Bowl with Roasted Vegetables'
                                              ? Image.asset(
                                                  'assets/images/grain bowl.webp',
                                                  height: 250,
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                )
                                              : widget.recipe.title == 'One-Pot Chicken and Rice'
                                                  ? Image.asset(
                                                      'assets/images/one pot.jpeg',
                                                      height: 250,
                                                      width: double.infinity,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : widget.recipe.title == 'Vegetable Stir-fry'
                                                      ? Image.asset(
                                                          'assets/images/vege stir fry.webp',
                                                          height: 250,
                                                          width: double.infinity,
                                                          fit: BoxFit.cover,
                                                        )
                                                      : widget.recipe.title == 'Fish with Lemon Herbs'
                                                          ? Image.asset(
                                                              'assets/images/fish.webp',
                                                              height: 250,
                                                              width: double.infinity,
                                                              fit: BoxFit.cover,
                                                            )
                                                      : widget.recipe.title == 'Fruit and Nut Energy Balls'
                                                          ? Image.asset(
                                                              'assets/images/ball.webp',
                                                              height: 250,
                                                              width: double.infinity,
                                                              fit: BoxFit.cover,
                                                            )
                                                      : widget.recipe.title == 'Vegetable Chips'
                                                          ? Image.asset(
                                                              'assets/images/vege chips.jpg',
                                                              height: 250,
                                                              width: double.infinity,
                                                              fit: BoxFit.cover,
                                                            )
                                                      : widget.recipe.title == 'Quick Hummus'
                                                          ? Image.asset(
                                                              'assets/images/hummas.jpg',
                                                              height: 250,
                                                              width: double.infinity,
                                                              fit: BoxFit.cover,
                                                            )
                                                      : widget.recipe.title == 'Banana Nice Cream'
                                                          ? Image.asset(
                                                              'assets/images/banana cream.jpg',
                                                              height: 250,
                                                              width: double.infinity,
                                                              fit: BoxFit.cover,
                                                            )
                                                      : widget.recipe.title == 'No-Bake Chocolate Oat Cookies'
                                                          ? Image.asset(
                                                              'assets/images/cookies.jpg',
                                                              height: 250,
                                                              width: double.infinity,
                                                              fit: BoxFit.cover,
                                                            )
                                                          : Image.asset(
                                                              widget.recipe.imageUrl,
                                                              height: 250,
                                                              width: double.infinity,
                                                              fit: BoxFit.cover,
                                                              errorBuilder: (context, error, stackTrace) {
                                                                return Container(
                                                                  height: 250,
                                                                  width: double.infinity,
                                                                  color: AppTheme.cardBackground,
                                                                  child: const Center(
                                                                    child: Icon(
                                                                      Icons.restaurant,
                                                                      color: Color(0xFF5D4037),
                                                                      size: 80,
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.3),
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.recipe.matchPercentage > 0)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF5D4037),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${widget.recipe.matchPercentage}% Match',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Add ingredient',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF4E342E), width: 1.5),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF4E342E), width: 2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color(0xFF4E342E),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                  Row(
                    children: [
                      _buildInfoChip(
                        Icons.access_time,
                        '${widget.recipe.cookTimeMinutes} min',
                      ),
                      const SizedBox(width: 12),
                      _buildInfoChip(
                        Icons.signal_cellular_alt,
                        widget.recipe.difficulty,
                      ),
                      const SizedBox(width: 12),
                      _buildInfoChip(
                        Icons.category,
                        widget.recipe.category,
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  Text(
                    'Ingredients',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...widget.recipe.ingredients.map((ingredient) => 
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          Icon(
                            Icons.fiber_manual_record,
                            size: 8,
                            color: const Color(0xFF5D4037),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              ingredient,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontFamily: 'Poppins'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  Text(
                    'Instructions',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...widget.recipe.instructions.asMap().entries.map((entry) {
                    final index = entry.key;
                    final instruction = entry.value;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: const Color(0xFF5D4037),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Center(
                              child: Text(
                                '${index + 1}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              instruction,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontFamily: 'Poppins'),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),

                  const SizedBox(height: 24),

                  if (widget.recipe.tags.isNotEmpty) ...[
                    Text(
                      'Tags',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: widget.recipe.tags.map((tag) => 
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF5D4037).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(0xFF5D4037).withValues(alpha: 0.3),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            tag,
                            style: const TextStyle(
                              color: Color(0xFF5D4037),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ).toList(),
                    ),
                  ],

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF5D4037).withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: const Color(0xFF5D4037),
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }

  void _toggleSaved() {
    setState(() {
      _isSaved = !_isSaved;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isSaved ? 'Recipe saved!' : 'Recipe removed from favorites', style: const TextStyle(fontFamily: 'Poppins')),
        duration: const Duration(seconds: 2),
        backgroundColor: const Color(0xFF5D4037),
      ),
    );
  }

  void _shareRecipe() {

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Recipe shared successfully!', style: TextStyle(fontFamily: 'Poppins')),
        duration: Duration(seconds: 2),
      ),
    );
  }
}