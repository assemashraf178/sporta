import 'package:flutter/material.dart';
import 'package:simple_star_rating/simple_star_rating.dart';
import 'package:sporta/cubit/cubit.dart';
import 'package:sporta/shared/components/components.dart';
import 'package:sporta/shared/styles/colors.dart';
import 'package:sporta/shared/styles/icon_broken.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen(
      {Key? key,
      required this.name,
      required this.starCount,
      required this.sportType})
      : super(key: key);
  final String name;
  final double starCount;
  final String sportType;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Image(
                  image: const AssetImage('assets/images/user_profile.png'),
                  width: MediaQuery.of(context).size.width / 4.0,
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
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
                const Spacer(),
                defaultButton(
                  size: MediaQuery.of(context).size,
                  onPressed: () {
                    AppCubit.get(context).subscribeChange();
                  },
                  text: AppCubit.get(context).isSubscribe
                      ? 'إلغاء اشتراك'
                      : 'اشتراك',
                  width: AppCubit.get(context).isSubscribe
                      ? MediaQuery.of(context).size.width / 3.5
                      : MediaQuery.of(context).size.width / 5,
                  height: MediaQuery.of(context).size.height / 25.0,
                  fontSize: MediaQuery.of(context).size.height / 50.0,
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            if (AppCubit.get(context).isSubscribe)
              const SizedBox(
                height: 20.0,
              ),
            if (AppCubit.get(context).isSubscribe)
              ListView(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                clipBehavior: Clip.antiAlias,
                children: [
                  subscribeItem(
                    context: context,
                    price: 200,
                    days: 8,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  subscribeItem(
                    context: context,
                    price: 300,
                    days: 12,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  subscribeItem(
                    context: context,
                    price: 400,
                    days: 16,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            Image(
              image: sportType == 'football'
                  ? const AssetImage('assets/images/football.png')
                  : sportType == 'swimming'
                      ? const AssetImage('assets/images/swimming.png')
                      : sportType == 'gym'
                          ? const AssetImage('assets/images/gym.png')
                          : const AssetImage('assets/images/boxing.png'),
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }

  Widget subscribeItem({
    required BuildContext context,
    required int price,
    required int days,
  }) =>
      Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 5.0,
        ),
        decoration: BoxDecoration(
            color: defaultColor.shade100,
            borderRadius: BorderRadius.circular(20.0)),
        child: Row(
          children: [
            Text(
              '$price  ج.م',
              style: TextStyle(
                color: defaultColor,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Text(
              '$days/أيام',
              style: TextStyle(
                color: defaultColor,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
}
