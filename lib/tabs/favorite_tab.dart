import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/utiles/app_colors.dart';
import 'package:untitled1/utiles/firebase_utils.dart';
import 'package:untitled1/widgets/custom_text_field.dart';
import '../model/event.dart';
import '../providers/theme_provider.dart';
import '../utiles/size_utiles.dart';
import '../widgets/custom_event_item.dart';

class FavoriteTab extends StatefulWidget {
  const FavoriteTab({super.key});

  @override
  State<FavoriteTab> createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> {
  Stream<List<Event>>? stream ;
  List<Event> favoriteList = [] ;
  String searchQuery = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stream = getAllFavoriteEvents();
  }

  @override
  Widget build(BuildContext context) {
    var themProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body:  SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: context.width*0.02,
            vertical: context.height*0.02
        ),
        child: Column(
          spacing: context.height*0.02,
          children: [
            CustomTextField(
              hintText: 'home_search_placeholder'.tr(),
              hintStyle: Theme.of(context).textTheme.bodyLarge,
              suffixIcon: Icon(Icons.search,
                color: Theme.of(context).cardColor,
              ),
              filledColor: themProvider.isDarkMode ? AppColors.darkInputColor
                  : AppColors.whiteColor,
              fill: true,
              borderColor: Theme.of(context).dividerColor,
              onChanged: (text) {
                setState(() {
                  searchQuery = text;
                });
              },
            ),
        Expanded(child: StreamBuilder<List<Event>>(
        stream: stream,
        builder: (context, snapshot) {
          if(snapshot.hasError){
            return Center(
              child: Text(snapshot.error.toString() ,
              style: Theme.of(context).textTheme.headlineMedium,
            ),);
          }else if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(
              color: AppColors.mainLightColor,
            ),);
          }else if(!snapshot.hasData || snapshot.data!.isEmpty){
            return Center(child: Text('no_favorite_found'.tr() ,
              style: Theme.of(context).textTheme.headlineMedium,),
            );
          }else{
            favoriteList = snapshot.data! ;
            var filterList = favoriteList.where((event) {
              return event.eventTitle.toLowerCase().contains(searchQuery.toLowerCase());
              },).toList();
            return filterList.isEmpty ?
            Center(child: Text('no_event_found'.tr() ,
              style: Theme.of(context).textTheme.headlineMedium,),
            ) :
            ListView.separated(
                itemBuilder: (context , index) {
                  return CustomEventItem(event: filterList[index],);
                }
                , separatorBuilder: (context , index ) {
              return SizedBox(height: context.height*0.02 );
            }
                , itemCount: filterList.length
            );
          }
        },
        )
        ),
          ],
        ),
      ),
      ),
    );
  }

  Stream<List<Event>> getAllFavoriteEvents () {
   return FirebaseUtils.getEventCollection()
        .where('is_favourite' , isEqualTo:true )
        .orderBy('event_date')
        .snapshots()
        .map((querySnapshot) {
          return querySnapshot.docs.map((doc) {
            return doc.data();
          },).toList();
        });
  }
}
