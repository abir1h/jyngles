import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jyngles/screens/calendar/add_calendar.dart';
import 'package:jyngles/screens/goals_debts/goals_debt_screen.dart';
import 'package:jyngles/screens/profile/profile_screen.dart';
import 'package:jyngles/screens/reports/reports.dart';
import 'package:jyngles/screens/sign_in_up/reset_password.dart';
import 'package:jyngles/screens/sign_in_up/signin.dart';
import 'package:jyngles/screens/transactions/transaction_history.dart';
import 'package:jyngles/utils/colors.dart';
import 'package:jyngles/widgets/custom_bottom_navigation.dart';

import '../screens/home/home_screen.dart';
import '../screens/settings/settings.dart';
import '../screens/transactions/transaction.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Container(
            color: AppColors.sidebarColor1,
            child: ListView(
              padding: EdgeInsets.only(right: width * 0.08),
              children: [
                SizedBox(height: height * 0.05),
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/sender.jpeg'),
                ),
                SizedBox(height: height * 0.02),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(width: width * 0.2),
                        const Text(
                          "AL Mamun",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const ProfileScreen());
                          },
                          child: const Text(
                            "View profile",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: height * 0.02),
                ListTile(
                  onTap: () {
                    Get.offAll(
                      const CustomBottomNavigationBar(),
                      transition: Transition.rightToLeft,
                    );
                  },
                  horizontalTitleGap: .1,
                  title: Row(
                    children: [
                      SvgPicture.asset('assets/icons/home.svg'),
                      SizedBox(
                        width: width * 0.03,
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
                      () => const TransactionHistory(),
                      transition: Transition.rightToLeft,
                    );
                  },
                  horizontalTitleGap: .1,
                  title: Row(
                    children: [
                      SvgPicture.asset('assets/icons/transaction.svg'),
                      SizedBox(
                        width: width * 0.03,
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
                      () => const AddCalendarScreen(),
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
                        width: width * 0.03,
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
                    // Get.to(() => const ());
                  },
                  horizontalTitleGap: .1,
                  title: Row(
                    children: [
                      SvgPicture.asset('assets/icons/bank.svg'),
                      SizedBox(
                        width: width * 0.03,
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
                      () => const GoalsDebtsScreen(fromBottomNav: false),
                      transition: Transition.rightToLeft,
                    );
                  },
                  horizontalTitleGap: .1,
                  title: Row(
                    children: [
                      SvgPicture.asset('assets/icons/goal-debt.svg'),
                      SizedBox(
                        width: width * 0.03,
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
                        width: width * 0.03,
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
                        width: width * 0.03,
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
                        width: width * 0.03,
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
                    Get.offAll(() => const SignInPage());
                  },
                  horizontalTitleGap: .1,
                  title: Row(
                    children: [
                      SvgPicture.asset('assets/icons/logout.svg'),
                      SizedBox(
                        width: width * 0.03,
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
