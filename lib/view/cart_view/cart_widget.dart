import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../util/app_colors.dart';
import '../../util/app_textstyle.dart';


class CartWidget extends StatelessWidget {
  final String productName;
  final String price;
  final String amount;
  final void Function()? onTapDelete;

  const CartWidget(
      {Key? key,
        required this.productName,
        required this.price,
        required this.amount,
        required this.onTapDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      margin: EdgeInsets.only(top:10.h,right: 20.w,left: 20.w,bottom: 10.h),
      color: customGrey,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      //color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width:51.w,
                        child: Text(
                          productName,
                          style:titleTextStyle,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      InkWell(
                        onTap: onTapDelete,
                        child: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Amount',
                        style: titleTextStyle,
                      ),
                      Text(
                        amount,
                        style: descriptionTextStyle,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Unit Price',
                        style: titleTextStyle,
                      ),
                      Text(
                          '\$ $price',
                          maxLines: 1,
                          style: descriptionTextStyle
                      )
                    ],
                  ),
                  const Divider(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
