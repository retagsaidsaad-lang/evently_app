import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/utils/app_assets.dart';
import 'package:untitled1/utils/app_colors.dart';
import 'package:untitled1/utils/app_routes.dart';
import 'package:untitled1/utils/app_styles.dart';

import '../providers/theme_provider.dart';

class OnboardingLightScreen extends StatefulWidget {
  const OnboardingLightScreen({super.key});

  @override
  State<OnboardingLightScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingLightScreen> {

  final _introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(BuildContext context) {

  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var pageDecoration = PageDecoration(
           bodyAlignment: Alignment.centerLeft,
           imageAlignment: Alignment.center,
           bodyPadding:  EdgeInsets.symmetric(vertical: 8.0),
           imagePadding:  EdgeInsets.only(top: 24.0, bottom: 12.0),
           imageFlex: 3,
           bodyFlex: 2,
         );
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor ,
      body: SafeArea(
        child: IntroductionScreen(
          key: _introKey,
          globalHeader: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: themeProvider.isDarkMode ? AppColors.darkInputColor : AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: themeProvider.isDarkMode ? AppColors.strokeDarkColor : AppColors.strokeWhiteColor ,
                            width: 2
                        ),
                      ),
                      child: IconButton(onPressed: () {
                        int currentPage = _introKey.currentState?.getCurrentPage() ?? 0;

                        if (currentPage == 0) {
                          Navigator.of(context).pushReplacementNamed(AppRoutes.onBoardingRouteName);
                        } else {
                          _introKey.currentState?.previous();
                        }
                      },
                          icon: Icon(Icons.arrow_back_ios_new_rounded),
                      color: themeProvider.isDarkMode ? AppColors.whiteColor : AppColors.mainLightColor,),
                    ),
                    Image.asset(themeProvider.isDarkMode ?AppAssets.eventlyLogoDarkImage
                        : AppAssets.eventlyLogoImage
                    ),
                    TextButton(
                      onPressed: () => _introKey.currentState?.skipToEnd(),
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                  color: themeProvider.isDarkMode ? AppColors.strokeDarkColor : AppColors.strokeWhiteColor,
                                  width: 2
                              )
                          )
                      ),
                      child:  Text(
                          'onboarding_skip'.tr(),
                          style: themeProvider.isDarkMode ? AppStyles.semi14WhiteColor : AppStyles.semi14MainColor
                      ),
                    ),
                  ],
                ),
            ),
          pages: [
            PageViewModel(
              titleWidget: Align(
            alignment: Alignment.centerLeft,
          child: Text('onboarding_find_events_title'.tr(),
            style:  Theme.of(context).textTheme.headlineLarge,
          ),
        ),
              bodyWidget: Align(
                alignment: Alignment.centerLeft,
                child : Text('onboarding_find_events_desc'.tr(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              image: Image.asset(
                themeProvider.isDarkMode ? AppAssets.onboarding1DarkImage
                : AppAssets.onboarding1Image,
                fit: BoxFit.contain,
              ),
              decoration: pageDecoration,
            ),
            PageViewModel(
              titleWidget: Align(
                alignment: Alignment.centerLeft,
                child: Text('onboarding_effortless_title'.tr(),
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              bodyWidget: Align(
                alignment: Alignment.centerLeft,
               child: Text('onboarding_effortless_desc'.tr(),
                 style: Theme.of(context).textTheme.bodyLarge,
               ),
              ),
              image: Image.asset(
                themeProvider.isDarkMode ? AppAssets.onboarding2DarkImage
                  : AppAssets.onboarding2Image ,
                fit: BoxFit.contain,
              ),
              decoration: pageDecoration,
            ),
            PageViewModel(
              titleWidget: Align(
                  alignment: Alignment.centerLeft,
             child: Text('onboarding_connect_title'.tr(),
               style: Theme.of(context).textTheme.headlineLarge ,
               ),
              ),
              bodyWidget: Align(
                alignment: Alignment.centerLeft,
                  child: Text('onboarding_connect_desc'.tr(),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
              ),
              image: Image.asset(
                themeProvider.isDarkMode ? AppAssets.onboarding3DarkImage
                : AppAssets.onboarding3Image ,
                fit: BoxFit.contain,
              ),
              decoration: pageDecoration,
            ),
          ],

          onDone: () => _onIntroEnd(context),
          onSkip: () => _introKey.currentState ?.animateScroll(2),
          isProgress : false,
          showSkipButton: false,
          showBackButton: false,
          showNextButton: true,
          showDoneButton: true,
          next: SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical:12 ),
                  backgroundColor: Theme.of(context).cardColor,
                    shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)
              ),
                  maximumSize: Size(double.infinity, 50)
              ),
              onPressed: () {
                _introKey.currentState?.next();
              },
              child: Text(
                'onboarding_next'.tr(),
                style: AppStyles.medium18WhiteColor
              ),
            ),
          ),
          done: SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical:12),
                    backgroundColor: Theme.of(context).cardColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)
                    ),
                ),
              onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.loginRouteName);
              },
              child: Text(
                'onboarding_get_started'.tr(),
                style: AppStyles.medium18WhiteColor,
                
                ),
            ),
          ),
          dotsFlex: 0,
           nextFlex: 1,
          skipOrBackFlex: 0,
          controlsPadding:  EdgeInsets.symmetric( horizontal: 8,vertical: 16),
          ),




      ),
    );
  }
}