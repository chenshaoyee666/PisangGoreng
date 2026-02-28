import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../utils/app_state.dart';
import '../utils/app_theme.dart';
import 'about_us_background_decoration.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        return Scaffold(
          backgroundColor: const Color(0xFFFFF9EC),
          body: Stack(
            children: [
              const AboutUsBackgroundDecoration(),
              FadeTransition(
                opacity: _fadeAnimation,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 32),
                      _buildHeroSection(appState.selectedLanguage),
                      const SizedBox(height: 32),
                      _buildMissionSection(appState.selectedLanguage),
                      const SizedBox(height: 32),
                      _buildImpactStatistics(appState.selectedLanguage),
                      const SizedBox(height: 32),
                      _buildHowItWorks(appState.selectedLanguage),
                      const SizedBox(height: 32),
                      _buildArticlesSection(),
                      const SizedBox(height: 32),
                      _buildPartnershipsSection(appState.selectedLanguage),
                      const SizedBox(height: 32),
                      _buildDonationPortal(appState.selectedLanguage),
                      const SizedBox(height: 32),
                      _buildContactSection(appState.selectedLanguage),

                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeroSection(String lang) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFFDEFC6), // soft yellow background
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logo.png',
            width: 65,
            height: 65,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.eco, size: 60, color: Color(0xFF4E342E));
            },
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'SmartBite',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    color: Color(0xFF4E342E),
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Reducing Food Waste, Building Community',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    color: Color(0xFF4E342E),
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMissionSection(String lang) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Our Mission',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Color(0xFF4E342E),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppTheme.cardBackground,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SmartBite is a revolutionary platform that connects food sharers with recipients, reducing food waste while supporting our community. Through technology and compassion, we create a sustainable ecosystem where surplus food finds its way to those who need it most.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Icon(
                    Icons.visibility,
                    color: Color(0xFF4E342E),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Vision',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF4E342E),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'A world where no edible food goes to waste and everyone has access to nutritious meals.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildImpactStatistics(String lang) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Our Impact This Month',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Color(0xFF4E342E),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF1A237E).withOpacity(0.08), // dark blue tint
                const Color(0xFF4E342E).withOpacity(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      '2,500+',
                      'Meals Saved',
                      Icons.restaurant,
                      Color(0xFF1A237E), // dark blue
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildStatCard(
                      '150+',
                      'Active Sharers',
                      Icons.people,
                      AppTheme.accentOrange,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      '80+',
                      'Families Helped',
                      Icons.home,
                      AppTheme.accentOrange,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildStatCard(
                      '12 tons',
                      'Waste Prevented',
                      Icons.eco,
                      Color(0xFF1A237E), // dark blue
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String number,
    String label,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(
            number,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppTheme.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildHowItWorks(String lang) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'How SmartBite Works',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Color(0xFF4E342E),
          ),
        ),
        const SizedBox(height: 16),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              '1. Share Your Food: Use our AI-powered scanner or manual input to list surplus food items.',
              style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              '2. We handle the rest! (Add more steps as needed)',
              style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
            ),
          ],
        ),
      ],
    );
  }
  Widget _buildArticlesSection() {
    final articles = [
      {
        'title': '10 Ways to Reduce Food Waste at Home',
        'description':
            'Simple strategies for minimizing food waste in your daily life.',
        'icon': Icons.home,
      },
      {
        'title': 'The Environmental Impact of Food Waste',
        'description':
            'Understanding how food waste affects our planet and climate.',
        'icon': Icons.public,
      },
      {
        'title': 'Community Success Stories',
        'description':
            'Inspiring tales of how SmartBite is making a difference.',
        'icon': Icons.favorite,
      },
      {
        'title': 'Healthy Eating on a Budget',
        'description': 'Tips for maintaining nutrition while saving money.',
        'icon': Icons.monetization_on,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Educational Resources',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Color(0xFF4E342E),
          ),
        ),
        const SizedBox(height: 16),
        ...articles.map(
          (article) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildArticleCard(
              article['title'] as String,
              article['description'] as String,
              article['icon'] as IconData,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildArticleCard(String title, String description, IconData icon) {
    return Card(
      child: InkWell(
        onTap: () {
          _showArticleDialog(title, description);
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFDA650B).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(icon, color: Color(0xFFDA650B), size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
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

  Widget _buildPartnershipsSection(String lang) {
    final partners = [
      {'name': 'GreenGrocer Sdn Bhd', 'type': 'Food Provider'},
      {'name': 'FreshMart Chain', 'type': 'Food Provider'},
      {'name': 'EcoLogistics', 'type': 'Logistics'},
      {'name': 'TechForGood Malaysia', 'type': 'Technology'},
      {'name': 'CommunityFirst Bank', 'type': 'Sponsor'},
      {'name': 'GreenFuture Foundation', 'type': 'Sponsor'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Our Partners',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
            color: Color(0xFF4E342E),
          ),
        ),
        const SizedBox(height: 16),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppTheme.accentOrange.withOpacity(0.08),
                const Color(0xFF4E342E).withOpacity(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  'We collaborate with amazing organizations to maximize our impact',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Wrap(
                spacing: 24,
                runSpacing: 24,
                children: partners.map((partner) {
                  return Container(
                    width: (MediaQuery.of(context).size.width - 120) / 2,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          partner['name']!,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                            color: Color(0xFF4E342E),
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          partner['type']!,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.textSecondary,
                            fontFamily: 'Poppins',
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDonationPortal(String lang) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Support Our Mission',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Color(0xFF4E342E),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppTheme.accentOrange.withValues(alpha: 0.1),
                const Color(0xFF4E342E).withOpacity(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              const Icon(
                Icons.volunteer_activism,
                color: AppTheme.accentOrange,
                size: 48,
              ),
              const SizedBox(height: 16),
              Text(
                'Every RM5 helps save 1 meal',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.accentOrange,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Your donation helps us maintain the platform, support our drivers, and expand to new communities.',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: _buildDonationButton('RM10')),
                  const SizedBox(width: 8),
                  Expanded(child: _buildDonationButton('RM25')),
                  const SizedBox(width: 8),
                  Expanded(child: _buildDonationButton('RM50')),
                  const SizedBox(width: 8),
                  Expanded(child: _buildDonationButton('Custom')),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDonationButton(String amount) {
    return ElevatedButton(
      onPressed: () => _showDonationDialog(amount),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.accentOrange,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      child: Text(
        amount,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildContactSection(String lang) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Partner With Us',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Color(0xFF4E342E),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Text(
                'Interested in partnering with SmartBite? We\'re always looking for organizations that share our vision.',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _showContactForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4E342E),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Contact Us for Partnership',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showArticleDialog(String title, String description) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, style: TextStyle(fontFamily: 'Poppins')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(description, style: TextStyle(fontFamily: 'Poppins')),
            const SizedBox(height: 16),
            Text(
              'This article would contain detailed information about $title. In a full implementation, this would navigate to a dedicated article screen with rich content.',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppTheme.textSecondary),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close', style: TextStyle(fontFamily: 'Poppins')),
          ),
        ],
      ),
    );
  }

  void _showDonationDialog(String amount) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Donation', style: TextStyle(fontFamily: 'Poppins')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.favorite, color: AppTheme.accentOrange, size: 48),
            const SizedBox(height: 16),
            Text('Thank you for wanting to donate $amount!', style: TextStyle(fontFamily: 'Poppins')),
            const SizedBox(height: 12),
            Text(
              'In a full implementation, this would connect to a secure payment gateway.',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppTheme.textSecondary),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(fontFamily: 'Poppins')),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Thank you for your $amount donation!', style: TextStyle(fontFamily: 'Poppins')),
                  backgroundColor: AppTheme.successGreen,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.accentOrange,
            ),
            child: const Text('Donate', style: TextStyle(color: Colors.white, fontFamily: 'Poppins')),
          ),
        ],
      ),
    );
  }

  void _showContactForm() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController messageController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Partnership Inquiry', style: TextStyle(fontFamily: 'Poppins')),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Company Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: messageController,
                decoration: const InputDecoration(
                  labelText: 'Message',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(fontFamily: 'Poppins')),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Partnership inquiry sent successfully!', style: TextStyle(fontFamily: 'Poppins')),
                  backgroundColor: AppTheme.successGreen,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF4E342E),
            ),
            child: const Text('Send', style: TextStyle(color: Colors.white, fontFamily: 'Poppins')),
          ),
        ],
      ),
    );
  }
}
