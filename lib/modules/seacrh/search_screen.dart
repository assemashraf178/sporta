import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_star_rating/simple_star_rating.dart';
import 'package:sporta/cubit/cubit.dart';
import 'package:sporta/cubit/states.dart';
import 'package:sporta/modules/user_profile/user_profile_screen.dart';
import 'package:sporta/shared/components/components.dart';
import 'package:sporta/shared/styles/colors.dart';
import 'package:sporta/shared/styles/icon_broken.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  var searchController = TextEditingController();
  String trainingType = 'football';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, AppStates state) {},
      builder: (BuildContext context, AppStates state) {
        return Padding(
          padding: EdgeInsets.all(
            MediaQuery.of(context).size.height / 40.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                defaultTextFormField(
                  hint: 'كلمة البحث',
                  context: context,
                  type: TextInputType.text,
                  validator: (value) {},
                  onSubmit: (s) {
                    AppCubit.get(context).submitSearch();
                  },
                  controller: searchController,
                  prefixIcon: IconBroken.Search,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20.0,
                ),
                if (searchController.text == '')
                  Column(
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                Image(
                                  image: const AssetImage(
                                      'assets/images/tennis.png'),
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                ),
                                Text(
                                  'Tennis',
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white.withOpacity(0.8)),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                Image(
                                  image: const AssetImage(
                                    'assets/images/football.png',
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                ),
                                Text(
                                  'Football',
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white.withOpacity(0.8)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 50.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                Image(
                                  image: const AssetImage(
                                      'assets/images/boxing.png'),
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                ),
                                Text(
                                  'Boxing',
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white.withOpacity(0.8)),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                Image(
                                  image:
                                      const AssetImage('assets/images/gym.png'),
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                ),
                                Text(
                                  'Gym',
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white.withOpacity(0.8)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 50.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                Image(
                                  image: const AssetImage(
                                      'assets/images/swimming.png'),
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                ),
                                Text(
                                  'Swimming',
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white.withOpacity(0.8)),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                Image(
                                  image: const AssetImage(
                                      'assets/images/handball.png'),
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                ),
                                Text(
                                  'Handball',
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white.withOpacity(0.8)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 50.0,
                      ),
                    ],
                  ),
                if (searchController.text != '')
                  ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      if (searchController.text.contains('كرة قدم'))
                        buildSearchItem(
                          context: context,
                          starCount: 4,
                          name: 'محمد',
                          trainingType: 'football',
                        ),
                      if (searchController.text.contains('كرة قدم'))
                        const Divider(
                          height: 35.0,
                          thickness: 1.0,
                        ),
                      if (searchController.text.contains('كرة قدم'))
                        buildSearchItem(
                          context: context,
                          starCount: 5,
                          name: 'أحمد',
                          trainingType: 'football',
                        ),
                      if (searchController.text.contains('كرة قدم'))
                        const Divider(
                          height: 35.0,
                          thickness: 1.0,
                        ),
                      if (searchController.text.contains('كرة قدم'))
                        buildSearchItem(
                          context: context,
                          starCount: 3,
                          name: 'محمود',
                          trainingType: 'football',
                        ),
                      if (searchController.text.contains('سباحة'))
                        buildSearchItem(
                          context: context,
                          starCount: 1,
                          name: 'مصطفى',
                          trainingType: 'swimming',
                        ),
                      if (searchController.text.contains('سباحة'))
                        const Divider(
                          height: 35.0,
                          thickness: 1.0,
                        ),
                      if (searchController.text.contains('سباحة'))
                        buildSearchItem(
                          context: context,
                          starCount: 2,
                          name: 'علي',
                          trainingType: 'swimming',
                        ),
                      if (searchController.text.contains('جيم'))
                        buildSearchItem(
                          context: context,
                          starCount: 4,
                          name: 'محمد',
                          trainingType: 'gym',
                        ),
                      if (searchController.text.contains('جيم'))
                        const Divider(
                          height: 35.0,
                          thickness: 1.0,
                        ),
                      if (searchController.text.contains('جيم'))
                        buildSearchItem(
                          context: context,
                          starCount: 5,
                          name: 'أحمد',
                          trainingType: 'gym',
                        ),
                      if (searchController.text.contains('جيم'))
                        const Divider(
                          height: 35.0,
                          thickness: 1.0,
                        ),
                      if (searchController.text.contains('جيم'))
                        buildSearchItem(
                          context: context,
                          starCount: 3,
                          name: 'محمود',
                          trainingType: 'gym',
                        ),
                      if (searchController.text.contains('بوكس'))
                        buildSearchItem(
                          context: context,
                          starCount: 1,
                          name: 'مصطفى',
                          trainingType: 'boxing',
                        ),
                      if (searchController.text.contains('بوكس'))
                        const Divider(
                          height: 35.0,
                          thickness: 1.0,
                        ),
                      if (searchController.text.contains('بوكس'))
                        buildSearchItem(
                          context: context,
                          starCount: 2,
                          name: 'علي',
                          trainingType: 'boxing',
                        ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildSearchItem({
    required BuildContext context,
    required double starCount,
    required String name,
    required String trainingType,
  }) =>
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(MediaQuery.of(context).size.height / 50.0),
        decoration: BoxDecoration(
          color: defaultColor.shade50,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          children: [
            Image(
              image: const AssetImage('assets/images/user_profile.png'),
              width: MediaQuery.of(context).size.width / 5.0,
            ),
            const SizedBox(
              width: 10.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  trainingType,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal,
                    color: defaultColor,
                  ),
                ),
                SimpleStarRating(
                  rating: starCount,
                  starCount: 5,
                  isReadOnly: true,
                  filledIcon: Icon(
                    Icons.star,
                    color: defaultColor.shade900,
                    size: 20.0,
                  ),
                  nonFilledIcon: Icon(
                    Icons.star_border_outlined,
                    color: defaultColor,
                    size: 20,
                  ),
                ),
              ],
            ),
            Spacer(),
            defaultButton(
              size: MediaQuery.of(context).size,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => UserProfileScreen(
                              name: name,
                              starCount: starCount,
                              sportType: trainingType,
                            )));
              },
              text: 'عرض',
              width: MediaQuery.of(context).size.width / 5,
              height: MediaQuery.of(context).size.height / 25.0,
              fontSize: MediaQuery.of(context).size.height / 50.0,
            ),
          ],
        ),
      );
}
