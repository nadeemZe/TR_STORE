import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/cart_model.dart';
import '../../repository/local/sqflite_cart_repo.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartCubitState>{
  CartCubit():super(InitialState());

  final SqliteCartRepo _sqliteCartRepo=SqliteCartRepo();


  Future<void>addToCart(CartModel cartModel)async{
    try{
      emit(CartLoading());

      //get cart list
      // check if product in we increase the amount and update
      List<CartModel>cart = await _sqliteCartRepo.getCartList();

        if(cart.isNotEmpty) {

          for(int i=0;i<cart.length;i++){

            if(cartModel.productName==cart[i].productName){
              cartModel.productAmount=cartModel.productAmount!+cart[i].productAmount!;
              await _sqliteCartRepo.updateCartModel(cartModel);
              emit(AddToCart());
              return;
            }
          }
          // After finishing if product not found we insert
          await _sqliteCartRepo.insertCartModel(cartModel);
          emit(AddToCart());
        }
        // if cart is empty we insert
        else{
          await _sqliteCartRepo.insertCartModel(cartModel);
          emit(AddToCart());
        }

    }on Exception catch(e){
      emit(CartFailure(errMessage: e.toString()));
    }
  }


  Future<void>removeFromCart(int id)async{
    try{
      emit(CartLoading());
      await _sqliteCartRepo.deleteCartModel(id);
      emit(RemoveFromCart());
    }on Exception catch(e){
      emit(CartFailure(errMessage: e.toString()));
    }
  }


  Future<void>getCart()async{
    try{
      emit(CartLoading());
      await _sqliteCartRepo.getCartList().then((cart) {
        if(cart.isNotEmpty) emit(GetCart(cart: cart));
      });
    }on Exception catch(e){
      emit(CartFailure(errMessage: e.toString()));
    }
  }



}