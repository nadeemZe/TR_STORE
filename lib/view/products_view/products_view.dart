import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tr_store/model/cart_model.dart';
import 'package:tr_store/util/app_textstyle.dart';
import 'package:tr_store/util/stream_check_interet.dart';
import 'package:tr_store/view/product_detail/product_detail.dart';
import 'package:tr_store/view/products_view/products_widget.dart';
import 'package:tr_store/widgets/custom_app_bar.dart';
import 'package:tr_store/widgets/shimmer_effect.dart';
import '../../view_model/cart_bloc/cart_cubit.dart';
import '../../view_model/products_view_model.dart';

class ProductsView extends StatefulWidget{
  const ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {

  final ProductsViewModel _productsViewModel=ProductsViewModel();
  final CheckInternet _checkInternet=CheckInternet();

  late StreamSubscription<bool> subscription;
  bool _isConnected = true; // Assuming connected by default

  @override
  void initState() {
    super.initState();
    _checkInternet.checkConnection(); // Check connectivity when the widget initializes
    // Listen to network changes
    subscription = _checkInternet.networkStatusStream().listen((bool isConnected) {

      //update ui when isConnected
      setState(() {
        _isConnected = isConnected;
      });
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(51),
        child: CustomBar(
          title: 'Products',
          isNotCart: true,
          isNotProducts: false,
        ),
      ),
      body: FutureBuilder(
          future: _productsViewModel.getProducts(),
          builder: (context,AsyncSnapshot snapshot){
            if(snapshot.connectionState==ConnectionState.waiting || !(_isConnected)){
              return ShimmerEffects.loadShimmer(context: context);
            }
            if(snapshot.data!=null){
              return BlocConsumer<CartCubit,CartCubitState>(
                  listener: (context,state){
                    if(state is CartFailure){
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Some thing went wrong ...!'),)
                      );
                    }
                    if(state is AddToCart){
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Added successfully ...'),)
                      );
                    }
                  },
                builder: (context,state) {
                  return ListView.builder(
                      itemBuilder: (context,i){
                        return ProductsWidget(
                            productName: snapshot.data[i].productName,
                            image: snapshot.data[i].image,
                            price: snapshot.data[i].price.toString(),
                           onDetailsPressed: (){
                             Navigator.push(context, MaterialPageRoute(
                                 builder: (context) => ProductDetail(productModel: snapshot.data[i])));
                           },
                           onTap: (){
                             BlocProvider.of<CartCubit>(context).addToCart(
                                 CartModel(
                                   id:snapshot.data[i].id,
                                   productName: snapshot.data[i].productName,
                                   productAmount: 1,
                                   price: snapshot.data[i].price
                                 )
                             );
                             BlocProvider.of<CartCubit>(context).getCart();
                           },
                        );
                      }
                  );
                }
              );
            }
            else {
              return  Center(child: Text('Something went wrong!...',style: descriptionTextStyle,));
            }
          }
      ),
    );
  }
}