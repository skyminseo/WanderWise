class Attractions {
  String name;
  String price;
  String imagePath;
  String rating;
  String description;
  String averagePrice;

  Attractions({
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
}
