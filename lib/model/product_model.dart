class ProductModel  {

  final String productName;
  final String description;
  final int price;
  final String image;
  final String thumbnail;
  final int id;
  final String slug;
  final String url;
  final String status;
  final String category;
  final String publishedAt;
  final String updatedAt;




  ProductModel({

    required this.productName,
    required this.description,
    required this.price,
    required this.image,
    required this.thumbnail,
    required this.id,
    required this.category,
    required this.publishedAt,
    required this.slug,
    required this.status,
    required this.updatedAt,
    required this.url,

  });



  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productName : json['title'],
      description : json['content'],
      price : json['userId'],
      image : json['image'],
      thumbnail: json['thumbnail'],
      url: json['url'],
      updatedAt: json['updatedAt'],
      status: json['status'],
      slug: json['slug'],
      publishedAt: json['publishedAt'],
      category: json['category'],
      id: json['id'],
    );
  }

}