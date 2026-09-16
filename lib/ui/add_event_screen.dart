import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/model/event.dart';
import 'package:untitled1/utils/app_assets.dart';
import 'package:untitled1/utils/app_colors.dart';
import 'package:untitled1/utils/app_styles.dart';
import 'package:untitled1/utils/firebase_utils.dart';
import 'package:untitled1/utils/snack_bar_utils.dart';
import 'package:untitled1/widgets/custom_elevated_button.dart';
import 'package:untitled1/widgets/custom_tab_item.dart';
import 'package:untitled1/widgets/custom_text_field.dart';
import 'package:untitled1/widgets/data_or_time_widget.dart';
import '../providers/theme_provider.dart';
import '../utils/app_theme.dart';
import '../utils/size_utils.dart';

class AddEventScreen extends StatefulWidget {
   const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
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
     Icons.grid_view_rounded ,
     Icons.directions_bike ,
     Icons.cake_outlined,
     Icons.book_outlined,
     Icons.groups_outlined,
     Icons.art_track_outlined
   ];

   int selectedIndex = 0 ;
   String eventTitle = '' ;
   String eventDescription = '' ;
   String formatDate = '' ;
   String formatTime = '' ;
   int eventCategoryIndex = 0 ;
   DateTime? selectedEventDate ;
   TimeOfDay? selectedEventTime ;
   String selectedEventName = '' ;
   String selectedEventImage = '' ;
   var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var themProvider = Provider.of<ThemeProvider>(context);
    selectedEventName = eventNameList[selectedIndex];
    selectedEventImage = themProvider.isDarkMode ? eventDarkImagesList[selectedIndex ]
        : eventLightImagesList[selectedIndex];
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.transparentColor,
        centerTitle: true,
        title: Text('events_add_title'.tr() ,
        style: themProvider.isDarkMode ? AppStyles.medium18WhiteColor
          : AppStyles.medium18BlackColor,
        ),
        leadingWidth: context.width*0.14,
        leading: Container(
          margin: EdgeInsetsDirectional.only(
            start: context.width*0.04,
            top: context.height*0.014,
          ),
          decoration: BoxDecoration(
            color: themProvider.isDarkMode ? AppColors.darkInputColor
                : AppColors.whiteColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              width: 2,
              color: Theme.of(context).dividerColor,
            )
          ),
          child: IconButton(onPressed: () {
            Navigator.pop(context);
          },
              icon: Icon(Icons.arrow_back_ios_new_outlined ,
                color: themProvider.isDarkMode ? AppColors.whiteColor
                    : AppColors.mainLightColor,
                size: 25,
              ),)
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(
           horizontal: context.width*0.04,
           vertical: context.height*0.02
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: context.height*0.02,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      width: 2,
                      color: Theme.of(context).dividerColor
                    )
                  ),
                clipBehavior: Clip.antiAlias,
                  child: Image.asset(themProvider.isDarkMode ? eventDarkImagesList[selectedIndex]
                      :  eventLightImagesList[selectedIndex],
                    fit: BoxFit.cover,
                  ),
            
                ),
                SizedBox(
                  height: context.height*0.05,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                      itemBuilder: (context , index){
                        return InkWell(
                          onTap: () {
                            selectedIndex = index ;
                            setState(() {
            
                            });
                          },
                          child: CustomTabItem(
                              isSelected: selectedIndex == index ,
                               unSelectedColor: themProvider.isDarkMode ? AppColors.darkInputColor
                              : AppColors.whiteColor,
                               eventName: eventNameList[index] ,
                               icons: eventIconsList[index]
                          ),
                        );
                      }
                      , separatorBuilder: (context , index) {
                        return SizedBox(
                          width: context.width*0.02,
                        );
                  }
                      , itemCount: eventNameList.length
                  ),
                ),
                Text('events_input_title'.tr() ,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                CustomTextField(
                  hintText: 'events_title_placeholder'.tr(),
                  hintStyle: Theme.of(context).textTheme.bodyLarge,
                  fill: true,
                  filledColor: themProvider.isDarkMode ? AppColors.darkInputColor
                      : AppColors.whiteColor,
                  onChanged: (text) {
                    eventTitle = text ;
                  },
                  validator: (text){
                    if(text == null || text.trim().isEmpty){
                      return 'enter_title'.tr() ;
                    }
                    return null ;
                  },
                  borderColor: Theme.of(context).dividerColor,
                ),
                Text('events_input_description'.tr() ,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                CustomTextField(
                  hintText: 'events_description_placeholder'.tr(),
                  hintStyle: Theme.of(context).textTheme.bodyLarge,
                  fill: true,
                  maxLines: 6,
                  filledColor: themProvider.isDarkMode ? AppColors.darkInputColor
                      : AppColors.whiteColor,
                  onChanged: (text) {
                    eventDescription = text ;
                  },
                  validator: (text){
                    if(text == null || text.trim().isEmpty){
                      return 'enter_description'.tr() ;
                    }
                    return null ;
                  },
                  borderColor: Theme.of(context).dividerColor,
                ),
                DataOrTimeWidget(
                    icon: Icon(Icons.date_range_outlined ,
                    color: Theme.of(context).cardColor
                      )
                    , dataOrTime: 'events_date'.tr()
                    , onChooseClick: onChooseDate
                    , chooseDataOrTime: selectedEventDate == null ?
                    'events_choose_date'.tr() :
                    formatDate
                ),
                DataOrTimeWidget(
                    icon: Icon(Icons.timer_outlined,
                        color: Theme.of(context).cardColor
                    )
                    , dataOrTime: 'events_time'.tr()
                    , onChooseClick: onChooseTime
                    , chooseDataOrTime: selectedEventTime == null ?
                    'events_choose_time'.tr() :
                    formatTime
                ),
                CustomElevatedButton(
                  verticalPadding: context.height*0.015,
                  backGroundColor: Theme.of(context).cardColor,
                    onPressed: addEvent,
                    child: Text('events_add_btn'.tr(),
                      style: AppStyles.medium20WhiteColor,
                    )
                ),
                SizedBox(height: context.height*0.04,)
              ],
            ),
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

  void onChooseTime() async{
   var chooseTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
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
       }
   );

   if(chooseTime!= null){
     selectedEventTime = chooseTime ;
     formatTime = chooseTime.format(context);
     setState(() {
       
     });
   }
  }

  void addEvent() {
     if (formKey.currentState?.validate() == true){
       Event event = Event(
           eventName: selectedEventName,
           eventImage: selectedEventImage,
           eventTitle: eventTitle,
           eventCategoryIndex: selectedIndex+1,
           eventDescription: eventDescription,
           eventDate: DateTime(selectedEventDate!.year,
               selectedEventDate!.month , selectedEventDate!.day,
               selectedEventTime!.hour ,  selectedEventTime!.minute
           )
       );
       FirebaseUtils.addEventInFireStore(event)
       .then((value) {
             SnackBarUtils.showSuccessSnackBar(
               context: context,
               message: 'added_event'.tr(),
             );
         Navigator.pop(context);
       }).catchError((error){
         print('Error : ${error.toString()}');
       });
     }
  }
}