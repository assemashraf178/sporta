import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:sporta/cubit/cubit.dart';
import 'package:sporta/cubit/states.dart';
import 'package:sporta/models/user_model.dart';
import 'package:sporta/modules/chat_details/chat_details_screen.dart';
import 'package:sporta/shared/styles/colors.dart';
import 'package:sporta/shared/styles/icon_broken.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit.get(context).getAllUsers();
    return Scaffold(
      appBar: AppBar(
        title: const Text('الرسائل'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              IconBroken.Arrow___Right_2,
              size: MediaQuery.of(context).size.width / 11.0,
            )),
      ),
      body: Builder(builder: (context) {
        return BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            AppCubit.get(context).getAllUsers();
            return Conditional.single(
              context: context,
              conditionBuilder: (context) =>
                  AppCubit.get(context).allUsers.isNotEmpty,
              widgetBuilder: (context) => ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildChatItem(
                    context, AppCubit.get(context).allUsers[index]),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: AppCubit.get(context).allUsers.length,
              ),
              fallbackBuilder: (context) =>
                  const Center(child: CircularProgressIndicator()),
            );
          },
        );
      }),
    );
  }

  Widget buildChatItem(BuildContext context, UserModel model) => InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ChatDetailsScreen(model: model),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage('assets/images/user_profile.png'),
                radius: 35.0,
                backgroundColor: Colors.white,
              ),
              const SizedBox(
                width: 10.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '${model.name}',
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Icon(
                        IconBroken.Tick_Square,
                        color: defaultColor,
                        size: 15,
                      ),
                    ],
                  ),
                  if (model.trainingType != null)
                    Text(
                      'مدرب: ${model.trainingType.toString()}',
                      style: TextStyle(color: defaultColor),
                    ),
                ],
              ),
            ],
          ),
        ),
      );
}
