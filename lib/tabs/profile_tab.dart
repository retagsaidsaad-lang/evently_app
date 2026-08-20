import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/utiles/app_assets.dart';
import 'package:untitled1/utiles/app_routes.dart';
import '../language_bottom_sheet.dart';
import '../providers/theme_provider.dart';
import '../providers/user_provider.dart';
import '../utiles/app_colors.dart';
import '../utiles/size_utiles.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context) ;
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.width*0.04),
          child: Column(
            spacing: context.height*0.015,
            children: [
              SizedBox(height: context.height*0.03,),
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(AppAssets.routeImage),
              ),
              Text(userProvider.currentUser!.name,
                  style: Theme
                      .of(context)
                      .textTheme
                      .headlineLarge),
              Text(userProvider.currentUser!.email,
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyLarge,),
              buildItemWidget(
                  isDark: themeProvider.isDarkMode,
                  title: 'home_dark_mode'.tr(),
               item:  Switch(
                  activeTrackColor: AppColors.mainDarkColor,
                  inactiveTrackColor: AppColors.strokeWhiteColor,
                    activeThumbColor: AppColors.whiteColor,
                    inactiveThumbColor: AppColors.whiteColor,
                    trackOutlineColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
                      if (states.contains(WidgetState.disabled)) {
                        return AppColors.greyColor;
                      }
                      return AppColors.whiteColor;
                    }),
                    value: themeProvider.isDarkMode
                    , onChanged: (value) {
                   themeProvider.changeTheme(value ? ThemeMode.dark : ThemeMode.light);
                    })
                  ),
              buildItemWidget(
                  isDark: themeProvider.isDarkMode,
                title:  'onboarding_language'.tr(),
                  item: IconButton(onPressed: () {
                    showLanguageBottomSheet();
                  }
                  , icon: Icon(Icons.arrow_forward_ios_outlined,
                      color: Theme.of(context).cardColor,))
              ),
              buildItemWidget(
                  isDark: themeProvider.isDarkMode,
                 title:  'home_logout'.tr(),
                  item: IconButton(
                    onPressed: (){
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          AppRoutes.loginRouteName
                          , (route) => false,
                      );
                    },
                    icon: Icon(Icons.logout_outlined) ,
                  color: AppColors.redColor,)
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildItemWidget({
      required bool isDark,
       required String title,
      required Widget? item}) {
    return Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkInputColor : AppColors.whiteColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
                color: Theme
                    .of(context)
                    .dividerColor,
                width: 2
            )
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(
              horizontal: context.width*0.02,
          vertical: context.height*0.003),
          title: Text(title,
            style: Theme
                .of(context)
                .textTheme
                .headlineMedium,),
          trailing: item,
        )
    );
  }
  void showLanguageBottomSheet (){
   showModalBottomSheet(context: context,
       builder: (context) => LanguageBottomSheet());
  }
}