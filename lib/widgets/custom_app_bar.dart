import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tr_store/util/app_colors.dart';
import 'package:tr_store/view/cart_view/cart_view.dart';
import '../util/app_textstyle.dart';
import '../view_model/cart_bloc/cart_cubit.dart';

class CustomBar extends StatelessWidget {
  final String title;
  final bool isNotCart;
  final bool isNotProducts;
  const CustomBar({required this.title, required this.isNotCart,required this.isNotProducts, super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: customGrey,
        leading: (isNotProducts) ? IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: customYellow,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      )
            : null,
      title: Text(
        title,
        style: titleTextStyle,
      ),
      actions: [
        if (isNotCart)
          InkWell(
            onTap: () {
              BlocProvider.of<CartCubit>(context).getCart();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CartView()));
            },
            child: Container(
              margin: const EdgeInsets.only(right: 12, bottom: 5),
              padding: const EdgeInsets.all(12.0),
              decoration: const BoxDecoration(
                  color: customBlack, shape: BoxShape.circle),
              child: const Icon(
                Icons.shopping_cart,
                color: customYellow,
              ),
            ),
          ),
      ],
    );
  }
}
