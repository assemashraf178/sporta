import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sporta/cubit/cubit.dart';
import 'package:sporta/cubit/states.dart';
import 'package:sporta/layouts/home_layout.dart';
import 'package:sporta/modules/login/login_screen.dart';
import 'package:sporta/shared/BlocObserver.dart';
import 'package:sporta/shared/components/constants.dart';
import 'package:sporta/shared/network/local/cashed_helper.dart';
import 'package:sporta/shared/network/remote/dio_helper.dart';
import 'package:sporta/shared/styles/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CashedHelper.init();
  await Firebase.initializeApp();
  DioHelper.init();
  uId = CashedHelper.getData(key: uIdKey) ?? '';
  Widget startWidget = LoginScreen();
  print(uId);
  if (uId.isNotEmpty) {
    startWidget = HomeLayout();
  } else {
    startWidget = LoginScreen();
  }
  BlocOverrides.runZoned(
    () async {
      runApp(MyApp(
        startWidget: startWidget,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.startWidget}) : super(key: key);
  final Widget startWidget;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return AppCubit()..getUserDetails();
      },
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {},
        builder: (BuildContext context, AppStates state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Sporta',
            theme: ThemeData(
              fontFamily: GoogleFonts.quicksand().fontFamily,
              primarySwatch: defaultColor,
              appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(
                  color: defaultColor,
                ),
                elevation: 0.0,
                color: Colors.white,
                titleTextStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              scaffoldBackgroundColor: Colors.white,
            ),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            locale: const Locale('ar', 'EG'),
            supportedLocales: const [
              Locale('ar', 'EG'),
            ],
            home: startWidget,
          );
        },
      ),
    );
  }
}
