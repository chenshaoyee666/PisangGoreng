class FoodItem {
  final String name;
  final String category;
  final bool isHalal;
  final DateTime expiryDate;
  final double value;
  final String? description;

  FoodItem({
    required this.name,
    required this.category,
    required this.isHalal,
    required this.expiryDate,
    required this.value,
    this.description,
  });

  double get commissionFee => value * 0.03;
  double get netValue => value - commissionFee;
}