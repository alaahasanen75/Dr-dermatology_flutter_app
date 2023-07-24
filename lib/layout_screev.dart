import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skin_detection/cubit/skin_cubit.dart';

class MyWidget extends StatelessWidget {
  MyWidget({super.key});
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var cubit = SkinCubit().get(context);

    return BlocConsumer<SkinCubit, SkinState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(cubit.tittle[cubit.currentIndex]),
              actions: [
                IconButton(
                  onPressed: () {
                    SkinCubit().get(context).changeAppMode();
                  },
                  icon: Icon(Icons.brightness_4_outlined),
                )
              ],
            ),
            bottomNavigationBar: CurvedNavigationBar(
              key: _bottomNavigationKey,
              index: cubit.currentIndex,
              height: 50.0,
              items: const [
                Icon(
                  Icons.home,
                  size: 30,
                  color: Colors.white,
                ),
                Icon(
                  Icons.camera_enhance_outlined,
                  size: 30,
                  color: Colors.white,
                ),
                Icon(
                  Icons.article_outlined,
                  size: 25,
                  color: Colors.white,
                ),
              ],
              animationCurve: Curves.easeInOutCirc,
              color: SkinCubit().get(context).colorBackGround()!,
              backgroundColor: Colors.white,
              animationDuration: const Duration(milliseconds: 300),
              onTap: (index) {
                cubit.ChangeBottomNav(index);

                print(cubit.currentIndex);
              },
              letIndexChange: (index) => true,
            ),
            body: cubit.bottomScreen[SkinCubit().get(context).currentIndex],
          );
        });
  }
}
