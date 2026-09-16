import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/providers/theme_provider.dart';
import 'package:untitled1/providers/user_provider.dart';
import 'package:untitled1/ui/add_event_screen.dart';
import 'package:untitled1/ui/edit_event_screen.dart';
import 'package:untitled1/ui/event_details_screen.dart';
import 'package:untitled1/ui/forget_password_screen.dart';
import 'package:untitled1/ui/home_screen.dart';
import 'package:untitled1/ui/login_screen.dart';
import 'package:untitled1/ui/onBoarding_screen.dart';
import 'package:untitled1/ui/register_screen.dart';
import 'package:untitled1/utils/app_routes.dart';
import 'package:untitled1/utils/app_theme.dart';
import 'firebase_options.dart';
import 'ui/onboarding_light_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await GoogleSignIn.instance.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: EasyLocalization(
        supportedLocales: [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        child:  MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      initialRoute: AppRoutes.onBoardingRouteName,
      routes: {
        AppRoutes.onBoardingRouteName : (context) => OnboardingScreen(),
        AppRoutes.onBoardingLightRouteName : (context) => OnboardingLightScreen(),
        AppRoutes.loginRouteName : (context) => LoginScreen(),
       AppRoutes.registerRouteName : (context) => RegisterScreen(),
       AppRoutes.homeScreenRouteName : (context) => HomeScreen(),
        AppRoutes.forgetPasswordRouteName : (context) => ForgetPasswordScreen(),
        AppRoutes.addEventRouteName : (context) => AddEventScreen(),

      },
    );
  }
}
