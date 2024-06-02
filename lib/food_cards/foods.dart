class Food {
  final String name;
  final String price;
  final String imagePath;
  final String rating;
  final String description;
  final String averagePrice;

  Food({
    required this.name,
    required this.price,
    required this.rating,
    required this.imagePath,
    required this.description,
    required this.averagePrice,
  });

  String get _name => name;
  String get _price => price;
  String get _rating => rating;
  String get _imagePath => imagePath;
  String get _description => description;
  String get _averagePrice => averagePrice;
}
