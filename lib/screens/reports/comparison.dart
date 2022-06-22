import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jyngles/widgets/controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../utils/colors.dart';

class Comparison extends StatefulWidget {
   Comparison({
    Key? key,
    required this.monthOrYear,
    required this.fromMonth,
    required this.fromYear,
    required this.toMonth,
    required this.toYear,
    required this.income1,
    required this.expence1,
    required this.saving1,
    required this.income2,
    required this.expence2,
    required this.saving3,
    required this.income,
    required this.expense,

  }) : super(key: key);
  final String monthOrYear;
  final String fromYear;
  final String toYear;
  final String fromMonth;
  final String toMonth;
  final String income1;
  final String expence1;
  final String saving1;
  final String income2;
  final String expence2;
  final String saving3;
  final List income;
  final List expense;

  @override
  State<Comparison> createState() => _ComparisonState();
}

class _ComparisonState extends State<Comparison> {
  DateTime selectedDate = DateTime.now();
  final MyHomePageController? controller = Get.put(MyHomePageController());

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
  List<_SalesData> data = [
    _SalesData('Sat', 35),
    _SalesData('Sun', 28),
    _SalesData('Mon', 34),
    _SalesData('Wed', 32),
    _SalesData('Thu', 40),
    _SalesData('Fri', 55)
  ];
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
          appBar: AppBar(
            backgroundColor: controller!.change_color.value,
            elevation: 0,
            centerTitle: true,
            leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            title: Text(
              widget.monthOrYear == 'Monthly Comparison' ? 'Monthly' : 'Yearly',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.02),
                  //!Year/Month
                  widget.monthOrYear == 'Monthly Comparison'
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: width / 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.fromMonth,
                                style: const TextStyle(
                                  color: Color(0xff07E588),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Container(
                                height: 1,
                                width: width * 0.3,
                                color: Colors.white,
                              ),
                              Text(
                                widget.toMonth,
                                style: const TextStyle(
                                  color: Color(0xff0CA2BE),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(horizontal: width / 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.fromYear,
                                style: const TextStyle(
                                  color: Color(0xff07E588),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Container(
                                height: 1,
                                width: width * 0.3,
                                color: Colors.white,
                              ),
                              Text(
                                widget.toYear,
                                style: const TextStyle(
                                  color: Color(0xff0CA2BE),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),

                  //!Comparison Tiles
                  SizedBox(height: height * 0.04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //!1st box
                      Container(
                        height: height * 0.27,
                        width: width * 0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xffC4FFE6),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/salary.png'),
                                SizedBox(width: width * 0.01),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                     Text(
                                      widget.income1,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: height * 0.005),
                                    const Text(
                                      'Total Income',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/dollar.png'),
                                SizedBox(width: width * 0.01),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                     Text(
                                      widget.expence1,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: height * 0.005),
                                    const Text(
                                      'Total Expense',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/pb.png'),
                                SizedBox(width: width * 0.01),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                     Text(
                                      widget.saving1,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: height * 0.005),
                                    const Text(
                                      'Total Savings',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),

                      //!2nd box
                      Container(
                        height: height * 0.27,
                        width: width * 0.40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xffBAF4FF),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/salary.png'),
                                SizedBox(width: width * 0.01),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                     Text(
                                  widget.income2,

                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: height * 0.005),
                                    const Text(
                                      'Total Income',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/dollar.png'),
                                SizedBox(width: width * 0.01),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                     Text(
                                      widget.expence2,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: height * 0.005),
                                    const Text(
                                      'Total Expense',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/pb.png'),
                                SizedBox(width: width * 0.01),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                     Text(
                                  widget.saving3,

                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: height * 0.005),
                                    const Text(
                                      'Total Savings',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),

                  //!Text
                  SizedBox(height: height * 0.04),

                   Text(
                     widget.monthOrYear == 'Monthly Comparison'?'All Month Summary':'All Year Summary',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  type==1?SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      // Chart title
                      // Enable legend

                      legend: Legend(),
                      // Enable tooltip
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <ChartSeries>[
                        LineSeries(xAxisName: 'Month',
                            dataSource: widget.income,
                            xValueMapper: (datum, index) => widget.income[index]['data_month'],
                            yValueMapper: (datum, index) => widget.income[index]['sum'],
                            name: '',

                            // Enable data label
                            dataLabelSettings: DataLabelSettings(isVisible: true,color: Colors.white))
                      ]):SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      // Chart title
                      // Enable legend

                      legend: Legend(),
                      // Enable tooltip
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <ChartSeries>[
                        LineSeries(xAxisName: 'Month',
                            dataSource: widget.expense,
                            xValueMapper: (datum, index) => widget.expense[index]['data_month'],
                            yValueMapper: (datum, index) => widget.expense[index]['sum'],
                            name: '',


                            // Enable data label
                            dataLabelSettings: DataLabelSettings(isVisible: true,color: Colors.white))
                      ]),
                  Row(
                    children: [
                      InkWell(
                        onTap: (){
                          setState(() {
                            type=1;
                          });
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: type==1?Colors.green:Colors.white
                                ),
                              ),
                            ),Text("Income",style: TextStyle(color: Colors.white),)
                          ],
                        ),
                      ),  InkWell(
                        onTap: (){
                          setState(() {
                            type=2;
                          });
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    color: type==2?Colors.green:Colors.white
                                ),
                              ),
                            ),Text("Expense",style: TextStyle(color: Colors.white),)
                          ],
                        ),
                      ),
                    ],
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
var type=1;
}
class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}