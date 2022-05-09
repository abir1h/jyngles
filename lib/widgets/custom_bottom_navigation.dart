// ignore_for_file: non_constant_identifier_names, unused_field

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jyngles/screens/calendar/calender_home.dart';
import 'package:jyngles/screens/goals_debts/goals_debt_screen.dart';
import 'package:jyngles/screens/reports/reports.dart';
import '../screens/home/home_screen.dart';
import '../screens/transactions/transaction.dart';
import '../utils/colors.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const HomeScreen();
  int current_tab = 0;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        current_tab == 1
            ? Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CustomBottomNavigationBar(),
                ),
              )
            : current_tab == 2
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CustomBottomNavigationBar(),
                    ),
                  )
                : current_tab == 3
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CustomBottomNavigationBar(),
                        ),
                      )
                    : showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Confirm Exit"),
                            content:
                                const Text("Are you sure you want to exit?"),
                            actions: <Widget>[
                              TextButton(
                                child: const Text("YES"),
                                onPressed: () {
                                  exit(0);
                                },
                              ),
                              TextButton(
                                child: const Text("NO"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          );
                        },
                      );
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: PageStorage(
            child: currentScreen,
            bucket: bucket,
          ),
          bottomNavigationBar: BottomAppBar(
            color: Colors.white,
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 12,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: MaterialButton(
                      minWidth: 20,
                      onPressed: () {
                        setState(() {
                          currentScreen = const HomeScreen();
                          current_tab = 0;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          current_tab == 0
                              ? SvgPicture.asset(
                                  "assets/icons/home.svg",
                                  color: AppColors.bottomNavColor,
                                )
                              : SvgPicture.asset(
                                  "assets/icons/home.svg",
                                  color: AppColors.textcolor,
                                ),
                          Text(
                            "Home",
                            style: TextStyle(
                              fontSize: 8,
                              color: current_tab == 0
                                  ? AppColors.bottomNavColor
                                  : AppColors.textcolor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: MaterialButton(
                      minWidth: 20,
                      onPressed: () {
                        setState(() {
                          currentScreen = const Transactions();
                          current_tab = 1;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          current_tab == 1
                              ? SvgPicture.asset(
                                  "assets/icons/transaction.svg",
                                  color: AppColors.bottomNavColor,
                                )
                              : SvgPicture.asset(
                                  "assets/icons/transaction.svg",
                                  color: AppColors.textcolor,
                                ),
                          Text(
                            "Transaction",
                            style: TextStyle(
                              fontSize: 7.5,
                              color: current_tab == 1
                                  ? AppColors.bottomNavColor
                                  : AppColors.textcolor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: MaterialButton(
                      minWidth: 20,
                      onPressed: () {
                        setState(() {
                          currentScreen = const CalenderHome();
                          current_tab = 2;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          current_tab == 2
                              ? const Icon(
                                  Icons.calendar_today_outlined,
                                  color: AppColors.bottomNavColor,
                                )
                              : SvgPicture.asset(
                                  "assets/icons/calender.svg",
                                  color: AppColors.textcolor,
                                ),
                          Text(
                            "Calendar",
                            style: TextStyle(
                              fontSize: 8,
                              color: current_tab == 2
                                  ? AppColors.bottomNavColor
                                  : AppColors.textcolor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: MaterialButton(
                      minWidth: 20,
                      onPressed: () {
                        setState(() {
                          currentScreen = const GoalsDebtsScreen(
                            fromBottomNav: true,
                          );
                          current_tab = 3;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          current_tab == 3
                              ? SvgPicture.asset(
                                  "assets/icons/goal-debt.svg",
                                  color: AppColors.bottomNavColor,
                                )
                              : SvgPicture.asset(
                                  "assets/icons/goal-debt.svg",
                                  color: AppColors.textcolor,
                                ),
                          Text(
                            "Goals/Debt",
                            style: TextStyle(
                              fontSize: 8,
                              color: current_tab == 3
                                  ? AppColors.bottomNavColor
                                  : AppColors.textcolor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: MaterialButton(
                      minWidth: 20,
                      onPressed: () {
                        setState(() {
                          currentScreen = const ReportScreen();
                          current_tab = 4;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          current_tab == 4
                              ? SvgPicture.asset(
                                  "assets/icons/report.svg",
                                  color: AppColors.bottomNavColor,
                                )
                              : SvgPicture.asset(
                                  "assets/icons/report.svg",
                                  color: AppColors.textcolor,
                                ),
                          Text(
                            "Reports",
                            style: TextStyle(
                              fontSize: 8,
                              color: current_tab == 4
                                  ? AppColors.bottomNavColor
                                  : AppColors.textcolor,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
