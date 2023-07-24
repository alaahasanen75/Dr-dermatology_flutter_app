import 'package:flutter/material.dart';
import 'package:skin_detection/splash_screen.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:skin_detection/cubit/skin_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skin_detection/utilites/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  final bool? isDark;
  MyApp(this.isDark);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SkinCubit()
          ..changeAppMode(
            fromShared: isDark,
          )
          ..getData(),
        child: BlocConsumer<SkinCubit, SkinState>(
            listener: (context, state) {},
            builder: (context, state) {
              return ScreenUtilInit(
                  designSize: const Size(360, 690),
                  minTextAdapt: true,
                  splitScreenMode: true,
                  builder: (context, child) {
                    return MaterialApp(
                      debugShowCheckedModeBanner: false,
                      themeMode: SkinCubit().get(context).isDark
                          ? ThemeMode.dark
                          : ThemeMode.light,
                      darkTheme: ThemeData(
                        scaffoldBackgroundColor: HexColor('333739'),
                        primarySwatch: Colors.blueGrey,
                        bottomNavigationBarTheme: BottomNavigationBarThemeData(
                          selectedItemColor: AppColors.primaryColor,
                          unselectedItemColor: Colors.grey,
                          type: BottomNavigationBarType.fixed,
                          backgroundColor: HexColor('333739'),
                        ),
                        appBarTheme: AppBarTheme(
                          titleSpacing: 20,
                          iconTheme: const IconThemeData(color: Colors.white),
                          backgroundColor: HexColor('333739'),
                          titleTextStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                          elevation: 0,
                        ),
                        textTheme: const TextTheme(
                            bodyLarge: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                      theme: ThemeData(
                        scaffoldBackgroundColor: Colors.white,
                        bottomNavigationBarTheme:
                            const BottomNavigationBarThemeData(
                          selectedItemColor: AppColors.primaryColor,
                          unselectedItemColor: Colors.grey,
                          type: BottomNavigationBarType.fixed,
                          backgroundColor: Colors.white,
                        ),
                        appBarTheme: const AppBarTheme(
                          backgroundColor: AppColors.primaryColor,
                          titleSpacing: 20,
                          iconTheme: IconThemeData(color: Colors.black),
                          titleTextStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                          elevation: 0,
                        ),
                        textTheme: const TextTheme(
                            bodyLarge: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ),
                      home: SplashScreen(),
                    );
                  });
            }));
  }
}
