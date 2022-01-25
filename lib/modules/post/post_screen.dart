import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sporta/cubit/cubit.dart';
import 'package:sporta/cubit/states.dart';
import 'package:sporta/shared/styles/colors.dart';
import 'package:sporta/shared/styles/icon_broken.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var postController = TextEditingController();
    return BlocConsumer<AppCubit, AppStates>(listener: (context, state) {
      if (state is CreatePostSuccessState) {
        Navigator.pop(context);
      }
    }, builder: (context, state) {
      var userModel = AppCubit.get(context).userModel;
      var postImage = AppCubit.get(context).postImage;
      return Scaffold(
        appBar: AppBar(
          title: const Text('اضافة منشور'),
          actions: [
            TextButton(
              onPressed: () {
                var now = DateTime.now();
                if (AppCubit.get(context).postImage == null) {
                  AppCubit.get(context).createPost(
                    dateTime: now.toString(),
                    text: postController.text,
                  );
                } else {
                  AppCubit.get(context).uploadPostImage(
                    dateTime: now.toString(),
                    text: postController.text,
                  );
                }
              },
              child: const Text('نشر'),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(
            20.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (state is CreatePostLoadingState)
                  const LinearProgressIndicator(),
                if (state is CreatePostLoadingState)
                  const SizedBox(
                    height: 10.0,
                  ),
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/images/user_profile.png'),
                      radius: 25.0,
                      backgroundColor: Colors.white,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      '${userModel!.name}',
                      style: Theme.of(context).textTheme.headline5!.copyWith(),
                    ),
                  ],
                ),
                TextFormField(
                  controller: postController,
                  minLines: 1,
                  maxLines: 20,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: 'ما الذي يدور بداخل عقلك ${userModel.name}؟...',
                    border: InputBorder.none,
                    hintStyle: Theme.of(context).textTheme.caption!.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                if (postImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(postImage),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 16,
                          child: IconButton(
                            icon: const Icon(
                              IconBroken.Close_Square,
                              size: 16,
                            ),
                            onPressed: () {
                              AppCubit.get(context).removePostImage();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          AppCubit.get(context).getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              IconBroken.Image,
                              color: defaultColor,
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            const Text('اضافة صورة'),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: const Text('#Tags'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
