import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jyngles/screens/Subscription.dart';
import 'package:jyngles/screens/calendar/add_calendar.dart';
import 'package:jyngles/screens/calendar/calender_hostory.dart';
import 'package:jyngles/screens/goals_debts/goals_debt_screen.dart';
import 'package:jyngles/screens/plaid.dart';
import 'package:jyngles/screens/profile/profile_screen.dart';
import 'package:jyngles/screens/reports/reports.dart';
import 'package:jyngles/screens/settings/privacy_policy.dart';
import 'package:jyngles/screens/sign_in_up/reset_password.dart';
import 'package:jyngles/screens/sign_in_up/signin.dart';
import 'package:jyngles/screens/tax.dart';
import 'package:jyngles/screens/transactions/transaction_history.dart';
import 'package:jyngles/utils/appurl.dart';
import 'package:jyngles/utils/colors.dart';
import 'package:jyngles/utils/google_signin.dart';
import 'package:jyngles/widgets/custom_bottom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/settings/settings.dart';
import 'package:http/http.dart'as http;

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String? _userName;
  String? image_;

  Future getInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString('username');
    String? image = prefs.getString('image');
    setState(() {
      _userName = name;
      image_ = image;
    });
    print(_userName);
    print(image_);

  }
  var image,location;
  getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    String url = "https://stgoals.com/api/auth/user-profile";
    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"
    };

    var response = await http.get(Uri.parse(AppUrl.profiel_show), headers: requestHeaders);
    if (response.statusCode == 200) {
      var userData = jsonDecode(response.body)['data'];
      setState(() {
        userData['image']!=null?image= userData['image']:'';
      });

      return userData;
    } else {
      print("Get Profile No Data${response.body}");
    }
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInfo();
    getProfile();
}
  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: Stack(
        children: [
          Container(
            color: AppColors.sidebarColor1,
            child: ListView(
              padding: EdgeInsets.only(right: widget.width * 0.08),
              children: [
                SizedBox(height: widget.height * 0.05),

                image!=null? image!='' || image!=null?CircleAvatar(
                  radius: 40,
                   backgroundColor: Colors.white,

                   backgroundImage:NetworkImage(AppUrl.picurl+image!),
                ):CircleAvatar(
                   radius: 40,
                   backgroundColor: Colors.white,
                   child: Center(
                     child: Text(_userName![0].toUpperCase(),style: TextStyle(color: AppColors.sidebarColor1,fontSize: 20,fontWeight: FontWeight.bold),),
                   ),
                 ):CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Center(
                    child: Text(_userName![0].toUpperCase(),style: TextStyle(color: AppColors.sidebarColor1,fontSize: 20,fontWeight: FontWeight.bold),),
                  ),
                ),
                SizedBox(height: widget.height * 0.02),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(width: widget.width * 0.2),
                        Text(
                          _userName ?? '',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height:15),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const ProfileScreen());
                          },
                          child: Container(
                            decoration: BoxDecoration(color: Colors.black54,borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0,right: 8,top: 2,bottom: 2),
                              child: const Text(
                                "View profile",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: widget.height * 0.02),
                ListTile(
                  onTap: () {
                    Get.to(()=>
                       CustomBottomNavigationBar(),
                      transition: Transition.rightToLeft,
                    );
                  },
                  horizontalTitleGap: .1,
                  title: Row(
                    children: [
                      SvgPicture.asset('assets/icons/home.svg'),
                      SizedBox(
                        width: widget.width * 0.03,
                      ),
                      const Text(
                        "Home",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  onTap: () {
                    Get.to(
                      () => const TransactionHistory(selected_index: 0,),
                      transition: Transition.rightToLeft,
                    );
                  },
                  horizontalTitleGap: .1,
                  title: Row(
                    children: [
                      SvgPicture.asset('assets/icons/transaction.svg'),
                      SizedBox(
                        width: widget.width * 0.03,
                      ),
                      const Text(
                        "Transaction History",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  onTap: () {
                    Get.to(
                      () =>  tax_zone(),
                      transition: Transition.rightToLeft,
                    );
                  },
                  horizontalTitleGap: .1,
                  title: Row(
                    children: [
                      SvgPicture.asset('assets/icons/transaction.svg'),
                      SizedBox(
                        width: widget.width * 0.03,
                      ),
                      const Text(
                        "Tax Information",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  onTap: () {
                    Get.to(
                      () => const calender_history(),
                      transition: Transition.rightToLeft,
                    );
                  },
                  horizontalTitleGap: .1,
                  title: Row(
                    children: [
                      const Icon(
                        Icons.calendar_today_outlined,
                        color: AppColors.tabbarIconColor2,
                      ),
                      SizedBox(
                        width: widget.width * 0.03,
                      ),
                      const Text(
                        "Calendar",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  onTap: () {
                    Get.to(() =>  subscription());
                  },
                  horizontalTitleGap: .1,
                  title: Row(
                    children: [
                      SvgPicture.asset('assets/icons/bank.svg'),
                      SizedBox(
                        width: widget.width * 0.03,
                      ),
                      const Text(
                        "Bank Account",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  onTap: () {
                    Get.to(
                      () => const GoalsDebtsScreen(fromBottomNav: false,selected_index: 0,),
                      transition: Transition.rightToLeft,
                    );
                  },
                  horizontalTitleGap: .1,
                  title: Row(
                    children: [
                      SvgPicture.asset('assets/icons/goal-debt.svg'),
                      SizedBox(
                        width: widget.width * 0.03,
                      ),
                      const Text(
                        "Goals/Debt",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  onTap: () {
                    Get.to(
                      () => const ReportScreen(),
                      transition: Transition.rightToLeft,
                    );
                  },
                  horizontalTitleGap: .1,
                  title: Row(
                    children: [
                      SvgPicture.asset('assets/icons/report.svg'),
                      SizedBox(
                        width: widget.width * 0.03,
                      ),
                      const Text(
                        "Report",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  onTap: () {
                    Get.to(
                      const ResetPassword(),
                      transition: Transition.rightToLeft,
                    );
                  },
                  horizontalTitleGap: .1,
                  title: Row(
                    children: [
                      SvgPicture.asset('assets/icons/reset_pass.svg'),
                      SizedBox(
                        width: widget.width * 0.03,
                      ),
                      const Text(
                        "Reset Password",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  onTap: () {
                    Get.to(
                      () => const SettingsPage(),
                      transition: Transition.rightToLeft,
                    );
                  },
                  horizontalTitleGap: .1,
                  title: Row(
                    children: [
                      SvgPicture.asset('assets/icons/settings.svg'),
                      SizedBox(
                        width: widget.width * 0.03,
                      ),
                      const Text(
                        "Settings",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  onTap: () {
                    Get.to(
                      () =>  privacy_policy(),
                      transition: Transition.rightToLeft,
                    );
                  },
                  horizontalTitleGap: .1,
                  title: Row(
                    children: [
                      SvgPicture.asset('assets/icons/report.svg'),
                      SizedBox(
                        width: widget.width * 0.03,
                      ),
                      const Text(
                        "Privacy Policy",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  onTap: () async{
                    if(GoogleSignIn().isSignedIn()==true){
                      await GoogleSignInAPi.logout();

                    }
                    if(  FacebookAuth.instance.isBlank==false
                    ){
                      FacebookAuth.instance.logOut().then((value) {
                        print('logout');
                      });
                    }
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.clear();



                    Get.offAll(() => const SignInPage());
                  },
                  horizontalTitleGap: .1,
                  title: Row(
                    children: [
                      SvgPicture.asset('assets/icons/logout.svg'),
                      SizedBox(
                        width: widget.width * 0.03,
                      ),
                      const Text(
                        "Logout",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
