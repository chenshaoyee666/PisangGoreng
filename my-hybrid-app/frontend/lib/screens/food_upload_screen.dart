import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/app_state.dart';
import '../utils/app_theme.dart';
import '../utils/translations.dart';
import '../models/food_item.dart';
import 'delivery_tracking_screen.dart';

class FoodUploadScreen extends StatefulWidget {
  const FoodUploadScreen({super.key});

  @override
  State<FoodUploadScreen> createState() => _FoodUploadScreenState();
}

class _FoodUploadScreenState extends State<FoodUploadScreen> {
  bool _isScanning = false;
  bool _isScanMode = true;
  
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _valueController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  String _selectedCategory = 'Meat';
  bool _isHalal = true;
  DateTime? _selectedDate;
  bool _acceptTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _valueController.dispose();
    _descriptionController.dispose();
    super.dispose();
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

              SizedBox(
                width: double.infinity,
                height: 180,
                child: CustomPaint(
                  painter: _TopBubblesPainter(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 8),

                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 16),
                      child: Text(
                        Translations.get('share_food', lang),
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                          color: Color(0xFF4E342E), // dark brown
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => setState(() => _isScanMode = true),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    color: _isScanMode ? Color(0xFF4E342E) : Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    Translations.get('ai_scan', lang),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      color: _isScanMode ? Colors.white : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => setState(() => _isScanMode = false),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    color: !_isScanMode ? Color(0xFF4E342E) : Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    Translations.get('manual_input', lang),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      color: !_isScanMode ? Colors.white : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    if (_isScanMode) ...[
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppTheme.cardBackground,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppTheme.accentOrange, width: 2),
                          ),
                          child: _isScanning
                              ? _buildScanningAnimation()
                              : _buildCameraPlaceholder(),
                        ),
                      ),
                    ] else ...[
                      Expanded(child: _buildManualInputForm()),
                    ],
                    const SizedBox(height: 24),
                    if (_isScanMode && !_isScanning)
                      ElevatedButton(
                        onPressed: _startScanning,
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                            if (states.contains(WidgetState.pressed)) {
                              return Color(0xFFDA650B); // dark orange
                            }
                            return Color(0xFF4E342E); // dark brown
                          }),
                          padding: WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: 16)),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                        child: const Text(
                          'Start Scanning',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      )
                    else if (_isScanMode && _isScanning)
                      ElevatedButton(
                        onPressed: _stopScanning,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.warningRed,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text('Stop Scanning', style: TextStyle(color: Colors.white)),
                      )
                    else
                      ElevatedButton(
                        onPressed: _submitFoodDetails,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF4E342E), // Dark brown
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text(
                          'Upload Food Details',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );

  }

  Widget _buildCameraPlaceholder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.camera_alt,
          size: 80,
          color: AppTheme.accentOrange.withOpacity(0.5),
        ),
        const SizedBox(height: 16),
        Text(
          'Point camera at your food',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'AI will automatically detect food type and details',
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildScanningAnimation() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppTheme.accentOrange),
        ),
        const SizedBox(height: 24),
        Text(
          'Detecting food type...',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppTheme.accentOrange,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Please hold steady',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildManualInputForm() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Food Name *',
                hintText: 'e.g., Chicken Breast',
                border: const OutlineInputBorder(),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFBDBDBD), width: 1.5), // default grey
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF4E342E), width: 2), // brown
                ),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Food name is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              initialValue: _selectedCategory,
              decoration: InputDecoration(
                labelText: 'Category *',
                border: const OutlineInputBorder(),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFBDBDBD), width: 1.5), // default grey
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF4E342E), width: 2), // brown
                ),
              ),
              items: ['Meat', 'Vegetables', 'Fruits', 'Dairy', 'Grains', 'Prepared Food']
                  .map((category) => DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value!;
                });
              },
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description (Optional)',
                hintText: 'Additional details about the food',
                border: const OutlineInputBorder(),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFBDBDBD), width: 1.5), // default grey
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF4E342E), width: 2), // brown
                ),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Text(
                    'Halal:',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(width: 16),
                  Switch(
                    value: _isHalal,
                    onChanged: (value) {
                      setState(() {
                        _isHalal = value;
                      });
                    },
                    thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
                      if (states.contains(WidgetState.selected)) {
                        return const Color(0xFF4E342E); // Dark brown
                      }
                      return Colors.grey;
                    }),
                    trackColor: WidgetStateProperty.resolveWith<Color>((states) {
                      if (states.contains(WidgetState.selected)) {
                        return const Color(0xFF4E342E).withOpacity(0.5);
                      }
                      return Colors.grey.withOpacity(0.3);
                    }),
                  ),
                  const Spacer(),
                  Text(
                    _isHalal ? 'Yes' : 'No',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: _isHalal ? const Color(0xFF4E342E) : AppTheme.warningRed,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            GestureDetector(
              onTap: _selectDate,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today, color: Color(0xFF4E342E)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Expiry Date *',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                          ),
                          Text(
                            _selectedDate != null
                                ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                                : 'Select expiry date',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: _selectedDate != null ? AppTheme.textPrimary : AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
            if (_selectedDate == null) ...[
              const SizedBox(height: 8),
              const Text(
                'Expiry date is required',
                style: TextStyle(color: AppTheme.warningRed, fontSize: 12),
              ),
            ],
            const SizedBox(height: 16),

            TextFormField(
              controller: _valueController,
              decoration: InputDecoration(
                labelText: 'Approximate Value (RM) *',
                hintText: '15.00',
                prefixText: 'RM ',
                border: const OutlineInputBorder(),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFBDBDBD), width: 1.5), // default grey
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF4E342E), width: 2), // brown
                ),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Value is required';
                }
                final double? amount = double.tryParse(value);
                if (amount == null || amount <= 0) {
                  return 'Please enter a valid amount';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.accentOrange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppTheme.accentOrange.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.info, color: AppTheme.accentOrange, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'Commission Fee Notice',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppTheme.accentOrange,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'SmartBite charges a 3% commission to maintain our platform and support community operations.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  if (_valueController.text.isNotEmpty) ...[
                    Text(
                      'Example: For RM ${_valueController.text} food value = RM ${(_calculateCommission()).toStringAsFixed(2)} fee',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppTheme.accentOrange,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 16),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  value: _acceptTerms,
                  onChanged: (value) {
                    setState(() {
                      _acceptTerms = value ?? false;
                    });
                  },
                  fillColor: WidgetStateProperty.all(_acceptTerms ? AppTheme.accentOrange : Colors.grey),
                  checkColor: Colors.white,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _acceptTerms = !_acceptTerms;
                      });
                    },
                    child: Text(
                      'I accept the commission fee and terms of service for food sharing on SmartBite platform.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  double _calculateCommission() {
    final double value = double.tryParse(_valueController.text) ?? 0.0;
    return value * 0.03;
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      helpText: 'Select Expiry Date',
      cancelText: 'Cancel',
      confirmText: 'Select',
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: const Color(0xFF4E342E), // dark brown for selected day
              onPrimary: Colors.white, // text/icon on selected day
              secondary: const Color(0xFF4E342E), // action button color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF4E342E), // action button text
                textStyle: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600, // SemiBold
                  fontSize: 16,
                ),
              ),
            ),
            textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'Poppins',
              bodyColor: Theme.of(context).textTheme.bodyMedium?.color,
              displayColor: Theme.of(context).textTheme.bodyMedium?.color,
            ),
            dialogTheme: DialogThemeData(
              titleTextStyle: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 24,
                color: Colors.black,
              ),
              contentTextStyle: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.normal,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _startScanning() {
    setState(() {
      _isScanning = true;
    });

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _isScanning = false;
        });
        _showDetectionResult();
      }
    });
  }

  void _stopScanning() {
    setState(() {
      _isScanning = false;
    });
  }

  void _showDetectionResult() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Food Detected!',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Color(0xFF4E342E), // dark brown
            fontSize: 26,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Detected: Chicken Breast', style: TextStyle(fontFamily: 'Poppins')),
            const Text('Category: Meat', style: TextStyle(fontFamily: 'Poppins')),
            const Text('Expires in: 3 days', style: TextStyle(fontFamily: 'Poppins')),
            const Text('Estimated value: RM 12.00', style: TextStyle(fontFamily: 'Poppins')),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.accentOrange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Commission: RM 0.36 (3%)\nNet value: RM 11.64',
                style: TextStyle(fontSize: 12, fontFamily: 'Poppins'),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Would you like to edit these details?', style: TextStyle(fontFamily: 'Poppins')),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _isScanMode = false;
                _nameController.text = 'Chicken Breast';
                _selectedCategory = 'Meat';
                _valueController.text = '12.00';
                _selectedDate = DateTime.now().add(const Duration(days: 3));
              });
            },
            child: const Text(
              'Edit Details',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Color(0xFF1A237E), // dark blue
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSuccessAndTracking(
                FoodItem(
                  name: 'Chicken Breast',
                  category: 'Meat',
                  isHalal: true,
                  expiryDate: DateTime.now().add(const Duration(days: 3)),
                  value: 12.00,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF4E342E), // brown
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text(
              'Looks Good',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submitFoodDetails() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an expiry date'),
          backgroundColor: AppTheme.warningRed,
        ),
      );
      return;
    }

    if (!_acceptTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please accept the terms and commission fee'),
          backgroundColor: AppTheme.warningRed,
        ),
      );
      return;
    }

    final foodItem = FoodItem(
      name: _nameController.text.trim(),
      category: _selectedCategory,
      isHalal: _isHalal,
      expiryDate: _selectedDate!,
      value: double.tryParse(_valueController.text) ?? 0.0,
      description: _descriptionController.text.trim().isNotEmpty
          ? _descriptionController.text.trim()
          : null,
    );
    _showSuccessAndTracking(foodItem);
  }

  void _showSuccessAndTracking(FoodItem foodItem) {
    final String trackingNumber = 'SB${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}';
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle,
              color: AppTheme.accentOrange, // dark orange
              size: 60,
            ),
            const SizedBox(height: 16),
            const Text(
              'Upload Successful!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Tracking Number: $trackingNumber',
              style: const TextStyle(
                fontSize: 16,
                color: AppTheme.accentOrange, // dark orange
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Food: ${foodItem.name}',
              style: const TextStyle(
                fontSize: 14,
                color: AppTheme.textSecondary,
                fontFamily: 'Poppins',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'Your food donation has been submitted and a driver will be assigned shortly.',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Poppins',
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DeliveryTrackingScreen(
                        trackingNumber: trackingNumber,
                        foodName: foodItem.name,
                        foodItem: foodItem,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4E342E), // dark brown
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                  child: const Text(
                    'Track Delivery',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
  
  class _TopBubblesPainter extends CustomPainter {
    @override
    void paint(Canvas canvas, Size size) {

      final bubblePaint = Paint()..color = const Color(0xFFFFCC80).withOpacity(0.7);

      canvas.drawCircle(Offset(size.width * 0.15, size.height * 0.3), 24, bubblePaint);
      canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.2), 18, bubblePaint);
      canvas.drawCircle(Offset(size.width * 0.6, size.height * 0.5), 14, bubblePaint);

    }
  
    @override
    bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
  }