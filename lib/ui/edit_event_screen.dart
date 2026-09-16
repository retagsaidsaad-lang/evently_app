import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/event.dart';
import '../providers/theme_provider.dart';
import '../utils/app_assets.dart';
import '../utils/app_colors.dart';
import '../utils/app_styles.dart';
import '../utils/app_theme.dart';
import '../utils/firebase_utils.dart';
import '../utils/size_utils.dart';
import '../utils/snack_bar_utils.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_tab_item.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/data_or_time_widget.dart';

class EditEventScreen extends StatefulWidget {
  final Event event;

  const EditEventScreen({super.key, required this.event});

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  List<String> eventLightImagesList = [
    AppAssets.sportImage,
    AppAssets.birthdayImage,
    AppAssets.bookClubImage,
    AppAssets.meetingImage,
    AppAssets.exhibitionImage
  ];

  List<String> eventDarkImagesList = [
    AppAssets.sportDarkImage,
    AppAssets.birthdayDarkImage,
    AppAssets.bookClubDarkImage,
    AppAssets.meetingDarkImage,
    AppAssets.exhibitionDarkImage
  ];

  List<String> eventNameList = [
    'home_category_sport'.tr(),
    'home_category_birthday'.tr(),
    'home_category_book_club'.tr(),
    'home_category_meeting'.tr(),
    'home_category_exhibition'.tr()
  ];

  List<IconData> eventIconsList = [
    Icons.directions_bike,
    Icons.cake_outlined,
    Icons.book_outlined,
    Icons.groups_outlined,
    Icons.art_track_outlined
  ];

  String formatDate = '';
  String formatTime = '';
  int selectedIndex = 0;
  DateTime? selectedEventDate;
  TimeOfDay? selectedEventTime;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.event.eventTitle);
    descriptionController = TextEditingController(text: widget.event.eventDescription);
    selectedEventDate = widget.event.eventDate;
    formatDate = DateFormat('yyyy/MM/dd').format(widget.event.eventDate);
    selectedEventTime = TimeOfDay.fromDateTime(widget.event.eventDate);
    }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var themProvider = Provider.of<ThemeProvider>(context);

    if (selectedEventTime != null) {
      formatTime = selectedEventTime!.format(context);
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.transparentColor,
        centerTitle: true,
        title: Text(
          'events_edit_title'.tr(),
          style: themProvider.isDarkMode
              ? AppStyles.medium18WhiteColor
              : AppStyles.medium18BlackColor,
        ),
        leadingWidth: context.width * 0.14,
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
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: themProvider.isDarkMode
                  ? AppColors.whiteColor
                  : AppColors.mainLightColor,
              size: 25,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.width * 0.04,
          vertical: context.height * 0.02,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: context.height * 0.02,
            children: [
              Container(
                height: context.height * 0.23,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    width: 2,
                    color: Theme.of(context).dividerColor,
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.asset(
                  themProvider.isDarkMode
                      ? eventDarkImagesList[selectedIndex]
                      : eventLightImagesList[selectedIndex],
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: context.height * 0.05,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: CustomTabItem(
                        isSelected: selectedIndex == index,
                        unSelectedColor: themProvider.isDarkMode
                            ? AppColors.darkInputColor
                            : AppColors.whiteColor,
                        eventName: eventNameList[index],
                        icons: eventIconsList[index],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(width: context.width * 0.02);
                  },
                  itemCount: eventNameList.length,
                ),
              ),
              Text(
                'events_input_title'.tr(),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              CustomTextField(
                controller: titleController,
                hintText: 'events_input_title'.tr(),
                hintStyle: Theme.of(context).textTheme.bodyLarge,
                fill: true,
                filledColor: themProvider.isDarkMode
                    ? AppColors.darkInputColor
                    : AppColors.whiteColor,
                borderColor: Theme.of(context).dividerColor,
              ),
              Text(
                'events_input_description'.tr(),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              CustomTextField(
                controller: descriptionController,
                hintText: 'events_description_placeholder'.tr(),
                hintStyle: Theme.of(context).textTheme.bodyLarge,
                fill: true,
                maxLines: 7,
                filledColor: themProvider.isDarkMode
                    ? AppColors.darkInputColor
                    : AppColors.whiteColor,
                borderColor: Theme.of(context).dividerColor,
              ),
              DataOrTimeWidget(
                icon: Icon(
                  Icons.date_range_outlined,
                  color: Theme.of(context).cardColor,
                ),
                dataOrTime: 'events_date'.tr(),
                onChooseClick: onChooseDate,
                chooseDataOrTime: formatDate.isEmpty
                    ? 'events_choose_date'.tr()
                    : formatDate,
              ),
              DataOrTimeWidget(
                icon: Icon(
                  Icons.timer_outlined,
                  color: Theme.of(context).cardColor,
                ),
                dataOrTime: 'events_time'.tr(),
                onChooseClick: onChooseTime,
                chooseDataOrTime: formatTime.isEmpty
                    ? 'events_choose_time'.tr()
                    : formatTime,
              ),
              CustomElevatedButton(
                verticalPadding: context.height * 0.015,
                backGroundColor: Theme.of(context).cardColor,
                onPressed: updateEvent,
                child: Text(
                  'events_update_btn'.tr(),
                  style: AppStyles.medium20WhiteColor,
                ),
              ),
              SizedBox(height: context.height * 0.04),
            ],
          ),
        ),
      ),
    );
  }

  void onChooseDate() async{
    var chooseDate = await showDatePicker(
        context: context,

        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365))
    );
    if(chooseDate!= null){
      selectedEventDate = chooseDate ;
      formatDate = DateFormat('yyyy/dd/MM').format(selectedEventDate!) ;
      setState(() {

      });
    }
  }

  void onChooseTime() async {
    var chooseTime = await showTimePicker(
      context: context,
      initialTime: selectedEventTime ?? TimeOfDay.now(),
      builder: (context, child) {
        var themProvider = Provider.of<ThemeProvider>(context);
        bool isDark = themProvider.isDarkMode;
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: isDark
                ? AppTheme.darkTimePickerTheme
                : AppTheme.lightTimePickerTheme,
          ),
          child: child!,
        );
      },
    );

    if (chooseTime != null) {
      setState(() {
        selectedEventTime = chooseTime;
        formatTime = chooseTime.format(context);
      });
    }
  }


  void updateEvent() async {
    if (selectedEventDate == null) {
      SnackBarUtils.showErrorSnackBar(
        context: context,
        message: 'Please select event date.',
      );
      return;
    }

    DateTime updatedDateTime = DateTime(
      selectedEventDate!.year,
      selectedEventDate!.month,
      selectedEventDate!.day,
      selectedEventTime?.hour ?? 0,
      selectedEventTime?.minute ?? 0,
    );

    Event updatedEvent = Event(
      eventId: widget.event.eventId,
      eventName: eventNameList[selectedIndex],
      eventImage: eventLightImagesList[selectedIndex],
      eventTitle: titleController.text,
      eventDescription: descriptionController.text,
      eventDate: updatedDateTime,
      isFavourite: widget.event.isFavourite,
      eventCategoryIndex: selectedIndex,
    );

    await FirebaseUtils.updateEventInFireStore(updatedEvent);

    if (!mounted) return;

    Navigator.pop(context, updatedEvent);

    SnackBarUtils.showSuccessSnackBar(
      context: context,
      message: 'updated_event'.tr(),
    );
  }
}

