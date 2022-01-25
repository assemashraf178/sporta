import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sporta/cubit/cubit.dart';
import 'package:sporta/cubit/states.dart';
import 'package:sporta/shared/styles/icon_broken.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, AppStates state) {},
      builder: (BuildContext context, AppStates state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('الاعدادات'),
            centerTitle: false,
            titleSpacing: 0.0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                IconBroken.Arrow___Right_2,
                size: 30.0,
              ),
            ),
          ),
        );
      },
    );
  }
}
