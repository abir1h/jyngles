import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jyngles/utils/colors.dart';
import '../../widgets/drawer.dart';
import '../../widgets/pie_chart.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({Key? key}) : super(key: key);

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _key,
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Chart',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.lightBlue,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      drawer: CustomDrawer(height: height, width: width),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(right: width / 15, top: height * 0.025),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: height * 0.04,
                    width: width * 0.35,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Text(
                          '1 Jan - 2022',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Icon(
                          Icons.calendar_today,
                          color: Color(0xff0B6A8C),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: width / 15,
                bottom: height * 0.025,
                right: width / 15,
                top: height * 0.025,
              ),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 226, 226, 226)
                            .withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset:
                            const Offset(0, 0), // changes position of shadow
                      ),
                    ]),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: height * 0.35,
                      width: width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Colors.white,
                      ),
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
                                        color: Colors.black,
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
                                        color: Colors.black,
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
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            //!Pie Chart
                            const PieChartSample2(bgcolor: Colors.white),
                          ],
                        ),
                      ),
                    ),

                    //!Indicators
                    Positioned(
                      top: height * 0.1,
                      left: width * 0.68,
                      child: Container(
                        height: height * 0.0255,
                        width: width * 0.091,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Colors.white,
                          border: Border.all(color: AppColors.red),
                        ),
                        child: const Center(
                          child: Text(
                            '50%',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: height * 0.25,
                      left: width * 0.68,
                      child: Container(
                        height: height * 0.0255,
                        width: width * 0.091,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Colors.white,
                          border: Border.all(color: AppColors.blue),
                        ),
                        child: const Center(
                          child: Text(
                            '30%',
                            style: TextStyle(
                              color: Colors.black,
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
                          color: Colors.white,
                          border: Border.all(color: AppColors.yellow2),
                        ),
                        child: const Center(
                          child: Text(
                            '20%',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // SizedBox(height: height * 0.06),
            //!Down portion
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 15),
              child: Column(
                children: [
                  //!Needs
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset('assets/icons/needs.svg'),
                          const Text(
                            'Needs',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const Text(
                        '\$23,23',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 1,
                    width: width,
                    color: Colors.grey,
                  ),

                  //!Wants
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset('assets/icons/wants.svg'),
                          const Text(
                            'Wants',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const Text(
                        '\$22,23',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 1,
                    width: width,
                    color: Colors.grey,
                  ),

                  //!Savings
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/icons/savings.png',
                            color: Colors.red,
                          ),
                          const Text(
                            'Savings',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const Text(
                        '\$18,33',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 1,
                    width: width,
                    color: Colors.grey,
                  ),

                  //!Total
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset('assets/icons/total.svg'),
                          const Text(
                            'Total',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const Text(
                        '\$26,23',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
