import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tr_store/view/cart_view/cart_widget.dart';
import 'package:tr_store/view_model/cart_bloc/cart_cubit.dart';
import 'package:tr_store/widgets/shimmer_effect.dart';
import '../../util/app_textstyle.dart';
import '../../widgets/custom_app_bar.dart';

class CartView extends StatelessWidget{
  const CartView({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(51),
        child: CustomBar(
          title: 'Cart',
          isNotCart: false,
          isNotProducts: true,
        ),
      ),
      body: BlocConsumer<CartCubit,CartCubitState>(
        listener: (context,state){
          if(state is RemoveFromCart){
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Removed successfully ...'),)
            );
          }
        },
        builder: (context,state){
          if(state is CartLoading){
            return ShimmerEffects.loadShimmer(context: context);
          }
          if(state is GetCart){
            return ListView.builder(
                itemCount: state.cart.length,
                itemBuilder: (context,i){
                  return CartWidget(
                      productName: state.cart[i].productName!,
                      amount: state.cart[i].productAmount.toString() ,
                      price: state.cart[i].price.toString(),
                      onTapDelete:(){
                        BlocProvider.of<CartCubit>(context).removeFromCart(state.cart[i].id!);
                        BlocProvider.of<CartCubit>(context).getCart();
                      } ,
                  );
                }
            );
          }
          if(state is CartFailure){
            return Center(child: Text(state.errMessage),);
          }
          return Center(child: Text('No Products in the cart',style: titleTextStyle,),);

        },

      ),
    );

  }
}