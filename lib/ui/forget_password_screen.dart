import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/utiles/app_assets.dart';
import 'package:untitled1/utiles/app_routes.dart';
import 'package:untitled1/utiles/app_styles.dart';
import 'package:untitled1/utiles/firebase_utils.dart';
import 'package:untitled1/widgets/custom_elevated_button.dart';
import 'package:untitled1/widgets/custom_text_field.dart';
import '../providers/theme_provider.dart';
import '../utiles/app_colors.dart';
import '../utiles/size_utiles.dart';

class ForgetPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
   ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.width *0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                   Container(
                      width: context.width*0.1,
                      height: context.height*0.046,
                      decoration: BoxDecoration(
                        color: themeProvider.isDarkMode ? AppColors.darkInputColor : AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: Theme.of(context).dividerColor,
                            width: 2
                        ),
                      ),
                      child: IconButton(onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.loginRouteName);
                      },
                          icon: Icon(Icons.arrow_back_ios_new_rounded
                            , color: themeProvider.isDarkMode ? AppColors.whiteColor : AppColors.mainLightColor,
                          )),
                    ),
                  SizedBox(width: context.width*0.2,),
                  Text('auth_forget_password_title'.tr() ,
                    style: Theme.of(context).textTheme.titleSmall,),
                ],
              ),
              SizedBox(height: context.height*0.03,),
              Image.asset(themeProvider.isDarkMode ? AppAssets.forgetPasswordDarkImage
                  : AppAssets.forgetPasswordImage),
              SizedBox(height: context.height*0.03,),
              Text('Enter your email address and we will send you a link to reset your password' ,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: context.height*0.03,),
              Text('Email Address',
                style: Theme.of(context).textTheme.labelMedium,
              ) ,
              SizedBox(height: context.height*0.01,),
              CustomTextField(
                borderColor: Theme.of(context).dividerColor,
                controller: emailController,
                hintText: 'auth_enter_email'.tr(),
                hintStyle: Theme.of(context).textTheme.headlineMedium,
                prefixIcon: Icon(Icons.email_outlined ,
                  color: themeProvider.isDarkMode ? AppColors.whiteColor : AppColors.blackColor,
                ),
              ),
              SizedBox(height: context.height*0.03,),
              CustomElevatedButton(
                verticalPadding: 12,
                backGroundColor: themeProvider.isDarkMode ? AppColors.mainDarkColor : AppColors.mainLightColor,
                  child: Text('auth_reset_password_btn'.tr(),
                  style: AppStyles.medium20WhiteColor,)
                  , onPressed: () async{
                  String email = emailController.text.trim();
                  if(email.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Please enter your email',
                              style: AppStyles.regular14WhiteColor
                          ),
                        backgroundColor: themeProvider.isDarkMode ? AppColors.mainDarkColor : AppColors.mainLightColor,
                      ),
                      );
                    return ;
                  }
                  try{
                     await FirebaseUtils.resetPassword(email);
                     if(context.mounted){
                       ScaffoldMessenger.of(context).showSnackBar(
                           SnackBar(
                               content: Text('Reset link sent! Check your email.',
                                   style: AppStyles.regular14WhiteColor
                               ),
                               backgroundColor: Colors.green
                           )
                       );
                       Navigator.pop(context);
                     }
                  }catch(e){
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(e.toString(),
                              style: AppStyles.regular14WhiteColor),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}
