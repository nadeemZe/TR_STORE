part of 'cart_cubit.dart';



abstract class CartCubitState{}

class InitialState extends CartCubitState{}

class CartLoading extends CartCubitState{}

class AddToCart extends CartCubitState{}

class RemoveFromCart extends CartCubitState{}

class GetCart extends CartCubitState{
  List<CartModel>cart;
  GetCart({required this.cart});
}

class CartFailure extends CartCubitState{
  String errMessage;
  CartFailure({required this.errMessage});
}
