import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/model/my_user.dart';
import 'package:untitled1/providers/user_provider.dart';
import 'package:untitled1/utils/app_assets.dart';
import 'package:untitled1/utils/app_styles.dart';
import 'package:untitled1/utils/snack_bar_utils.dart';
import 'package:untitled1/utils/firebase_utils.dart';
import 'package:untitled1/utils/size_utils.dart';
import 'package:untitled1/widgets/custom_elevated_button.dart';
import 'package:untitled1/widgets/custom_text_field.dart';
import '../providers/theme_provider.dart';
import '../utils/app_colors.dart';
import '../utils/app_routes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController(text: 'Retag') ;
  TextEditingController emailController = TextEditingController(text: 'retag@gmail.com' ) ;
  TextEditingController passwordController = TextEditingController(text: '123456') ;
  TextEditingController rePasswordController = TextEditingController(text: '123456') ;
  bool isPasswordObscure = true;
  bool isConfirmPasswordObscure = true;
  var formKey = GlobalKey <FormState> ();
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
                  Text('auth_create_account_title'.tr(),
                    style:Theme.of(context).textTheme.headlineSmall ,
                  ),
                  CustomTextField(
                    hintText: 'auth_enter_name'.tr(),
                    hintStyle: Theme.of(context).textTheme.bodyLarge,
                    borderColor: Theme.of(context).dividerColor,
                    fill: true,
                    controller: nameController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      if(text == null || text.trim().isEmpty){
                        return 'Please enter Name.' ;
                      }
                      return null ;
                    },
                    filledColor: themProvider.isDarkMode ? AppColors.darkInputColor : AppColors.whiteColor,
                    prefixIcon: Icon(Icons.person_outline, color: AppColors.lightGreyColor,),
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
                    prefixIcon: Icon(Icons.mail_outline, color: AppColors.lightGreyColor,),
                  ),
                  CustomTextField(
                    hintText: 'auth_enter_password'.tr(),
                    hintStyle: Theme.of(context).textTheme.bodyLarge,
                    borderColor: Theme.of(context).dividerColor,
                    fill: true,
                    keyboardType: TextInputType.phone,
                    obscureText: isPasswordObscure,
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
                    suffixIcon: IconButton(
                      icon: Icon(
                          isPasswordObscure ?Icons.visibility_off_outlined : Icons.visibility,
                          color: AppColors.lightGreyColor
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordObscure = !isPasswordObscure;
                        });
                      },
                    ),
                  ),
                  CustomTextField(
                    hintText: 'auth_confirm_password'.tr(),
                    hintStyle: Theme.of(context).textTheme.bodyLarge,
                    borderColor: Theme.of(context).dividerColor,
                    fill: true,
                    keyboardType: TextInputType.phone,
                    obscureText: isConfirmPasswordObscure,
                    controller: rePasswordController,
                    validator: (text) {
                      if(text == null || text.trim().isEmpty){
                        return 'Please enter Re-Password.';
                      }
                      if(text!= passwordController.text){
                        return "Re-Password doesn't match Password.";
                      }
                      return null ;
                    },
                    filledColor: themProvider.isDarkMode ? AppColors.darkInputColor : AppColors.whiteColor,
                    prefixIcon: Icon(Icons.lock_outlined, color: AppColors.lightGreyColor,),
                    suffixIcon: IconButton(
                      icon: Icon(
                          isConfirmPasswordObscure ?Icons.visibility_off_outlined : Icons.visibility,
                          color: AppColors.lightGreyColor
                      ),
                      onPressed: () {
                        setState(() {
                          isConfirmPasswordObscure = !isConfirmPasswordObscure;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: context.height*0.04,),
                  CustomElevatedButton(
                      verticalPadding: context.height*0.015,
                      backGroundColor: Theme.of(context).cardColor,
                      onPressed: signUp,
                      child: Text('auth_sign_up_btn'.tr(),
                        style: AppStyles.medium20WhiteDarkColor,)
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('auth_already_have_account'.tr() ,
                        style:  Theme.of(context).textTheme.bodyLarge,),
                      TextButton(onPressed: () {
                        Navigator.pop(context);
                      },
                          child: Text('auth_login'.tr(),
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
                    onPressed: () {
        
                    },
                    child: Row(
                      spacing: context.width*0.04,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AppAssets.googleLogoImage),
                        Text('auth_sign_up_with_google'.tr(),
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

  void signUp() async {
    if (formKey.currentState?.validate() == true) {
      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        MyUser myUser = MyUser(
          uId: credential.user?.uid ?? '',
          name: nameController.text,
          email: emailController.text,
        );
        await FirebaseUtils.addUserInFireStore(myUser);
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.upDateUser(myUser);
        SnackBarUtils.showSnackBar(
          context: context,
          message: 'register_success'.tr(),
        );
        await Future.delayed( Duration(seconds: 0));
        Navigator.pushReplacementNamed(
          context,
          AppRoutes.homeScreenRouteName,
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          SnackBarUtils.showErrorSnackBar(
            context: context,
            message: 'weak_password'.tr(),
          );
        } else if (e.code == 'email-already-in-use') {
          SnackBarUtils.showErrorSnackBar(
            context: context,
            message: 'The account already exists for that email.'.tr(),
          );
        }
      } catch (e) {
        SnackBarUtils.showErrorSnackBar(
          context: context,
          message: 'Error: ${e.toString()}',
        );
      }
    }
  }
}
