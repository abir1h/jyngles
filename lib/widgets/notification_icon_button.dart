import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jyngles/screens/notifications/notification_screen.dart';
import 'package:jyngles/utils/appurl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;

import 'controller.dart';

class NotificationIconButton extends StatefulWidget {
  const NotificationIconButton({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  State<NotificationIconButton> createState() => _NotificationIconButtonState();
}

class _NotificationIconButtonState extends State<NotificationIconButton> {
  Future? getincome;
  final MyHomePageController? controller = Get.put(MyHomePageController());

  Future getIncome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"
    };

    var response =
    await http.get(Uri.parse(AppUrl.notification), headers: requestHeaders);
    if (response.statusCode == 200) {
      print('Get post collected' + response.body);
      var userData1 = jsonDecode(response.body)['data']['dataInAppCount'];
      print(userData1);
      setState((){
        data=userData1;
      });
      return userData1;
    } else {
      print("post have no Data${response.body}");
      var userData1 = jsonDecode(response.body)['data']['dataInAppPush'];
      return userData1;
    }
  }
  Future addDebts(

      ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"
    };
    var request = await http.MultipartRequest(
      'POST',
      Uri.parse(AppUrl.notification_post),
    );
    request.fields.addAll({

    });

    request.headers.addAll(requestHeaders);

    request.send().then((result) async {
      http.Response.fromStream(result).then((response) {
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);

          if (data['status_code'] == 200) {
            var data = jsonDecode(response.body);
            print(data);
            print('response.body ' + data.toString());

        } else {
            print("post have no Data${response.body}");
            var data = jsonDecode(response.body);

          }
          return response.body;
        }
      });
    });
  }
  var data;
  @override
  void initState() {
    super.initState();
    getincome = getIncome();
  }  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        addDebts();
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => NotificationScreen()));
      },
      child: Padding(
        padding: EdgeInsets.only(right: widget.width / 20),
        child:  Padding(
          padding: const EdgeInsets.all(8.0),
          child: Badge(
            badgeContent: Text(data!=null?data.toString():'0',style: TextStyle( color:controller!.change_color.value==Color(0xffFF2400)?Colors.white:Colors.black,),),
            child: Icon(Icons.notifications,color:controller!.change_color.value==Color(0xffFF2400)?Colors.white:Colors.black,),
          ),
        )
      ),
    );
  }
}
