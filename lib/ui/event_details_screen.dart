import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/utiles/app_colors.dart';
import 'package:untitled1/utiles/app_styles.dart';
import 'package:untitled1/widgets/edit_or_delete_widget.dart';
import '../model/event.dart';
import '../providers/theme_provider.dart';
import '../utiles/app_assets.dart';
import '../utiles/firebase_utils.dart';
import '../utiles/size_utiles.dart';
import '../utiles/snack_bar_utiles.dart';
import '../widgets/custom_text_field.dart';
import 'edit_event_screen.dart';

class EventDetailsScreen extends StatefulWidget {
  final Event event;

  const EventDetailsScreen({super.key, required this.event});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  late Event event;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    event = widget.event;
  }
  @override
  Widget build(BuildContext context) {
    var themProvider = Provider.of<ThemeProvider>(context);
    String formattedDate = DateFormat('d MMMM yyyy').format(event.eventDate);
    String formattedTime = DateFormat('hh:mm a').format(event.eventDate);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        actionsPadding: EdgeInsets.symmetric(horizontal: context.width * 0.03),
        backgroundColor: AppColors.transparentColor,
        leadingWidth: context.width * 0.14,
        centerTitle: true,
        leading: Container(
          margin: EdgeInsetsDirectional.only(
            start: context.width * 0.04,
            top: context.height * 0.014,
          ),
          decoration: BoxDecoration(
            color: themProvider.isDarkMode
                ? AppColors.darkInputColor
                : AppColors.whiteColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              width: 2,
              color: Theme.of(context).dividerColor,
            ),
          ),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context, event);            },
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: themProvider.isDarkMode
                  ? AppColors.whiteColor
                  : AppColors.mainLightColor,
              size: 25,
            ),
          ),
        ),
        title: Text(
          'events_details_title'.tr(),
          style: themProvider.isDarkMode
              ? AppStyles.medium18WhiteColor
              : AppStyles.medium18BlackColor,
        ),
        actions: [
          EditOrDeleteWidget(
            icon: IconButton(
              onPressed: () async {
                var updatedEvent = await Navigator.push<Event>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditEventScreen(event: event),
                  ),
                );
                print("=== CHECK RETURNED EVENT ===");
                print(updatedEvent?.eventName);
                if (updatedEvent != null) {
                  setState(() {
                    event = updatedEvent;
                  });
                }
                }, icon: Icon(
                Icons.edit_outlined,
                color: Theme.of(context).cardColor,
              ),
            ),
          ),
          SizedBox(width: context.width * 0.01),
          EditOrDeleteWidget(
            icon: IconButton(
              onPressed: () async {
                await FirebaseUtils.deleteEventFromFirestore(event.eventId);
                if (context.mounted) {
                  Navigator.pop(context);
                  SnackBarUtils.showSuccessSnackBar(
                    context: context,
                    message: 'deleted_event'.tr(),
                  );
                }
              },
              icon: Icon(
                Icons.delete_outline_rounded,
                color: AppColors.redColor,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: context.width * 0.04,
          vertical: context.height * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  width: 2,
                  color: Theme.of(context).dividerColor,
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(
                AppAssets.getEventImage(event.eventName, context),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: context.height * 0.02),
            Text(
              event.eventTitle,
              style: themProvider.isDarkMode
                  ? AppStyles.medium18WhiteColor
                  : AppStyles.medium18BlackColor,
            ),
            SizedBox(height: context.height * 0.02),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: context.width * 0.04,
                vertical: context.height * 0.015,
              ),
              decoration: BoxDecoration(
                color: themProvider.isDarkMode
                    ? AppColors.darkInputColor
                    : AppColors.whiteColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).dividerColor,
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.width * 0.02,
                      vertical: context.height * 0.01,
                    ),
                    decoration: BoxDecoration(
                      color: themProvider.isDarkMode
                          ? AppColors.strokeDarkColor
                          : AppColors.lightBgColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Theme.of(context).dividerColor,
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      Icons.calendar_month_outlined,
                      color: Theme.of(context).cardColor,
                    ),
                  ),
                  SizedBox(width: context.width * 0.04),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        formattedDate,
                        style: Theme.of(context).textTheme.headlineMedium
                        ),
                      SizedBox(height: context.height * 0.005),
                      Text(
                        formattedTime,
                        style: Theme.of(context).textTheme.bodyLarge
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: context.height * 0.02),
            Text(
              'events_input_description'.tr(),
              style: themProvider.isDarkMode
                  ? AppStyles.medium18WhiteColor
                  : AppStyles.medium18BlackColor,
            ),
            SizedBox(height: context.height * 0.01),
            CustomTextField(
              hintText: event.eventDescription,
              hintStyle: Theme.of(context).textTheme.bodyLarge,
              fill: true,
              maxLines: 7,
              filledColor: themProvider.isDarkMode
                  ? AppColors.darkInputColor
                  : AppColors.whiteColor,
              borderColor: Theme.of(context).dividerColor,
            ),
          ],
        ),
      ),
    );
  }
}
