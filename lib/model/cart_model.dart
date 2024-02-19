class CartModel {
  final int? id;
  final String? productName;
  int? productAmount;
  final int? price;


  CartModel({
    this.id,
    this.productName,
    this.productAmount,
    this.price,
  });


  factory CartModel.fromMap(Map<String, dynamic> json){
    return CartModel(

      id: json['id'],
      productName: json['productName'],
      productAmount: json['productAmount'],
      price: json['price'],

    );

  }


  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'productName': productName,
      'productAmount': productAmount,
      'price':price,

    };

  }


}