class ProductData {
  final String name;
  final String detail;
  final String image;
  final int price;
  final String brand;

  ProductData(
      {required this.name,
      required this.detail,
      required this.price,
      required this.brand,
      required this.image});

  factory ProductData.fromJson(Map<String, dynamic> Json) {
    return ProductData(
        name: Json['title'],
        detail: Json['description'],
        price: Json['price'],
        brand: Json['brand'],
        image: Json['thumbnail']);
  }
}
