import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jyngles/screens/calendar/add_calendar.dart';
import 'package:jyngles/screens/chat/chat_screen.dart';
import 'package:jyngles/screens/home/home_screen.dart';
import 'package:jyngles/screens/profile/edit_profile.dart';
import 'package:jyngles/screens/profile/add_user.dart';
import 'package:jyngles/screens/profile/view_user.dart';
import 'package:jyngles/utils/colors.dart';
import 'package:jyngles/widgets/custom_bottom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/conrgatulations.dart';
import '../../widgets/drawer.dart';
import '../transactions/transaction_history.dart';

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

  @override
  Widget build(BuildContext context) {
    getInfo();
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
            backgroundColor: AppColors.lightBlue,
            title: const Text(
              'Profile',
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
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: width,
                height: height * 0.23,
                decoration: const BoxDecoration(
                  color: AppColors.lightBlue,
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
                      const CircleAvatar(
                        radius: 40,
                        backgroundImage:
                            AssetImage('assets/images/profilepic.png'),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _userName ?? '',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            children: [
                              Image.asset('assets/icons/coin.png'),
                              const Text(' Point: 100'),
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
                      _userName ?? '',
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
                      _userEmail ?? '',
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
                      _userPhone ?? '',
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
                          email: _userEmail ?? '',
                          name: _userName ?? '',
                          phone: _userPhone ?? '',
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
        ),
      ),
    );
  }
}
