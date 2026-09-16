import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/providers/theme_provider.dart';
import 'package:untitled1/utils/app_assets.dart';
import 'package:untitled1/utils/app_colors.dart';
import 'package:untitled1/utils/app_routes.dart';
import 'package:untitled1/utils/app_styles.dart';
import 'package:untitled1/utils/size_utils.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {


  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode;
    bool isEnglish = context.locale.languageCode == 'en';
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.width * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(themeProvider.isDarkMode ?AppAssets.eventlyLogoDarkImage :
                  AppAssets.eventlyLogoImage),
                  Image.asset(themeProvider.isDarkMode ? AppAssets.beingCreativeDarkImage :
                    AppAssets.beingCreativeImage,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: context.height * 0.01,),
                  Text(
                      'onboarding_personalize_title'.tr(),
                      style: Theme.of(context).textTheme.headlineLarge
                  ),
                  SizedBox(height: context.height * 0.01,),
                  Text(
                      'onboarding_personalize_desc'.tr(),
                      style:Theme.of(context).textTheme.bodyLarge
                  ),
                  SizedBox(height: context.height * 0.02,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          'onboarding_language'.tr(),
                          style: Theme.of(context).textTheme.titleSmall
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              context.setLocale(Locale('en'));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                            horizontal: context.height*0.01,
                                vertical: context.width*0.02),
                              decoration: BoxDecoration(
                              color:  isEnglish
                              ? (isDarkMode ? AppColors.mainDarkColor : AppColors.mainLightColor)
                                    : (isDarkMode ? Colors.transparent : AppColors.whiteColor),
                                borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: Theme.of(context).dividerColor
                                  )
                              ),
                              child: Text(
                                'onboarding_english'.tr(),
                                style: isEnglish ? AppStyles.semi14WhiteColor : AppStyles.semi14MainColor
                              ),
                            ),
                          ),
                          SizedBox(width: context.width * 0.02,),
                          GestureDetector(
                            onTap: () {
                              context.setLocale(Locale('ar'));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: context.height*0.01,
                                  vertical: context.width*0.02),
                              decoration: BoxDecoration(
                               color: !isEnglish
                              ? (isDarkMode ? AppColors.mainDarkColor : AppColors.mainLightColor)
                                    : (isDarkMode ? Colors.transparent : AppColors.whiteColor),
                                borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: Theme.of(context).dividerColor
                                  )
                              ),
                              child: Text(
                                'onboarding_arabic'.tr(),
                               style: !isEnglish ?  AppStyles.semi14WhiteColor :AppStyles.semi14MainColor

                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: context.height * 0.02,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'onboarding_theme'.tr(),
                        style: Theme.of(context).textTheme.titleSmall,
                        ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              themeProvider.changeTheme(ThemeMode.light);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                            horizontal: context.height*0.01,
                                vertical: context.width*0.02),
                              decoration: BoxDecoration(
                                color: !isDarkMode ?  AppColors.mainLightColor : AppColors.darkInputColor,
                                borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: Theme.of(context).dividerColor
                                  )
                              ),
                              child: Icon(
                                Icons.wb_sunny_outlined,
                                color: AppColors.whiteColor,
                                size: 20,
                              ),
                            ),
                          ),
                          SizedBox(width: context.width * 0.02,),
                          GestureDetector(
                            onTap: () {
                              themeProvider.changeTheme(ThemeMode.dark);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: context.height*0.01,
                                  vertical: context.width*0.02),
                              decoration: BoxDecoration(
                                color: isDarkMode ? AppColors.mainDarkColor : AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Theme.of(context).dividerColor
                                )
                              ),
                              child: Icon(
                                Icons.nightlight_outlined,
                                color: isDarkMode ? AppColors.whiteColor : AppColors.mainLightColor,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: context.height * 0.04),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.onBoardingLightRouteName);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      themeProvider.isDarkMode ? AppColors.mainDarkColor : AppColors.mainLightColor,
                      padding:  EdgeInsets.symmetric(vertical: context.height*0.015),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text('onboarding_lets_started'.tr(),
                      style: AppStyles.medium20WhiteColor ,
                   ),
                  ),
                ],
              ),
          ),
      ),
    );
  }

}
