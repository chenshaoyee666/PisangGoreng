import 'package:flutter/material.dart';
import '../utils/app_theme.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Share Food'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Mode Toggle
            Container(
              decoration: BoxDecoration(
                color: AppTheme.cardBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _isScanMode = true),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: _isScanMode ? AppTheme.primaryGreen : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'AI Scan',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: _isScanMode ? Colors.white : AppTheme.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _isScanMode = false),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: !_isScanMode ? AppTheme.primaryGreen : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Manual Input',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: !_isScanMode ? Colors.white : AppTheme.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            if (_isScanMode) ...[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.cardBackground,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppTheme.primaryGreen, width: 2),
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryGreen,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Start Scanning', style: TextStyle(color: Colors.white)),
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
                  backgroundColor: AppTheme.primaryGreen,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Upload Food Details', style: TextStyle(color: Colors.white)),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCameraPlaceholder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.camera_alt,
          size: 80,
          color: AppTheme.primaryGreen.withValues(alpha: 0.5),
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
          valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryGreen),
        ),
        const SizedBox(height: 24),
        Text(
          'Detecting food type...',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppTheme.primaryGreen,
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
              decoration: const InputDecoration(
                labelText: 'Food Name *',
                hintText: 'e.g., Chicken Breast',
                border: OutlineInputBorder(),
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
              decoration: const InputDecoration(
                labelText: 'Category *',
                border: OutlineInputBorder(),
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
              decoration: const InputDecoration(
                labelText: 'Description (Optional)',
                hintText: 'Additional details about the food',
                border: OutlineInputBorder(),
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
                        return AppTheme.primaryGreen;
                      }
                      return Colors.grey;
                    }),
                    trackColor: WidgetStateProperty.resolveWith<Color>((states) {
                      if (states.contains(WidgetState.selected)) {
                        return AppTheme.primaryGreen.withValues(alpha: 0.5);
                      }
                      return Colors.grey.withValues(alpha: 0.3);
                    }),
                  ),
                  const Spacer(),
                  Text(
                    _isHalal ? 'Yes' : 'No',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: _isHalal ? AppTheme.primaryGreen : AppTheme.warningRed,
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
                    const Icon(Icons.calendar_today, color: AppTheme.primaryGreen),
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
              decoration: const InputDecoration(
                labelText: 'Approximate Value (RM) *',
                hintText: '15.00',
                prefixText: 'RM ',
                border: OutlineInputBorder(),
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
                color: AppTheme.accentOrange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppTheme.accentOrange.withValues(alpha: 0.3)),
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
                  fillColor: WidgetStateProperty.resolveWith<Color>((states) {
                    if (states.contains(WidgetState.selected)) {
                      return AppTheme.primaryGreen;
                    }
                    return Colors.grey;
                  }),
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
        title: const Text('Food Detected!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Detected: Chicken Breast'),
            const Text('Category: Meat'),
            const Text('Expires in: 3 days'),
            const Text('Estimated value: RM 12.00'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.accentOrange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Commission: RM 0.36 (3%)\nNet value: RM 11.64',
                style: TextStyle(fontSize: 12),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Would you like to edit these details?'),
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
            child: const Text('Edit Details'),
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
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryGreen),
            child: const Text('Looks Good', style: TextStyle(color: Colors.white)),
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
      value: double.parse(_valueController.text),
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
              color: AppTheme.successGreen,
              size: 60,
            ),
            const SizedBox(height: 16),
            const Text(
              'Upload Successful!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Tracking Number: $trackingNumber',
              style: const TextStyle(
                fontSize: 16,
                color: AppTheme.primaryGreen,
                fontWeight: FontWeight.w500,
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
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Track Delivery',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}