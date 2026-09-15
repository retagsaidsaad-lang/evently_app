import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/utiles/app_assets.dart';
import 'package:untitled1/utiles/app_routes.dart';
import 'package:untitled1/utiles/app_styles.dart';
import 'package:untitled1/utiles/firebase_utils.dart';
import 'package:untitled1/utiles/size_utiles.dart';
import 'package:untitled1/widgets/custom_elevated_button.dart';
import 'package:untitled1/widgets/custom_text_field.dart';

import '../model/my_user.dart';
import '../providers/theme_provider.dart';
import '../providers/user_provider.dart';
import '../utiles/app_colors.dart';
import '../utiles/snack_bar_utiles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey <FormState> ();
  TextEditingController emailController = TextEditingController(text: 'retag@gmail.com') ;
  TextEditingController passwordController = TextEditingController(text: '123456') ;
  @override
  Widget build(BuildContext context) {
    var themProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.width*0.04),
              child: Form(
                key: formKey,
                child: Column(
                  spacing: context.height*0.02,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(themProvider.isDarkMode ? AppAssets.eventlyLogoDarkImage :
                    AppAssets.eventlyLogoImage),
                    Text('auth_login_title'.tr(),
                   style:Theme.of(context).textTheme.headlineSmall ,
                    ),
                    CustomTextField(
                      hintText: 'auth_enter_email'.tr(),
                      hintStyle: Theme.of(context).textTheme.bodyLarge,
                      borderColor: Theme.of(context).dividerColor,
                      fill: true,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (text) {
                        if(text == null || text.trim().isEmpty){
                          return 'Please enter Email.' ;
                        }
                        final bool emailValid =
                        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(emailController.text);
          
                        if(!emailValid){
                          return 'Please enter valid Email.' ;
                        }
                        return null ;
                      },
                      filledColor: themProvider.isDarkMode ? AppColors.darkInputColor : AppColors.whiteColor,
                      prefixIcon: Icon(Icons.mail_outline , color: AppColors.lightGreyColor,),
                    ),
                    CustomTextField(
                      hintText: 'auth_enter_password'.tr(),
                      hintStyle: Theme.of(context).textTheme.bodyLarge,
                      borderColor: Theme.of(context).dividerColor,
                      fill: true,
                      keyboardType: TextInputType.phone,
                      obscureText: true,
                      controller: passwordController,
                      validator: (text) {
                        if(text == null || text.trim().isEmpty){
                          return 'Please enter Password.';
                        }
                        if(text.length< 6){
                          return 'Password must be at least 6 chars.';
                        }
                        return null ;
                      },
                      filledColor: themProvider.isDarkMode ? AppColors.darkInputColor : AppColors.whiteColor,
                      prefixIcon: Icon(Icons.lock_outlined, color: AppColors.lightGreyColor,),
                      suffixIcon: Icon(Icons.visibility_off_outlined ,color: AppColors.lightGreyColor),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(onPressed: () {
                       Navigator.of(context).pushNamed(AppRoutes.forgetPasswordRouteName);
                        },
                            child: Text('auth_forget_password_link'.tr(),
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: Theme.of(context).cardColor,
                              decorationThickness: 2
                            ),)),
                      ],
                    ),
                    CustomElevatedButton(
                      verticalPadding: context.height*0.015,
                      backGroundColor: Theme.of(context).cardColor, onPressed: login,
                        child: Text('auth_login_btn'.tr(),
                        style: AppStyles.medium20WhiteDarkColor,)
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('auth_dont_have_account'.tr() ,
                        style:  Theme.of(context).textTheme.bodyLarge,),
                        TextButton(onPressed: () {
                          Navigator.of(context).pushNamed(AppRoutes.registerRouteName);
          
                        },
                            child: Text('auth_sign_up'.tr(),
                              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                  decoration: TextDecoration.underline,
                                  decorationColor: Theme.of(context).cardColor,
                                  decorationThickness: 2
                              ),)),
          
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Theme.of(context).dividerColor,
                            thickness: 2,
                            indent: context.width*0.05,
                            endIndent: context.width*0.05,
                          ),
                        ),
                        Text('auth_or'.tr(),
                        style: Theme.of(context).textTheme.labelMedium,),
                        Expanded(
                          child: Divider(color: Theme.of(context).dividerColor,
                            thickness: 2,
                            indent: context.width*0.05,
                            endIndent: context.width*0.05,
                          ),
                        ),
                      ],
                    ),
                    CustomElevatedButton(
                        verticalPadding: context.height*0.02,
                        sideBorderColor: Theme.of(context).dividerColor,
                        backGroundColor: themProvider.isDarkMode ? AppColors.darkInputColor : AppColors.whiteColor,
                        onPressed: () async {
                          try {
                            UserCredential? userCredential = await FirebaseUtils.signInWithGoogle();
                            if (userCredential != null && userCredential.user != null) {
                              MyUser myUser = MyUser(
                                uId: userCredential.user?.uid ?? '',
                                name: userCredential.user?.displayName ?? 'User',
                                email: userCredential.user?.email ?? '',
                              );
                              await FirebaseUtils.addUserInFireStore(myUser);
                              var userProvider = Provider.of<UserProvider>(context, listen: false);
                              userProvider.upDateUser(myUser);
                              if (context.mounted) {
                                Navigator.pushReplacementNamed(context, AppRoutes.homeScreenRouteName);
                              }
                            }
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Google Sign-In Failed: $e')),
                              );
                            }
                          }
                        },
                        child: Row(
                          spacing: context.width*0.04,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(AppAssets.googleLogoImage),
                            Text('auth_login_with_google'.tr(),
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ],
                        ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ),
    );
  }

  void login () async {
    if(formKey.currentState?.validate() == true) {
      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text
        );
        var myUser = await FirebaseUtils.readUserFromFireStore(credential.user?.uid??'');
        if(myUser == null) {
          return ;
        }
        var userProvider = Provider.of<UserProvider>(context , listen: false);
        userProvider.upDateUser(myUser);
        SnackBarUtils.showSnackBar(
          context: context,
          message: 'login_success'.tr(),
        );
        await Future.delayed(const Duration(seconds: 2));
        Navigator.pushReplacementNamed(
          context,
          AppRoutes.homeScreenRouteName,
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          SnackBarUtils.showErrorSnackBar(
            context: context,
            message: 'no_exist_account'.tr(),
          );
        }
      }
      catch (e) {
        SnackBarUtils.showErrorSnackBar(
          context: context,
          message: 'Error: ${e.toString()}',
        );
      }
    }
  }
}
