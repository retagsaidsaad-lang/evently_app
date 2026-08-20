import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/utiles/size_utiles.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    Locale currentLocale = context.locale;
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () async {
              if(currentLocale.languageCode != 'ar') {
                await context.setLocale(Locale('ar'));
              }
            },
            child: Padding(
                padding: EdgeInsetsGeometry.symmetric(vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'onboarding_arabic'.tr(),
                  style: Theme.of(context).textTheme.labelMedium
                ),
                if (currentLocale.languageCode == 'ar')
                  Icon(Icons.check, color: Theme.of(context).cardColor),
              ],
            ),
            ),
          ),
          Divider(),
          InkWell(
            onTap: () async {
              if (currentLocale.languageCode != 'en') {
                await context.setLocale( Locale('en'));
              }
              Navigator.pop(context);
            },
            child: Padding(
              padding:  EdgeInsets.symmetric(vertical: context.height*0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'onboarding_english'.tr(),
                    style: Theme.of(context).textTheme.labelMedium
                  ),
                  if (currentLocale.languageCode == 'en')
                    Icon(Icons.check, color: Theme.of(context).cardColor),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
