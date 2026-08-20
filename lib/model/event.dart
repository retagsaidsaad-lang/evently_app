import 'package:cloud_firestore/cloud_firestore.dart';

class Event {

  static const String collectionName = 'Events';

  String eventId;
  String eventName;
  String eventImage;
  String eventTitle;
  String eventDescription;
  DateTime eventDate;
  bool isFavourite;
  int eventCategoryIndex ;

  Event({
    this.eventId = '',
    required this.eventName, required this.eventImage,
    required this.eventTitle, required this.eventDescription,
    required this.eventDate, this.isFavourite = false ,
    required this.eventCategoryIndex
  });



  Event. fromJson(Map<String , dynamic> data) : this (
    eventId: data['event_id'] as String,
    eventName: data['event_name'] as String,
    eventImage: data['event_image'] as String,
    eventTitle: data['event_title'] as String,
    eventCategoryIndex: data['event_categoryIndex'] as int ,
    eventDescription: data['event_description'] as String,
    eventDate: (data['event_date' ] as Timestamp).toDate(),
    isFavourite: data['is_favourite'] as bool,

  );

  Map<String , dynamic> toJson() {
    return {
      'event_id' : eventId ,
      'event_name' : eventName ,
      'event_image' : eventImage ,
      'event_title' : eventTitle ,
      'event_categoryIndex': eventCategoryIndex,
      'event_description' : eventDescription ,
      'event_date' : eventDate ,
      'is_favourite' : isFavourite ,
    };
  }
}