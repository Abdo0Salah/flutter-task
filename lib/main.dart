import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_route/product/product_scerrn.dart';
import 'package:task_route/repositories/user_repository.dart';
import 'package:task_route/theme/my_theme.dart';
import 'cache/cache_helper.dart';
import 'core/api/dio_consumer.dart';
import 'cubit/user_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper().init();
  runApp(
    BlocProvider(
      create: (context) => UserCubit(
        UserRepository(api: DioConsumer(dio: Dio())),
      ),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(400, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          theme: MyTheme.lightTheme,
          // themeMode: ,
          debugShowCheckedModeBanner: false,
          initialRoute: ProductScreen.routeName,
          routes: {
            ProductScreen.routeName: (context) => ProductScreen(),
          },
        );
      },
    );
  }
}
