import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:jyngles/screens/profile/edit_profile.dart';
import 'package:jyngles/screens/profile/add_user.dart';
import 'package:jyngles/screens/profile/view_user.dart';
import 'package:jyngles/utils/appurl.dart';
import 'package:jyngles/utils/colors.dart';
import 'package:jyngles/widgets/controller.dart';
import 'package:jyngles/widgets/custom_bottom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
class privacy_policy extends StatefulWidget {

  @override
  State<privacy_policy> createState() => _privacy_policyState();
}

class _privacy_policyState extends State<privacy_policy>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  var selected = false;
  final MyHomePageController? controller = Get.put(MyHomePageController());

  TabController? _controller;
  @override
  void initState() {
    super.initState();
    myfuture=getpost();

    _controller = TabController(length: 1, vsync: this);
  }

  String? _userName;
  String? _userEmail;
  String? _userPhone;

  Future getInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString('username');
    String? email = prefs.getString('email');
    String? phone = prefs.getString('phone');
    setState(() {
      _userName = name;
      _userEmail = email;
      _userPhone = phone;
    });
  }
  Future? myfuture;
  var type,doctor;
  Future getpost() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"
    };

    var response = await http.get(Uri.parse(AppUrl.policy), headers: requestHeaders);
    if (response.statusCode == 200) {
      print('Get post collected' + response.body);
      var userData1 = jsonDecode(response.body)['data'];

      return userData1;
    } else {
      print("post have no Data${response.body}");
    }
  }
  var point;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(
          const CustomBottomNavigationBar(),
          transition: Transition.rightToLeft,
        );
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          // drawer: CustomDrawer(height: height, width: width),
          key: _key,
          appBar: AppBar(
            elevation: 2,
            backgroundColor:controller!.change_color.value,
            title: const Text(
              'Privacy Policy',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            leading: GestureDetector(
              onTap: () {
                // _key.currentState!.openDrawer();
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    constraints: BoxConstraints(),
                    child: FutureBuilder(
                        future: myfuture,
                        builder: (_, AsyncSnapshot snapshot) {
                          print(snapshot.data);
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return  Column(
                                children: [
                                  SizedBox(height: height/2,),
                                  Center(child:CircularProgressIndicator()),
                                ],
                              );
                            default:
                              if (snapshot.hasError) {
                                Text('Error: ${snapshot.error}');
                              } else {
                                return snapshot.hasData
                                    ?                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(snapshot.data['policy'],style: TextStyle(
                                          color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16
                                        ),),
                                      )

                                    ],
                                  ),
                                )





                                    : Column(
                                  children: [
                                    SizedBox(height: height/3,),
                                    CircularProgressIndicator(),
                                    Center(child: Text('Checking Network Connectivity!1',style: TextStyle(fontWeight: FontWeight.bold),)),

                                  ],
                                );
                              }
                          }
                          return CircularProgressIndicator();
                        })),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
