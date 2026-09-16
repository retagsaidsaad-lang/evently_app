import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/model/event.dart';
import 'package:untitled1/providers/theme_provider.dart';
import 'package:untitled1/utils/app_colors.dart';
import 'package:untitled1/utils/app_styles.dart';
import 'package:untitled1/utils/firebase_utils.dart';
import '../utils/app_assets.dart';
import '../utils/size_utils.dart';
import '../utils/snack_bar_utils.dart';

class CustomEventItem extends StatefulWidget {
   final Event event ;
   const CustomEventItem({super.key ,required this.event });

  @override
  State<CustomEventItem> createState() => _CustomEventItemState();
}

class _CustomEventItemState extends State<CustomEventItem> {
  @override
  Widget build(BuildContext context) {
    var themProvider = Provider.of<ThemeProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.width*0.02,
        vertical: context.height*0.008
      ),
      width: context.width*0.20,
      height: context.height*0.25,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).dividerColor,
              width: 2
        ),
        image: DecorationImage(
            image: AssetImage(
              AppAssets.getEventImage(widget.event.eventName, context)),
          fit: BoxFit.fill
            ),
        ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: context.width*0.02,
              vertical: context.height*0.01
            ),
            decoration: BoxDecoration(
                color: themProvider.isDarkMode ? AppColors.darkBgColor
                    : AppColors.lightBgColor ,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Theme.of(context).dividerColor,
                width: 2
              ),
            ),
            child: Text( DateFormat('dd MMM').format(widget.event.eventDate).toString(),
            style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          Container(
            padding:  EdgeInsets.symmetric(
          horizontal: context.width*0.02,
          ),
            decoration: BoxDecoration(
              color: themProvider.isDarkMode ? AppColors.darkBgColor
                  : AppColors.lightBgColor ,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Theme.of(context).dividerColor,
                width: 2,
              )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.event.eventTitle,
                  style: themProvider.isDarkMode ? AppStyles.medium14WhiteColor
                      : AppStyles.medium14BlackColor,
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      updateIsFavourite(context, widget.event);
                    });
                    },
                  icon: Icon(
                    widget.event.isFavourite ? Icons.favorite
                        : Icons.favorite_outline,
                    color: Theme.of(context).cardColor,
                  ),
                )
              ],
            ),
          )
        ],
      ),
        );
  }

  Future<void> updateIsFavourite(BuildContext context, Event event) async {
    event.isFavourite = !event.isFavourite;
    return FirebaseUtils.getEventCollection()
        .doc(event.eventId)
        .update({'is_favourite': event.isFavourite})
        .then((value) {
      if (context.mounted) {
        SnackBarUtils.showSuccessSnackBar(
          context: context,
          message: event.isFavourite
              ? 'Added to Favorites'
              : 'Removed from Favorites',
        );
      }
    }).catchError((error) {
      event.isFavourite = !event.isFavourite;
      print(error.toString());
    });
  }
}
