import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tr_store/util/app_colors.dart';
import 'package:tr_store/view/products_view/products_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tr_store/view_model/cart_bloc/cart_cubit.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>CartCubit(),
      child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
        builder: (context,child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter TR Store',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              scaffoldBackgroundColor: customGrey,
              useMaterial3: true,
            ),
            home:  ProductsView(),
          );
        }
      ),
    );
  }
}
