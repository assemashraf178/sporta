import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sporta/cubit/cubit.dart';
import 'package:sporta/cubit/states.dart';
import 'package:sporta/shared/components/components.dart';
import 'package:sporta/shared/styles/colors.dart';
import 'package:sporta/shared/styles/icon_broken.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var cityController = TextEditingController();
  var trainingTypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = AppCubit.get(context).userModel!.name.toString();
    emailController.text = AppCubit.get(context).userModel!.email.toString();
    cityController.text = AppCubit.get(context).userModel!.city.toString();
    phoneController.text =
        AppCubit.get(context).userModel!.phoneNumber.toString();
    trainingTypeController.text =
        AppCubit.get(context).userModel!.trainingType.toString();
    AppCubit.get(context).getUserDetails();
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, AppStates state) {
        if (state is UpdateUserDataSuccessState) {
          Fluttertoast.showToast(msg: 'تم تعديل البيانات بنجاح');
        }
        if (state is UpdateUserDataErrorState) {
          Fluttertoast.showToast(msg: 'خطأ في تعديل البيانات');
        }
      },
      builder: (BuildContext context, AppStates state) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(size.height / 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage(
                    'assets/images/user_profile.png',
                  ),
                ),
                SizedBox(
                  height: size.height / 20.0,
                ),
                defaultTextFormField(
                  hint: 'الاسم',
                  context: context,
                  type: TextInputType.text,
                  validator: (value) {},
                  controller: nameController,
                  prefixIcon: IconBroken.Profile,
                  enabledBorder: defaultColor.shade200,
                  readOnly: AppCubit.get(context).profileUpdate,
                ),
                SizedBox(
                  height: size.height / 45.0,
                ),
                defaultTextFormField(
                  hint: 'البريد الالكتروني',
                  context: context,
                  type: TextInputType.emailAddress,
                  validator: (value) {},
                  controller: emailController,
                  prefixIcon: IconBroken.Message,
                  enabledBorder: defaultColor.shade200,
                  readOnly: AppCubit.get(context).profileUpdate,
                ),
                SizedBox(
                  height: size.height / 45.0,
                ),
                defaultTextFormField(
                  hint: 'المدينة',
                  context: context,
                  type: TextInputType.text,
                  validator: (value) {},
                  controller: cityController,
                  prefixIcon: IconBroken.Discovery,
                  enabledBorder: defaultColor.shade200,
                  readOnly: AppCubit.get(context).profileUpdate,
                ),
                SizedBox(
                  height: size.height / 45.0,
                ),
                defaultTextFormField(
                  hint: 'رقم المحمول',
                  context: context,
                  type: TextInputType.phone,
                  validator: (value) {},
                  controller: phoneController,
                  prefixIcon: IconBroken.Call,
                  enabledBorder: defaultColor.shade200,
                  readOnly: AppCubit.get(context).profileUpdate,
                ),
                SizedBox(
                  height: size.height / 45.0,
                ),
                if (AppCubit.get(context).userModel!.trainingType != null)
                  defaultTextFormField(
                    hint: 'نوع التدريب',
                    context: context,
                    type: TextInputType.text,
                    validator: (value) {},
                    controller: trainingTypeController,
                    prefixIcon: IconBroken.Call,
                    enabledBorder: defaultColor.shade200,
                    readOnly: AppCubit.get(context).profileUpdate,
                  ),
                SizedBox(
                  height: size.height / 25.0,
                ),
                if (state is UpdateUserDataLoadingState)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                if (state is! UpdateUserDataLoadingState)
                  TextButton(
                    onPressed: () {
                      AppCubit.get(context).updateProfileState();
                      if (AppCubit.get(context).profileUpdate) {
                        AppCubit.get(context).updateUserData(
                            name: nameController.text,
                            email: emailController.text,
                            phoneNumber: phoneController.text,
                            city: cityController.text);
                      }
                    },
                    child: Text(
                      !AppCubit.get(context).profileUpdate
                          ? 'تحديث'
                          : 'تعديل الملف الشخصي',
                      style: TextStyle(fontSize: size.height / 28.0),
                    ),
                  ),
                TextButton(
                  onPressed: () {
                    AppCubit.get(context).logout(context: context);
                  },
                  child: Text(
                    'تسجيل الخروج',
                    style: TextStyle(fontSize: size.height / 30.0),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
