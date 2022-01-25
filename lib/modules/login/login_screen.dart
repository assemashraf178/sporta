import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sporta/cubit/cubit.dart';
import 'package:sporta/cubit/states.dart';
import 'package:sporta/layouts/home_layout.dart';
import 'package:sporta/shared/components/components.dart';
import 'package:sporta/shared/styles/colors.dart';

enum Gender { male, female }

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  var signInEmailController = TextEditingController();
  var signInPasswordController = TextEditingController();
  var signUpEmailController = TextEditingController();
  var signUpPasswordController = TextEditingController();
  var signUpNameController = TextEditingController();
  var signUpPhoneNumberController = TextEditingController();
  var signUpAgeController = TextEditingController();
  var signUpCityController = TextEditingController();
  var signUpTrainingTypeController = TextEditingController();
  String gender = 'ذكر';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, AppStates state) {
        if (state is RegisterSuccessState) {
          Fluttertoast.showToast(msg: 'تم التسجبل بنجاح');
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => HomeLayout()),
              (route) => false);
        }
        if (state is RegisterErrorState) {
          Fluttertoast.showToast(msg: 'خطأ في التسجبل');
        }
        if (state is LoginSuccessState) {
          Fluttertoast.showToast(msg: 'تم تسجيل الدخول بنجاح');
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => HomeLayout()),
              (route) => false);
        }
        if (state is LoginErrorState) {
          Fluttertoast.showToast(msg: 'خطأ في تسجيل الدخول');
        }
      },
      builder: (BuildContext context, AppStates state) {
        return Scaffold(
          backgroundColor: defaultColor,
          body: Column(
            children: [
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Container(
                  width: double.infinity,
                  height: size.height / 4.5,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.height / 30.0,
                      vertical: size.height / 20.0,
                    ),
                    child: Text(
                      'sporta',
                      style: TextStyle(
                        fontSize: size.height / 10.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(size.width / 10.0),
                      topLeft: Radius.circular(size.width / 10.0),
                    ),
                  ),
                  padding: EdgeInsets.all(size.height / 30.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: size.height / 15.0,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(size.width / 2.0),
                                ),
                                child: MaterialButton(
                                  color: AppCubit.get(context).isSignIn
                                      ? defaultColor
                                      : Colors.grey.shade200,
                                  onPressed: () {
                                    AppCubit.get(context)
                                        .changBetweenSignInAndSignUp(true);
                                  },
                                  child: Text(
                                    'دخول',
                                    style: TextStyle(
                                      color: AppCubit.get(context).isSignIn
                                          ? Colors.white
                                          : defaultColor,
                                      fontSize: size.height / 30.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: size.width / 10.0,
                            ),
                            Expanded(
                              child: Container(
                                height: size.height / 15.0,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(size.width / 2.0),
                                ),
                                child: MaterialButton(
                                  color: AppCubit.get(context).isSignIn
                                      ? Colors.grey.shade200
                                      : defaultColor,
                                  onPressed: () {
                                    AppCubit.get(context)
                                        .changBetweenSignInAndSignUp(false);
                                  },
                                  child: Text(
                                    'تسجيل',
                                    style: TextStyle(
                                      color: AppCubit.get(context).isSignIn
                                          ? defaultColor
                                          : Colors.white,
                                      fontSize: size.height / 30.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height / 50.0,
                        ),
                        //Sign in
                        if (AppCubit.get(context).isSignIn)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'مرحباً',
                                style: TextStyle(
                                  fontSize: size.height / 16.0,
                                  color: defaultColor,
                                ),
                              ),
                              SizedBox(
                                height: size.height / 50.0,
                              ),
                              defaultTextFormField(
                                hint: 'البريد الالكتروني',
                                prefixIcon: Icons.email_outlined,
                                context: context,
                                type: TextInputType.emailAddress,
                                validator: () {},
                                controller: signInEmailController,
                              ),
                              SizedBox(
                                height: size.height / 50.0,
                              ),
                              defaultTextFormField(
                                hint: 'كلمة المرور',
                                prefixIcon: Icons.password,
                                context: context,
                                type: TextInputType.visiblePassword,
                                validator: () {},
                                isPassword: true,
                                controller: signInPasswordController,
                              ),
                              Align(
                                alignment: AlignmentDirectional.centerEnd,
                                child: TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      'هل نسيت كلمة السر؟',
                                      style: TextStyle(
                                          color: defaultColor,
                                          fontSize: size.height / 30.0),
                                    )),
                              ),
                              SizedBox(
                                height: size.height / 50.0,
                              ),
                              if (state is! LoginLoadingState)
                                defaultButton(
                                  size: size,
                                  onPressed: () {
                                    AppCubit.get(context).loginByEmail(
                                      email: signInEmailController.text,
                                      password: signInPasswordController.text,
                                    );
                                  },
                                  text: 'تسجيل الدخول',
                                  fontSize: size.height / 40.0,
                                ),
                              if (state is LoginLoadingState)
                                const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              SizedBox(
                                height: size.height / 50.0,
                              ),
                              SignInButton(
                                Buttons.Google,
                                onPressed: () {},
                                text: 'سجل عن طريق جوجل',
                              ),
                              SizedBox(
                                height: size.height / 50.0,
                              ),
                              SignInButton(
                                Buttons.Facebook,
                                onPressed: () {},
                                text: 'سجل عن طريق فيس بوك',
                              ),
                            ],
                          ),
                        //Sign Up
                        if (!AppCubit.get(context).isSignIn)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Spacer(),
                                  Container(
                                    height: size.height / 18.0,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          size.width / 2.0),
                                    ),
                                    child: MaterialButton(
                                      color: AppCubit.get(context).isTrainee
                                          ? defaultColor
                                          : Colors.grey.shade200,
                                      onPressed: () {
                                        AppCubit.get(context)
                                            .changBetweenTraineeAndTraining(
                                                true);
                                      },
                                      child: Text(
                                        'متدرب',
                                        style: TextStyle(
                                          color: AppCubit.get(context).isTrainee
                                              ? Colors.white
                                              : defaultColor,
                                          fontSize: size.height / 35.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    height: size.height / 18.0,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          size.width / 2.0),
                                    ),
                                    child: MaterialButton(
                                      color: !AppCubit.get(context).isTrainee
                                          ? defaultColor
                                          : Colors.grey.shade200,
                                      onPressed: () {
                                        AppCubit.get(context)
                                            .changBetweenTraineeAndTraining(
                                                false);
                                      },
                                      child: Text(
                                        'مدرب',
                                        style: TextStyle(
                                          color: AppCubit.get(context).isTrainee
                                              ? defaultColor
                                              : Colors.grey.shade200,
                                          fontSize: size.height / 35.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                ],
                              ),
                              SizedBox(
                                height: size.height / 50.0,
                              ),
                              //Trainee
                              if (AppCubit.get(context).isTrainee)
                                Column(
                                  children: [
                                    defaultTextFormField(
                                      hint: 'الاسم',
                                      prefixIcon: Icons.person,
                                      context: context,
                                      type: TextInputType.name,
                                      validator: () {},
                                      controller: signUpNameController,
                                    ),
                                    SizedBox(
                                      height: size.height / 50.0,
                                    ),
                                    defaultTextFormField(
                                      hint: 'البريد الالكتروني',
                                      prefixIcon: Icons.email_outlined,
                                      context: context,
                                      type: TextInputType.emailAddress,
                                      validator: () {},
                                      controller: signUpEmailController,
                                    ),
                                    SizedBox(
                                      height: size.height / 50.0,
                                    ),
                                    defaultTextFormField(
                                      hint: 'رقم الموبايل',
                                      prefixIcon: Icons.phone,
                                      context: context,
                                      type: TextInputType.phone,
                                      validator: () {},
                                      controller: signUpPhoneNumberController,
                                    ),
                                    SizedBox(
                                      height: size.height / 50.0,
                                    ),
                                    defaultTextFormField(
                                      hint: 'المدينة',
                                      prefixIcon: Icons.location_city,
                                      context: context,
                                      type: TextInputType.text,
                                      validator: () {},
                                      controller: signUpCityController,
                                    ),
                                    SizedBox(
                                      height: size.height / 50.0,
                                    ),
                                    defaultTextFormField(
                                      hint: 'السن',
                                      prefixIcon: Icons.person_outline,
                                      context: context,
                                      type: TextInputType.number,
                                      validator: () {},
                                      controller: signUpAgeController,
                                    ),
                                    SizedBox(
                                      height: size.height / 50.0,
                                    ),
                                    defaultTextFormField(
                                      hint: 'كلمة السر',
                                      prefixIcon: Icons.password,
                                      context: context,
                                      type: TextInputType.visiblePassword,
                                      validator: () {},
                                      isPassword: true,
                                      controller: signUpPasswordController,
                                    ),
                                    SizedBox(
                                      height: size.height / 50.0,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'النوع',
                                          style: TextStyle(
                                            color: defaultColor,
                                            fontSize: size.height / 40.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Expanded(
                                          child: CustomRadioButton(
                                            buttonLables: const [
                                              'ذكر',
                                              'انثى',
                                            ],
                                            buttonValues: const [
                                              'ذكر',
                                              'انثى',
                                            ],
                                            radioButtonValue: (value) {
                                              gender = value.toString();
                                              print(gender);
                                            },
                                            elevation: 2.0,
                                            unSelectedColor: Colors.white,
                                            selectedColor: defaultColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: size.height / 50.0,
                                    ),
                                    if (state is RegisterLoadingState)
                                      const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    if (state is! RegisterLoadingState)
                                      defaultButton(
                                        size: size,
                                        onPressed: () {
                                          print(
                                              'Email: ${signUpEmailController.text}');
                                          print(
                                              'Password: ${signUpPasswordController.text}');
                                          AppCubit.get(context).registerByEmail(
                                              email: signUpEmailController.text,
                                              password:
                                                  signUpPasswordController.text,
                                              age: signUpAgeController.text,
                                              city: signUpCityController.text,
                                              phoneNumber:
                                                  signUpPhoneNumberController
                                                      .text,
                                              name: signUpNameController.text,
                                              gender: gender.toString());
                                        },
                                        text: 'تسجيل',
                                      ),
                                  ],
                                ),
                              //Coach
                              if (!AppCubit.get(context).isTrainee)
                                Column(
                                  children: [
                                    defaultTextFormField(
                                      hint: 'الاسم',
                                      prefixIcon: Icons.person,
                                      context: context,
                                      type: TextInputType.name,
                                      validator: () {},
                                      controller: signUpNameController,
                                    ),
                                    SizedBox(
                                      height: size.height / 50.0,
                                    ),
                                    defaultTextFormField(
                                      hint: 'البريد الالكتروني',
                                      prefixIcon: Icons.email_outlined,
                                      context: context,
                                      type: TextInputType.emailAddress,
                                      validator: () {},
                                      controller: signUpEmailController,
                                    ),
                                    SizedBox(
                                      height: size.height / 50.0,
                                    ),
                                    defaultTextFormField(
                                      hint: 'رقم الموبايل',
                                      prefixIcon: Icons.phone,
                                      context: context,
                                      type: TextInputType.phone,
                                      validator: () {},
                                      controller: signUpPhoneNumberController,
                                    ),
                                    SizedBox(
                                      height: size.height / 50.0,
                                    ),
                                    defaultTextFormField(
                                      hint: 'نوع التدريب',
                                      prefixIcon: Icons.sports,
                                      context: context,
                                      type: TextInputType.text,
                                      validator: () {},
                                      controller: signUpTrainingTypeController,
                                    ),
                                    SizedBox(
                                      height: size.height / 50.0,
                                    ),
                                    defaultTextFormField(
                                      hint: 'المدينة',
                                      prefixIcon: Icons.location_city,
                                      context: context,
                                      type: TextInputType.text,
                                      validator: () {},
                                      controller: signUpCityController,
                                    ),
                                    SizedBox(
                                      height: size.height / 50.0,
                                    ),
                                    defaultTextFormField(
                                      hint: 'السن',
                                      prefixIcon: Icons.person_outline,
                                      context: context,
                                      type: TextInputType.number,
                                      validator: () {},
                                      controller: signUpAgeController,
                                    ),
                                    SizedBox(
                                      height: size.height / 50.0,
                                    ),
                                    defaultTextFormField(
                                      hint: 'كلمة السر',
                                      prefixIcon: Icons.password,
                                      context: context,
                                      type: TextInputType.visiblePassword,
                                      validator: () {},
                                      isPassword: true,
                                      controller: signUpPasswordController,
                                    ),
                                    SizedBox(
                                      height: size.height / 50.0,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'النوع',
                                          style: TextStyle(
                                            color: defaultColor,
                                            fontSize: size.height / 40.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Expanded(
                                          child: CustomRadioButton(
                                            buttonLables: const [
                                              'ذكر',
                                              'انثى',
                                            ],
                                            buttonValues: const [
                                              'ذكر',
                                              'انثى',
                                            ],
                                            radioButtonValue: (value) {
                                              gender = value.toString();
                                              print(gender);
                                            },
                                            elevation: 2.0,
                                            unSelectedColor: Colors.white,
                                            selectedColor: defaultColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: size.height / 50.0,
                                    ),
                                    if (state is RegisterLoadingState)
                                      const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    if (state is! RegisterLoadingState)
                                      defaultButton(
                                        size: size,
                                        onPressed: () {
                                          AppCubit.get(context).registerByEmail(
                                              email: signUpEmailController.text,
                                              password:
                                                  signUpPasswordController.text,
                                              age: signUpAgeController.text,
                                              city: signUpCityController.text,
                                              phoneNumber:
                                                  signUpPhoneNumberController
                                                      .text,
                                              name: signUpNameController.text,
                                              gender: gender.toString(),
                                              trainingType:
                                                  signUpTrainingTypeController
                                                      .text);
                                        },
                                        text: 'تسجيل',
                                      ),
                                  ],
                                ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
