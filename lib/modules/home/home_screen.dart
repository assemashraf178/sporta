import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:sporta/cubit/cubit.dart';
import 'package:sporta/cubit/states.dart';
import 'package:sporta/models/post_model.dart';
import 'package:sporta/modules/post/post_screen.dart';
import 'package:sporta/shared/styles/colors.dart';
import 'package:sporta/shared/styles/icon_broken.dart';

class HomeScreen extends StatelessWidget {
  var commentController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const PostScreen()));
        },
        backgroundColor: defaultColor,
        child: const Icon(IconBroken.Paper_Upload),
      ),
      body: Builder(
        builder: (BuildContext context) {
          AppCubit.get(context).getPosts();
          return BlocConsumer<AppCubit, AppStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Card(
                        margin: const EdgeInsets.all(8),
                        child: CarouselSlider(
                          items: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    const Image(
                                      image: AssetImage(
                                          'assets/images/tennis.png'),
                                    ),
                                    Text(
                                      'Tennis',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 45.0,
                                          color: Colors.white.withOpacity(0.8)),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 18,
                                ),
                                Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    const Image(
                                      image: AssetImage(
                                          'assets/images/football.png'),
                                    ),
                                    Text(
                                      'Football',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 45.0,
                                          color: Colors.white.withOpacity(0.8)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    const Image(
                                      image: AssetImage(
                                          'assets/images/boxing.png'),
                                    ),
                                    Text(
                                      'Boxing',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 45.0,
                                          color: Colors.white.withOpacity(0.8)),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 18,
                                ),
                                Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    const Image(
                                      image:
                                          AssetImage('assets/images/gym.png'),
                                    ),
                                    Text(
                                      'Gym',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 45.0,
                                          color: Colors.white.withOpacity(0.8)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    const Image(
                                      image: AssetImage(
                                          'assets/images/swimming.png'),
                                    ),
                                    Text(
                                      'Swimming',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 45.0,
                                          color: Colors.white.withOpacity(0.8)),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 18,
                                ),
                                Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    const Image(
                                      image: AssetImage(
                                          'assets/images/handball.png'),
                                    ),
                                    Text(
                                      'Handball',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 45.0,
                                          color: Colors.white.withOpacity(0.8)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                          options: CarouselOptions(
                            height: MediaQuery.of(context).size.height / 2,
                            autoPlay: true,
                            reverse: true,
                            initialPage: 0,
                            autoPlayAnimationDuration:
                                const Duration(seconds: 1),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Conditional.single(
                        context: context,
                        conditionBuilder: (context) =>
                            AppCubit.get(context).posts.isNotEmpty &&
                            AppCubit.get(context).likes.isNotEmpty,
                        widgetBuilder: (context) {
                          return ListView.separated(
                            reverse: true,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => buildPostItem(
                                context,
                                AppCubit.get(context).posts[index],
                                index),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 8.0,
                            ),
                            itemCount: AppCubit.get(context).posts.length,
                          );
                        },
                        fallbackBuilder: (context) =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget buildPostItem(BuildContext context, PostModel model, int index) =>
      Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${model.name}',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(),
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
                      Text(
                        '${model.dateTime}',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              color: Colors.grey,
                              height: 1,
                            ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      IconBroken.More_Circle,
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.grey[360],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '${model.text}',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      height: 1.4,
                    ),
              ),
              if (model.postImage != "")
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Image(
                    image: NetworkImage(
                      '${model.postImage}',
                    ),
                  ),
                ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      print('Love');
                    },
                    child: Row(
                      children: [
                        const Icon(
                          IconBroken.Heart,
                          size: 16.0,
                          color: Colors.red,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${AppCubit.get(context).likes[index]}',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                color: Colors.grey,
                              ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      print('Comment');
                    },
                    child: Row(
                      children: [
                        const Icon(
                          IconBroken.Chat,
                          size: 16.0,
                          color: Colors.amber,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '0 تعليق',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                color: Colors.grey,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(
                color: Colors.grey,
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          const CircleAvatar(
                            backgroundImage: AssetImage(
                              'assets/images/user_profile.png',
                            ),
                            backgroundColor: Colors.white,
                            radius: 17.0,
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            'اكتب تعليق....',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      AppCubit.get(context)
                          .likePost(AppCubit.get(context).postsId[index]);
                    },
                    child: Row(
                      children: [
                        const Icon(
                          IconBroken.Heart,
                          size: 16,
                          color: Colors.red,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'إعجاب',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        const Icon(
                          IconBroken.Arrow___Up,
                          size: 16,
                          color: Colors.green,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'مشاركة',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        elevation: 5.0,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
      );
}
