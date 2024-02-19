import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../util/app_colors.dart';
import '../../util/app_textstyle.dart';



class ProductsWidget extends StatelessWidget{

  final String productName;
  final String image;
  final String price;
  final void Function()? onDetailsPressed;
  final void Function()? onTap;

  const ProductsWidget({required this.productName,
    required this.image,
    required this.price,
    required this.onDetailsPressed ,
    required this.onTap,
    super.key});

  @override
  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.only(top:10.h,right: 20.w,left: 20.w,bottom: 10.h),
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
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(13.h),
                child: SizedBox(
                  height: 100.h,
                  width: 100.h,
                  child: CachedNetworkImage(
                    imageUrl: image,
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 100.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productName,
                        overflow: TextOverflow.ellipsis,
                        style: titleTextStyle,
                      ),
                      Text(
                      '\$$price',
                        style: titleTextStyle,
                      ),
                      TextButton(
                          onPressed: onDetailsPressed,
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(customGrey)
                          ),
                          child: Text(
                            'Details...',
                            style: descriptionTextStyle,
                          ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          InkWell(
                onTap: onTap,
                child: Container(
                  alignment: Alignment.center,
                  height: 40.h,
                  margin: EdgeInsets.symmetric(vertical: 12.h,horizontal: 30.w),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    color: customYellow,),
                  child: Text(
                    'Add To Cart',
                    style: addButtonTextStyle,
                  ),
                ),
              ),
        ],
      ),
    );

  }

}