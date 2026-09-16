import 'package:flutter/material.dart';
import 'package:untitled1/utils/app_colors.dart';
import 'package:untitled1/utils/app_styles.dart';
import '../utils/size_utils.dart';

class CustomTabItem extends StatelessWidget {
  final bool isSelected ;
  final Color unSelectedColor ;
  final String eventName ;
  final IconData icons ;
  const CustomTabItem({super.key, required this.isSelected
     , required this.unSelectedColor,
    required this.eventName , required this.icons
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.width*0.04,
        vertical: context.height*0.01
      ),
      decoration: BoxDecoration(
        color: isSelected ? Theme.of(context).cardColor : unSelectedColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).dividerColor,
            width: 2
        )
      ),
      child: Row(
        spacing: context.width*0.02,
        children: [
          Icon( icons ,
            color: isSelected ? AppColors.whiteColor : Theme.of(context).cardColor,
          ),
          Text( eventName ,
          style: isSelected ? AppStyles.medium16WhiteColor : Theme.of(context).textTheme.headlineMedium,)
        ],
      ),
    );
  }
}
