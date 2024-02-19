import 'dart:convert';
import 'package:tr_store/model/product_model.dart';
import '../repository/api/product_api.dart';



class ProductsViewModel{

  final ProductAPI _productAPI=ProductAPI();
  List<ProductModel>productsList=[];


  Future<List<ProductModel>> getProducts()async{

    await _productAPI.fetchProducts().then((response){

      if(response!=null){
        var body=jsonDecode(response.body);
        for(int i=0;i<body.length;i++){
          ProductModel productModel=ProductModel.fromJson(body[i]);
          productsList.add(productModel);
        }
        return productsList;
      }

    });
    return productsList;
  }


}