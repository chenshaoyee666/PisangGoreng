import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final bool isSharer;

  const CustomBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.isSharer,
  });

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> items = isSharer
        ? _getSharerItems()
        : _getRecipientItems();

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppTheme.primaryGreen,
      unselectedItemColor: AppTheme.textSecondary,
      backgroundColor: Colors.white,
      elevation: 8,
      items: items,
    );
  }

  List<BottomNavigationBarItem> _getSharerItems() {
    return const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.camera_alt),
        label: 'Upload',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.menu_book),
        label: 'Recipes',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.info_outline),
        label: 'About',
      ),
    ];
  }

  List<BottomNavigationBarItem> _getRecipientItems() {
    return const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.qr_code_scanner),
        label: 'Scan QR',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.map),
        label: 'Map',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.info_outline),
        label: 'About',
      ),
    ];
  }
}