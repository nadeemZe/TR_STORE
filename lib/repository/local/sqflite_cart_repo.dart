import 'package:sqflite/sqflite.dart';
import '../../model/cart_model.dart';
import '../../services/sqflite_init.dart';


class SqliteCartRepo{

  SQLiteInit sqLiteInit=SQLiteInit.instance;
  static List<CartModel>? cartList;

  Future <List<CartModel>> getCartList()async{
     Database? db= await sqLiteInit.db;
     List<Map<String,Object?>>? cart=await db.query('cart');
     cartList= cart.isNotEmpty
       ? cart.map((e) => CartModel.fromMap(e)).toList()
       : [] ;
     return cartList!;
  }


  Future<int> insertCartModel(CartModel cartModel)async{
    Database? db= await sqLiteInit.db;
    return db.insert('cart', cartModel.toMap());
  }


  Future<int> updateCartModel(CartModel cartModel) async {
    Database db = await sqLiteInit.db;
    return await db.update('cart', cartModel.toMap(),
        where: "id = ?", whereArgs: [cartModel.id]);
  }


  Future<int> deleteCartModel(int id) async {
    Database db = await sqLiteInit.db;
    return await db.delete('cart', where: 'id = ?', whereArgs: [id]);
  }


}