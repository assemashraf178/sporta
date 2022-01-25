import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:sporta/cubit/cubit.dart';
import 'package:sporta/cubit/states.dart';
import 'package:sporta/modules/messages/messages_screen.dart';
import 'package:sporta/shared/styles/icon_broken.dart';

class HomeLayout extends StatelessWidget {
  HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, AppStates state) {},
      builder: (BuildContext context, AppStates state) {
        AppCubit.get(context).getAllUsers();
        return Scaffold(
          appBar: AppBar(
            title: Text(
              AppCubit.get(context).titles[AppCubit.get(context).currentIndex],
            ),
            actions: [
              if (AppCubit.get(context).currentIndex == 0)
                IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => MessagesScreen()));
                  },
                  icon: const Icon(
                    IconBroken.Message,
                    size: 30.0,
                  ),
                ),
              // if (AppCubit.get(context).currentIndex == 3)
              //   IconButton(
              //     onPressed: () {
              //       Navigator.push(context,
              //           MaterialPageRoute(builder: (_) => SettingsScreen()));
              //     },
              //     icon: const Icon(
              //       IconBroken.Setting,
              //       size: 30.0,
              //     ),
              //   ),
              /*if (AppCubit.get(context).currentIndex == 3)
                IconButton(
                  onPressed: () {
                    AppCubit.get(context).updateProfileState();
                  },
                  icon: Icon(
                    AppCubit.get(context).profileUpdate
                        ? IconBroken.Edit_Square
                        : IconBroken.Tick_Square,
                    size: 30.0,
                  ),
                ),*/
            ],
          ),
          body:
              AppCubit.get(context).screens[AppCubit.get(context).currentIndex],
          bottomNavigationBar: SalomonBottomBar(
            items: AppCubit.get(context).items,
            currentIndex: AppCubit.get(context).currentIndex,
            onTap: (index) {
              AppCubit.get(context).changeBottomNavIndex(index);
            },
          ),
        );
      },
    );
  }
}
