import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class AppAssets {
  static const String eventlyLogoImage = 'assets/images/evently_logo.png' ;
  static const String beingCreativeImage = 'assets/images/being_creative.png' ;
  static const String beingCreativeDarkImage = 'assets/images/being_creative_dark.png' ;
  static const String routeImage = 'assets/images/route_image.png' ;
  static const String onboarding1Image = 'assets/images/onboarding1_image.png' ;
  static const String onboarding1DarkImage = 'assets/images/onboarding1_image_dark.png' ;
  static const String onboarding2Image = 'assets/images/onboarding2_image.png' ;
  static const String onboarding2DarkImage = 'assets/images/onboarding2_image_dark.png' ;
  static const String onboarding3Image = 'assets/images/onboarding3_image.png' ;
  static const String onboarding3DarkImage = 'assets/images/onboarding3_image_dark.png' ;
  static const String eventlyLogoDarkImage = 'assets/images/evently_logo_dark.png' ;
  static const String googleLogoImage = 'assets/images/google_logo.png' ;
  static const String forgetPasswordDarkImage = 'assets/images/forget_password_dark.png' ;
  static const String forgetPasswordImage = 'assets/images/forget_password.png' ;
  static const String birthdayImage = 'assets/images/birthday_image.png' ;
  static const String birthdayDarkImage = 'assets/images/birthday_image_dark.png' ;
  static const String sportImage = 'assets/images/sport_image.png' ;
  static const String sportDarkImage = 'assets/images/sport_image_dark.png' ;
  static const String bookClubImage = 'assets/images/bookClub_image.png' ;
  static const String bookClubDarkImage = 'assets/images/bookClub_image_dark.png' ;
  static const String meetingImage = 'assets/images/meeting_image.png' ;
  static const String meetingDarkImage = 'assets/images/meeting_image_dark.png' ;
  static const String exhibitionImage = 'assets/images/exhibition_image.png' ;
  static const String exhibitionDarkImage = 'assets/images/exhibition_image_dark.png' ;


  static String getEventImage(String categoryName, BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    bool isDark = themeProvider.isDarkMode;
    String name = categoryName.toLowerCase().replaceAll(' ', '');

    if (name.contains('sport')) {
      return isDark ? AppAssets.sportDarkImage : AppAssets.sportImage;
    } else if (name.contains('birthday')) {
      return isDark ? AppAssets.birthdayDarkImage : AppAssets.birthdayImage;
    } else if (name.contains('meeting')) {
      return isDark ? AppAssets.meetingDarkImage : AppAssets.meetingImage;
    } else if (name.contains('book')) {
      return isDark ? AppAssets.bookClubDarkImage : AppAssets.bookClubImage;
    } else if (name.contains('exhibition')) {
      return isDark ? AppAssets.exhibitionDarkImage : AppAssets.exhibitionImage;
    }
    return isDark ? AppAssets.sportDarkImage : AppAssets.sportImage;
  }
}