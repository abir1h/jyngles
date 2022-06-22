import 'dart:async';
import 'dart:convert';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';
import 'package:jyngles/screens/fingerprint.dart';
import 'package:jyngles/screens/splash/launch_screen.dart';
import 'package:jyngles/widgets/controller.dart';



import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';


import 'package:http/http.dart' as http;

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  // static final String onesignal_app_id='185cc73a-68a3-4868-9058-5633f5aeb0a4';
  var token;
  // Future<void> initPlatformState(){  OneSignal.shared.setAppId(onesignal_app_id);
  // }
  final MyHomePageController? controller = Get.put(MyHomePageController());

  void isLoogedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    language = prefs.getString('lan');
    print(token);
    print(language);
  }
 var language;
  var check_main;


  var update;
  @override
  void initState() {
    // TODO: implement initState
    isLoogedIn();
    // initPlatformState();

    // Timer(Duration(milliseconds: 200),()=> );
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  startTimer() async {
    var duration = Duration(milliseconds: 2000);
    return new Timer(duration, route);
  }

  // Naviagate() {
  //   Navigator.pushReplacement(
  //       context, MaterialPageRoute(builder: (_) => MainHome()));
  // }
  //
  NaviagateFinger() {
    Get.to(()=>finger());
  }

  Navigate_start() {
    Get.to(()=>LaunchScreen());

  }
  // Naviagatemain2() {
  //   Navigator.pushReplacement(
  //       context, MaterialPageRoute(builder: (_) => maintanence()));
  // }no() {
  //   Navigator.pushReplacement(
  //       context, MaterialPageRoute(builder: (_) => no_internet()));
  // }

  var main = 3;
  var version;
  // getversion()async{
  //   var packageInfo = await PackageInfo.fromPlatform();
  //   String appName = packageInfo.appName;
  //   String packageName = packageInfo.packageName;
  //   String version_ = packageInfo.version;
  //   String buildNumber = packageInfo.buildNumber;
  //   setState(() {
  //     version=version_;
  //   });
  //
  // }

  route() async{
    // var packageInfo = await PackageInfo.fromPlatform();
    // String appName = packageInfo.appName;
    // String packageName = packageInfo.packageName;
    // String version_ = packageInfo.version;
    // String buildNumber = packageInfo.buildNumber;
    // print('New');
    // print(version_);
    // setState(() {
    //   version=version_;
    // });
    // update!=null?update!=version?Naviagatemain():check_main == 1
    //     ? Naviagatemain2()
    //     :
    // token == null
    //     ? Naviagatelogin()
    //     : Naviagate(): Naviagate()  ;
    language!= null && token!=null?NaviagateFinger():token!=null&&language==null?NaviagateFinger():Navigate_start();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 3.5,
              ),
              Center(
                  child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Image.asset("assets/images/splash.jpg"),

                          SizedBox(
                            height: MediaQuery.of(context).size.height / 25,
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(left: 140.0, right: 140),
                            child: LinearProgressIndicator(
                              backgroundColor: Colors.black54,
                              valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        ],
                      ))),
            ],
          ),
        ));
  }
}
