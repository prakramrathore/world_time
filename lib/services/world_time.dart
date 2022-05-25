import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location; //Location name for the UI
  String time ='loading'; //The time in that location
  String flag; //url to an asset flag icon
  String url; //location url for api endpoint
  bool? isDaytime; //true or false if daytime or not

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {

    try{
      // make the request
      Response response = await get(Uri.http('worldtimeapi.org', 'api/timezone/$url'));
      Map data = jsonDecode(response.body);
      // print(data);

      //  get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(0,3);
      String offset2 = data['utc_offset'].substring(4,6);

      // print(datetime);
      // print(offset);
      // print(offset2);

      //create Datetime object
      DateTime now = DateTime.parse(datetime);
      // print(now);
      now = now.add(Duration(hours: int.parse(offset)));
      now = now.add(Duration(minutes: int.parse(offset2)));

      //set time property
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch (e){
      print('Caught error: $e');
      time = 'could not get time data';
    }

  }

}


