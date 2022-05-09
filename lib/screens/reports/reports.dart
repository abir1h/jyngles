import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jyngles/screens/reports/comparison.dart';
import 'package:jyngles/widgets/drawer.dart';

import '../../utils/colors.dart';
import '../../widgets/chat_icon_button.dart';
import '../../widgets/notification_icon_button.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String category = 'Monthly Comparison';
  String month1 = 'January';
  String month2 = 'January';
  String year1 = '2020';
  String year2 = '2020';

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 41, 68, 121),
              AppColors.chatBackgroundColor,
              AppColors.chatBackgroundColor,
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          key: _key,
          drawer: CustomDrawer(height: height, width: width),
          appBar: AppBar(
            backgroundColor: AppColors.lightBlue,
            elevation: 2,
            title: Text(
              'Reports'.toUpperCase(),
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
            leading: GestureDetector(
              onTap: () {
                _key.currentState!.openDrawer();
              },
              child: const Icon(
                Icons.sort,
                color: Colors.black,
              ),
            ),
            actions: [
              ChatIconButton(width: width),
              NotificationIconButton(width: width),
            ],
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: AppColors.lightBlue,
                  child: TabBar(
                    controller: _tabController,
                    isScrollable: false,
                    indicator: const UnderlineTabIndicator(
                      borderSide: BorderSide(
                        width: 5.0,
                        color: AppColors.tabbarindicatorColor,
                      ),
                    ),
                    tabs: [
                      SizedBox(
                        height: height * 0.05,
                        width: width * 0.4,
                        child: const Center(
                          child: Text(
                            'Monthly',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                        width: width * 0.4,
                        child: const Center(
                          child: Text(
                            'Yearly',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                        width: width * 0.4,
                        child: const Center(
                          child: Text(
                            'Comparison',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //Main Body
                SizedBox(
                  height: height,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      //!Monthly Page
                      Column(
                        children: [
                          SizedBox(height: height * 0.03),
                          const Text(
                            'April 2022',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: height * 0.03),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width / 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomContainer(
                                  height: height,
                                  width: width,
                                  color: AppColors.container1,
                                  image: 'assets/icons/in.png',
                                  text: '\$7000.00\nTotal Income',
                                ),
                                CustomContainer(
                                  height: height,
                                  width: width,
                                  color: AppColors.container2,
                                  image: 'assets/icons/out.png',
                                  text: '\$0.00\nTotal Expense',
                                ),
                                CustomContainer(
                                  height: height,
                                  width: width,
                                  color: AppColors.container3,
                                  image: 'assets/icons/piggibank.png',
                                  text: '\$4000.00\nTotal Savings',
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: height * 0.1),
                          const Text(
                            'You have not entered any data for the selected month',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),

                      //!Yearly page
                      Column(
                        children: [
                          SizedBox(height: height * 0.03),
                          const Text(
                            '2022',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: height * 0.03),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width / 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomContainer(
                                  height: height,
                                  width: width,
                                  color: AppColors.container1,
                                  image: 'assets/icons/in.png',
                                  text: '\$14000.00\nTotal Income',
                                ),
                                CustomContainer(
                                  height: height,
                                  width: width,
                                  color: AppColors.container2,
                                  image: 'assets/icons/out.png',
                                  text: '\$1000.00\nTotal Expense',
                                ),
                                CustomContainer(
                                  height: height,
                                  width: width,
                                  color: AppColors.container3,
                                  image: 'assets/icons/piggibank.png',
                                  text: '\$13000.00\nTotal Savings',
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: height * 0.1),
                          const Text(
                            'You have not entered any data for the selected year',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),

                      //!Comparison page
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: width / 15),
                        child: Column(
                          children: [
                            SizedBox(height: height * 0.05),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                DropdownButton<String>(
                                  elevation: 0,
                                  value: category,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  // isExpanded: true,
                                  style: const TextStyle(color: Colors.black),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      category = newValue!;
                                    });
                                  },
                                  items: <String>[
                                    'Monthly Comparison',
                                    'Yearly Comparison',
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                            SizedBox(height: height * 0.06),
                            //!Months
                            category == 'Yearly Comparison'
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        color: AppColors.lightBlue,
                                        height: height * 0.06,
                                        width: width * 0.4,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            DropdownButton<String>(
                                              elevation: 0,
                                              value: year1,
                                              icon: const Icon(
                                                  Icons.keyboard_arrow_down),
                                              // isExpanded: true,
                                              style: const TextStyle(
                                                  color: Colors.black),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  year1 = newValue!;
                                                });
                                              },
                                              items: <String>[
                                                '2020',
                                                '2021',
                                                '2022',
                                                '2023',
                                                '2024',
                                                '2025',
                                                '2026',
                                                '2027',
                                                '2028',
                                                '2029',
                                                '2030',
                                                '2031',
                                                '2032',
                                                '2033',
                                                '2034',
                                                '2035',
                                                '2036',
                                                '2037',
                                                '2038',
                                                '2039',
                                                '2040',
                                                '2041',
                                                '2042',
                                                '2043',
                                                '2044',
                                                '2045',
                                                '2046',
                                                '2047',
                                                '2048',
                                                '2049',
                                                '2050',
                                              ].map<DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Text(
                                        'To',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Container(
                                        color: AppColors.lightBlue,
                                        height: height * 0.06,
                                        width: width * 0.4,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            DropdownButton<String>(
                                              elevation: 0,
                                              value: year2,
                                              icon: const Icon(
                                                  Icons.keyboard_arrow_down),
                                              // isExpanded: true,
                                              style: const TextStyle(
                                                  color: Colors.black),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  year2 = newValue!;
                                                });
                                              },
                                              items: <String>[
                                                '2020',
                                                '2021',
                                                '2022',
                                                '2023',
                                                '2024',
                                                '2025',
                                                '2026',
                                                '2027',
                                                '2028',
                                                '2029',
                                                '2030',
                                                '2031',
                                                '2032',
                                                '2033',
                                                '2034',
                                                '2035',
                                                '2036',
                                                '2037',
                                                '2038',
                                                '2039',
                                                '2040',
                                                '2041',
                                                '2042',
                                                '2043',
                                                '2044',
                                                '2045',
                                                '2046',
                                                '2047',
                                                '2048',
                                                '2049',
                                                '2050',
                                              ].map<DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        color: AppColors.lightBlue,
                                        height: height * 0.06,
                                        width: width * 0.4,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            DropdownButton<String>(
                                              elevation: 0,
                                              value: month1,
                                              icon: const Icon(
                                                  Icons.keyboard_arrow_down),
                                              // isExpanded: true,
                                              style: const TextStyle(
                                                  color: Colors.black),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  month1 = newValue!;
                                                });
                                              },
                                              items: <String>[
                                                'January',
                                                'February',
                                                'March',
                                                'April',
                                                'May',
                                                'June',
                                                'July',
                                                'August',
                                                'September',
                                                'October',
                                                'November',
                                                'December',
                                              ].map<DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Text(
                                        'To',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Container(
                                        color: AppColors.lightBlue,
                                        height: height * 0.06,
                                        width: width * 0.4,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            DropdownButton<String>(
                                              elevation: 0,
                                              value: month2,
                                              icon: const Icon(
                                                  Icons.keyboard_arrow_down),
                                              // isExpanded: true,
                                              style: const TextStyle(
                                                  color: Colors.black),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  month2 = newValue!;
                                                });
                                              },
                                              items: <String>[
                                                'January',
                                                'February',
                                                'March',
                                                'April',
                                                'May',
                                                'June',
                                                'July',
                                                'August',
                                                'September',
                                                'October',
                                                'November',
                                                'December',
                                              ].map<DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                            SizedBox(height: height * 0.06),
                            SizedBox(
                              width: width * 0.3,
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.to(
                                    Comparison(
                                      monthOrYear: category,
                                      fromMonth: month1,
                                      fromYear: year1,
                                      toMonth: month2,
                                      toYear: year2,
                                    ),
                                    transition: Transition.rightToLeft,
                                  );
                                },
                                child: const Text(
                                  'Compare',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: AppColors.buttonColorBlue2,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    Key? key,
    required this.height,
    required this.width,
    required this.color,
    required this.image,
    required this.text,
  }) : super(key: key);

  final double height;
  final double width;
  final Color color;
  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.115,
      width: width * 0.26,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: width * 0.023, top: height * 0.015),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(image),
            SizedBox(height: height * 0.005),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
