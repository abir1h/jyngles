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
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  var selected = false;

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

    var response = await http.get(Uri.parse(AppUrl.profiel_show), headers: requestHeaders);
    if (response.statusCode == 200) {
      print('Get post collected' + response.body);
      var userData1 = jsonDecode(response.body)['data'];
      var userData2 = jsonDecode(response.body)['dataSum'];
setState((){
  point=userData2;
});
      return userData1;
    } else {
      print("post have no Data${response.body}");
    }
  }
  var point;
  final MyHomePageController? controller = Get.put(MyHomePageController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        Get.to(
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
            backgroundColor: controller!.change_color.value,
            title: const Text(
              'Profile',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            leading: GestureDetector(
              onTap: () {
                // _key.currentState!.openDrawer();
                Get.to(
                  const CustomBottomNavigationBar(),
                  transition: Transition.rightToLeft,
                );              },
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
                                    Container(
                                      width: width,
                                      height: height * 0.23,
                                      decoration:  BoxDecoration(
                                        color:        controller!.change_color.value,

                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(50),
                                          bottomRight: Radius.circular(50),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: width / 15),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            snapshot.data['image']!=null?CircleAvatar(
                                              radius: 40,
                                              backgroundColor: Colors.white,

                                              backgroundImage:NetworkImage(AppUrl.picurl+ snapshot.data['image']!),
                                            ):CircleAvatar(
                                              radius: 40,
                                              backgroundColor: Colors.white,
                                              child: Center(
                                                child: Text(                                                 snapshot.data['username'][0].toUpperCase(),style: TextStyle(color: AppColors.sidebarColor1,fontSize: 20,fontWeight: FontWeight.bold),),
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: height/10,
                                                  width: width/3.5,
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                         snapshot.data['username'],
                                                          style: const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 20,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  children: [

                                                     Text(' Point:  '+point.toString()+'  '),
                                                    Image.asset('assets/icons/coin.png'),
                                                  ],
                                                )
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Get.to(
                                                      const AddUser(),
                                                    );
                                                  },
                                                  child: const Text('Add User'),
                                                  style: ElevatedButton.styleFrom(
                                                    primary: AppColors.buttonColorBlue,
                                                  ),
                                                ),
                                                SizedBox(height: height * 0.015),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Get.to(
                                                      const ViewUser(),
                                                      transition: Transition.rightToLeft,
                                                    );
                                                  },
                                                  child: const Text('View User'),
                                                  style: ElevatedButton.styleFrom(
                                                    primary: AppColors.buttonColorBlue,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: height * 0.05),
                                    //!NAME
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: width / 15),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Name',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(height: height * 0.02),
                                          Text(
                                            snapshot.data['username'],

                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(height: height * 0.02),
                                          Container(
                                            width: width,
                                            height: 0.5,
                                            color: Colors.black,
                                          )
                                        ],
                                      ),
                                    ), //!Email
                                    SizedBox(height: height * 0.05),
                                    //!EMAIL
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: width / 15),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Email',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(height: height * 0.02),
                                          Text(
                                            snapshot.data['email'],

                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(height: height * 0.02),
                                          Container(
                                            width: width,
                                            height: .5,
                                            color: Colors.black,
                                          )
                                        ],
                                      ),
                                    ),
                                    //!PHONE
                                    SizedBox(height: height * 0.05),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: width / 15),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Phone Number',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(height: height * 0.02),
                                          Text(
                                            snapshot.data['phone']!=null?snapshot.data['phone']:'',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(height: height * 0.02),
                                          Container(
                                            width: width,
                                            height: 0.5,
                                            color: Colors.black,
                                          )
                                        ],
                                      ),
                                    ),
                                    //! Edit Button
                                    SizedBox(height: height * 0.05),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: width / 15),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Get.to(() => EditProfileScreen(
                                            email: snapshot.data['email'],
                                            name:                                             snapshot.data['username'],

                                            phone: snapshot.data['phone'],
                                          ));
                                        },
                                        child: const Text(
                                          'Edit',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          primary: AppColors.lightBlue,
                                          side: const BorderSide(
                                            width: 0.5,
                                            color: AppColors.buttonColorBlueBorder,
                                          ),
                                        ),
                                      ),
                                    ),
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
