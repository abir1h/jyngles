import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jyngles/screens/home/chart_screen.dart';
import 'package:jyngles/utils/colors.dart';
import '../../widgets/chat_icon_button.dart';
import '../../widgets/drawer.dart';
import '../../widgets/notification_icon_button.dart';
import '../../widgets/pie_chart.dart';
import '../transactions/add_transactions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: const Text(
          'HOME',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.lightBlue,
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
      ),
      drawer: CustomDrawer(height: height, width: width),
      body: SingleChildScrollView(
        // physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            //!Dark bg

            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: (height * 0.5) - AppBar().preferredSize.height,
                  width: width,
                  color: AppColors.chatBackgroundColor,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width / 15),
                    child: Column(
                      children: [
                        SizedBox(height: height * 0.03),
                        //!Needs, Wants, Savings

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: height * 0.012,
                                  width: width * 0.05,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    color: AppColors.red,
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.025,
                                ),
                                const Text(
                                  'Needs',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  height: height * 0.012,
                                  width: width * 0.05,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    color: AppColors.blue,
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.025,
                                ),
                                const Text(
                                  'Wants',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  height: height * 0.012,
                                  width: width * 0.05,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    color: AppColors.yellow2,
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.025,
                                ),
                                const Text(
                                  'Savings',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        //!Pie Chart
                        InkWell(
                          onDoubleTap: () {
                            Get.to(
                              const ChartScreen(),
                              transition: Transition.zoom,
                            );
                          },
                          child: const PieChartSample2(),
                        ),
                      ],
                    ),
                  ),
                ),

                //!Indicators
                Positioned(
                  top: height * 0.1,
                  left: width * 0.75,
                  child: Container(
                    height: height * 0.0255,
                    width: width * 0.091,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: AppColors.chatBackgroundColor,
                      border: Border.all(color: AppColors.red),
                    ),
                    child: const Center(
                      child: Text(
                        '50%',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: height * 0.3,
                  left: width * 0.7,
                  child: Container(
                    height: height * 0.0255,
                    width: width * 0.091,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: AppColors.chatBackgroundColor,
                      border: Border.all(color: AppColors.blue),
                    ),
                    child: const Center(
                      child: Text(
                        '30%',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: height * 0.3,
                  left: width * 0.2,
                  child: Container(
                    height: height * 0.0255,
                    width: width * 0.091,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: AppColors.chatBackgroundColor,
                      border: Border.all(color: AppColors.yellow2),
                    ),
                    child: const Center(
                      child: Text(
                        '20%',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),

                //!3 boxes within a container
                Positioned(
                  top: height * 0.37,
                  left: width * 0.05,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                    height: height * 0.12,
                    width: width * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 0), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomContainer(
                          height: height,
                          width: width,
                          color: AppColors.container1,
                          image: 'assets/icons/in.png',
                          text: 'Total Income',
                        ),
                        CustomContainer(
                          height: height,
                          width: width,
                          color: AppColors.container2,
                          image: 'assets/icons/out.png',
                          text: 'Total Expense',
                        ),
                        CustomContainer(
                          height: height,
                          width: width,
                          color: AppColors.container3,
                          image: 'assets/icons/piggibank.png',
                          text: 'Total Savings',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.08),
            //!Down portion
            Stack(
              children: [
                //?Worling well
                Positioned(
                  top: height * 0.18,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => const AddTransactions(
                            tabbarIndex: 0,
                          ));
                    },
                    child: SvgPicture.asset(
                      'assets/icons/plus.svg',
                    ),
                  ),
                ),

                //!Recent Transactions
                Padding(
                  padding:
                      EdgeInsets.only(left: width * 0.11, right: width * 0.11),
                  child: Column(
                    children: [
                      Row(
                        children: const [
                          Text(
                            'Recent Transactions',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),

                      //!Shopping
                      SizedBox(height: height * 0.02),

                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                        'assets/icons/shopping.svg'),
                                    SizedBox(width: width * 0.01),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Shopping',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        SizedBox(height: height * 0.002),
                                        const Text(
                                          '15 March 2020, 8:45 PM',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const Text(
                                  '-\$120',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),

                            //!Medicine
                            SizedBox(height: height * 0.02),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                        'assets/icons/medicine.svg'),
                                    SizedBox(width: width * 0.01),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Medicine',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        SizedBox(height: height * 0.002),
                                        const Text(
                                          '13 March 2020, 11:10 PM',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const Text(
                                  '-\$89.50',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),

                            SizedBox(height: height * 0.02),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset('assets/icons/sports.svg'),
                                    SizedBox(width: width * 0.01),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Shopping',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        SizedBox(height: height * 0.002),
                                        const Text(
                                          '9 March 2020, 1:22 PM',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const Text(
                                  '-\$99.90',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
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
      height: height * 0.1,
      width: width * 0.27,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: width * 0.023, top: height * 0.015),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.005),
            Image.asset(image),
            SizedBox(height: height * 0.007),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
