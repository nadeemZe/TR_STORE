import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tr_store/model/product_model.dart';

import '../../model/cart_model.dart';
import '../../util/app_colors.dart';
import '../../util/app_textstyle.dart';
import '../../view_model/cart_bloc/cart_cubit.dart';
import '../../widgets/custom_app_bar.dart';

class ProductDetail extends StatelessWidget{
  final ProductModel productModel;
  const ProductDetail({required this.productModel,super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(51),
        child: CustomBar(
          title: 'Product Detail',
          isNotCart: true,
          isNotProducts: true,
        ),
      ),
      body: Container(
          margin: EdgeInsets.only(top:10.h,right: 20.w,left: 20.w,bottom: 10.h),
          padding: EdgeInsets.all(12.h),
          decoration: BoxDecoration(
              color: customBlack,
              borderRadius: BorderRadius.all(Radius.circular(20.h)),
              boxShadow: [
                BoxShadow(
                  color: Colors.white24,
                  blurRadius: 40.h,
                )
              ]
          ),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CachedNetworkImage(
                imageUrl: productModel.image,
              ),
              SizedBox(height: 17.h,),
              Text(productModel.productName,style: titleTextStyle,),
              SizedBox(height: 25.h,),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                      productModel.description,
                      overflow: TextOverflow.fade,
                      style: descriptionTextStyle,
                    ),
                ),
              ),
              SizedBox(height: 17.h,),
              Text('\$ ${productModel.price.toString()}',style: titleTextStyle,),
              SizedBox(height: 17.h,),
              BlocConsumer<CartCubit,CartCubitState>(
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
                  return InkWell(
                    onTap: (){
                      BlocProvider.of<CartCubit>(context).addToCart(
                          CartModel(
                              id:productModel.id,
                              productName: productModel.productName,
                              productAmount: 1,
                              price: productModel.price
                          )
                      );
                      },
                    child: Container(
                      alignment: Alignment.center,
                      height: 40.h,
                      margin: const EdgeInsets.all(13),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        color: customYellow,),
                      child: Text(
                        'Add To Cart',
                        style: addButtonTextStyle,
                      ),
                    ),
                  );
                }
              ),
            ],
          )
      ),
    );
  }
}