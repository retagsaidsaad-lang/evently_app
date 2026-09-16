import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_styles.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
      scaffoldBackgroundColor: AppColors.lightBgColor,
      timePickerTheme: lightTimePickerTheme,
      datePickerTheme: lightDatePickerTheme,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.whiteColor,
        selectedItemColor: AppColors.mainLightColor,
        unselectedItemColor: AppColors.lightGreyColor,
        selectedLabelStyle: AppStyles.regular12MainColor,
        unselectedLabelStyle:AppStyles.regular12GreyColor,
      ),
      cardColor: AppColors.mainLightColor,
      dividerColor: AppColors.strokeWhiteColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.mainLightColor,
      shape: StadiumBorder()
    ),
      textTheme: TextTheme(
        headlineLarge: AppStyles.semi20BlackColor,
        headlineMedium: AppStyles.medium16BlackColor,
        bodyLarge: AppStyles.regular16GreyColor,
        headlineSmall: AppStyles.semi24MainColor,
        labelMedium: AppStyles.medium18MainColor,
        labelSmall: AppStyles.medium18MainColor,
        labelLarge: AppStyles.semi14MainColor,
        bodyMedium: AppStyles.semi16MainColor,
        bodySmall: AppStyles.medium14BlackColor,
        titleLarge: AppStyles.regular14MainColor,
        titleMedium: AppStyles.medium20BlackColor,
        titleSmall: AppStyles.medium18MainLightColor,
      ),
  );
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
      scaffoldBackgroundColor: AppColors.darkBgColor,
      timePickerTheme: darkTimePickerTheme,
      datePickerTheme: darkDatePickerTheme,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkBgColor,
        selectedItemColor: AppColors.mainDarkColor,
        unselectedItemColor: AppColors.lightGreyColor,
        selectedLabelStyle: AppStyles.regular12DarkMainColor,
        unselectedLabelStyle:AppStyles.regular12GreyColor,
      ),
      cardColor: AppColors.mainDarkColor,
      dividerColor: AppColors.mainLightColor,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.mainDarkColor,
          shape: StadiumBorder()
      ),
      textTheme: TextTheme(
        headlineLarge: AppStyles.semi20WhiteColor,
        headlineMedium: AppStyles.medium16WhiteColor,
        bodyLarge: AppStyles.regular16WhiteDarkColor,
        headlineSmall: AppStyles.semi24WhiteColor,
        labelMedium: AppStyles.medium18MainDarkColor,
        labelSmall: AppStyles.medium18MainDarkColor,
        labelLarge: AppStyles.semi14MainDarkColor,
        bodyMedium: AppStyles.semi16MainDark,
        bodySmall: AppStyles.medium14WhiteColor,
        titleLarge: AppStyles.regular14MainDarkColor,
        titleMedium: AppStyles.medium20WhiteDarkColor,
        titleSmall: AppStyles.medium18WhiteColor,
      )
  );
  static TimePickerThemeData lightTimePickerTheme = TimePickerThemeData(
    backgroundColor: AppColors.whiteColor,
    hourMinuteColor: AppColors.mainLightColor,
    hourMinuteTextColor: AppColors.whiteColor,
    dayPeriodColor: AppColors.whiteColor,
    dayPeriodTextColor: AppColors.mainLightColor,
    dialBackgroundColor: AppColors.whiteColor,
    dialHandColor: AppColors.mainLightColor,
      dialTextColor: AppColors.darkBgColor,
      entryModeIconColor: AppColors.mainLightColor,
      cancelButtonStyle: TextButton.styleFrom(
          foregroundColor: AppColors.mainLightColor
      ),
      confirmButtonStyle: TextButton.styleFrom(
          foregroundColor: AppColors.mainLightColor
      )
  );
  static TimePickerThemeData darkTimePickerTheme = TimePickerThemeData(
    helpTextStyle: TextStyle(color: AppColors.whiteColor),
    backgroundColor: AppColors.darkInputColor,
    hourMinuteColor: AppColors.mainDarkColor,
    hourMinuteTextColor: AppColors.whiteColor,
    dayPeriodColor: AppColors.mainDarkColor,
    dayPeriodTextColor: AppColors.whiteColor,
    dialBackgroundColor: AppColors.darkInputColor,
    dialHandColor: AppColors.mainDarkColor,
    dialTextColor: AppColors.whiteColor,
    entryModeIconColor: AppColors.whiteColor,
    cancelButtonStyle: TextButton.styleFrom(
      foregroundColor: AppColors.whiteColor
    ),
    confirmButtonStyle: TextButton.styleFrom(
      foregroundColor: AppColors.whiteColor
    )
  );
  static DatePickerThemeData lightDatePickerTheme = DatePickerThemeData(
    backgroundColor: AppColors.whiteColor,
    subHeaderForegroundColor: AppColors.mainLightColor,
    dividerColor: AppColors.mainLightColor,
    headerBackgroundColor: AppColors.whiteColor,
    headerForegroundColor: AppColors.mainLightColor,
    surfaceTintColor: AppColors.transparentColor,
    weekdayStyle: TextStyle(
        color: AppColors.mainLightColor
    ),
    headerHeadlineStyle:TextStyle(
        color: AppColors.mainLightColor
    ),
    headerHelpStyle: TextStyle(
        color: AppColors.mainLightColor
    ),
    dayStyle: TextStyle(color: AppColors.mainDarkColor),
    dayForegroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.whiteColor;
      }
      return AppColors.mainLightColor;
    }),
    todayForegroundColor: WidgetStateProperty.all(AppColors.mainLightColor),
    dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.mainLightColor;
      }
      return Colors.transparent;
    }),
  );
  static DatePickerThemeData darkDatePickerTheme = DatePickerThemeData(
   subHeaderForegroundColor: AppColors.whiteColor,
    dividerColor: AppColors.whiteColor,
    backgroundColor: AppColors.darkInputColor,
    headerBackgroundColor: AppColors.darkInputColor,
    headerForegroundColor: AppColors.whiteColor,
    dayStyle: TextStyle(color: AppColors.whiteColor),
    yearStyle: TextStyle(color: AppColors.whiteColor),
    surfaceTintColor: AppColors.transparentColor,
    dayForegroundColor: WidgetStateProperty.all(AppColors.whiteColor),
    weekdayStyle: TextStyle(
        color: AppColors.whiteColor
    ),
    headerHeadlineStyle:TextStyle(
        color: AppColors.whiteColor
    ),
    headerHelpStyle: TextStyle(
        color: AppColors.whiteColor
    ),
    dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.mainDarkColor;
      }
      return null;
    }),
    cancelButtonStyle: TextButton.styleFrom(
      foregroundColor: AppColors.whiteColor,
    ),
    confirmButtonStyle: TextButton.styleFrom(
      foregroundColor: AppColors.whiteColor,
    ),
    todayForegroundColor: WidgetStateProperty.all(AppColors.whiteColor),
  );

}