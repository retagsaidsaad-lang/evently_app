import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/providers/user_provider.dart';
import 'package:untitled1/utiles/app_styles.dart';
import 'package:untitled1/utiles/firebase_utils.dart';
import 'package:untitled1/widgets/custom_event_item.dart';
import 'package:untitled1/widgets/custom_tab_item.dart';

import '../model/event.dart';
import '../providers/theme_provider.dart';
import '../ui/event_details_screen.dart';
import '../utiles/app_colors.dart';
import '../utiles/size_utiles.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int selectedIndex = 0 ;
  List<Event> eventsList = [];
  List<Event> filterList = [] ;
  Stream<List<Event>>? stream ;




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stream =getAllEvents();
  }
  void updateStream (int index) {
    selectedIndex = index ;
    if(selectedIndex == 0 ){
       stream = getAllEvents();
    }else {
      stream = getFilterEvents();
    }
}
  @override
  Widget build(BuildContext context) {
   var userProvider = Provider.of<UserProvider>(context) ;
   var themeProvider = Provider.of<ThemeProvider>(context) ;
   List<String> eventNameList = [
     'home_category_all'.tr(),
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
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(
              horizontal: context.width*0.04,
              vertical: context.height *0.02),
          child: DefaultTabController(
            length: eventNameList.length,
            child: Column(
              spacing: context.height*0.02,
                  children: [
                    Row(
                      spacing: context.width*0.04,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('home_welcome_back'.tr() ,
                              style: Theme.of(context).textTheme.bodyLarge,),
                            Text(userProvider.currentUser?.name ?? '',
                              style: Theme.of(context).textTheme.titleMedium,)
                          ],
                        ),
                        Spacer(),
                        Icon(themeProvider.isDarkMode ? Icons.brightness_2_outlined
                            : Icons.light_mode_outlined ,
                        color: Theme.of(context).cardColor,),
                       Container(
                         padding: EdgeInsets.symmetric(
                           horizontal: context.width*0.02,
                           vertical: context.height*0.007
                         ),
                         decoration: BoxDecoration(
                           color: Theme.of(context).cardColor,
                           borderRadius: BorderRadius.circular(8),
                         ),
                         child: Text( context.locale.languageCode,
                         style: AppStyles.semi14WhiteColor,),
                       )
                      ],
                    ),
                    TabBar(
                      isScrollable: true,
                        onTap: (index) {
                          setState(() {
                            selectedIndex = index;
                          });
                          updateStream(index);
                        },
                        dividerColor: AppColors.transparentColor,
                        indicatorColor: AppColors.transparentColor,
                        labelPadding: EdgeInsets.symmetric(
                          horizontal: context.width*0.01
                        ),
                        tabAlignment: TabAlignment.start,
                        tabs: eventNameList.map((eventName){
                      return CustomTabItem(
                          isSelected: selectedIndex == eventNameList.indexOf(eventName) ,
                      unSelectedColor: themeProvider.isDarkMode ? AppColors.darkInputColor
                          : AppColors.whiteColor ,
                      eventName: eventName,
                        icons: eventIconsList[eventNameList.indexOf(eventName)]
                      );
                    }).toList()
                    ),
                    Expanded(child: StreamBuilder<List<Event>>(
                        stream: stream,
                        builder: (context, snapshot) {
                          if(snapshot.hasError){
                            return Center(child: Text(snapshot.error.toString() ,
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),);
                          }else if(snapshot.connectionState == ConnectionState.waiting){
                            return Center(child: CircularProgressIndicator(
                              color: AppColors.mainLightColor,
                            ),);
                          }else if(!snapshot.hasData || snapshot.data!.isEmpty){
                            return Center(child: Text('no_event_found'.tr() ,
                              style: Theme.of(context).textTheme.headlineMedium,),
                            );
                          }else{
                            eventsList = snapshot.data! ;
                            return eventsList.isEmpty ?
                            Center(child: Text('no_event_found'.tr() ,
                              style: Theme.of(context).textTheme.headlineMedium,),
                            ) :
                            ListView.separated(
                                itemBuilder: (context , index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => EventDetailsScreen(
                                            event: eventsList[index],
                                          ),
                                        ),
                                      );
                                    },
                                    child: CustomEventItem(event: eventsList[index],),
                                  );
                                }
                                , separatorBuilder: (context , index ) {
                              return SizedBox(height: context.height*0.02 );
                            }
                                , itemCount: eventsList.length
                            );
                          }
                          },
                    )
                    ),
                  ],
                ),
          ),
        ),
      ),
    );
  }


  Stream<List<Event>> getAllEvents () {
    Stream<QuerySnapshot<Event>> stream =  FirebaseUtils.getEventCollection()
        .orderBy('event_date')
        .snapshots();
    return stream.map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return doc.data();
      }).toList();
      },);
  }

Stream<List<Event>> getFilterEvents () {
    Stream<QuerySnapshot<Event>> stream = FirebaseUtils.getEventCollection()
        .where('event_categoryIndex' , isEqualTo: selectedIndex )
        .orderBy('event_date')
        .snapshots();
    return stream.map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return doc.data();
      }).toList();
    },);
  }
}
