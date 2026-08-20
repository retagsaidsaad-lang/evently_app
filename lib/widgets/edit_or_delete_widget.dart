import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/utiles/app_colors.dart';

import '../providers/theme_provider.dart';
import '../utiles/size_utiles.dart';

class EditOrDeleteWidget extends StatelessWidget {
  final Widget icon ;
  const EditOrDeleteWidget({super.key , required this.icon });

  @override
  Widget build(BuildContext context) {
    var themProvider = Provider.of<ThemeProvider>(context);
    return Container(
      width: context.width*0.097,
      height: context.height*0.04,
      decoration: BoxDecoration(
        color: themProvider.isDarkMode ? AppColors.darkInputColor
            : AppColors.whiteColor , 
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).dividerColor,
          width: 2
        )
      ),
      child: icon,
    );
  }
}
