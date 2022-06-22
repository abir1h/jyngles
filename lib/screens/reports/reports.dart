import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jyngles/screens/reports/Monthly.dart';
import 'package:jyngles/screens/reports/comparison.dart';
import 'package:jyngles/screens/reports/yearly.dart';
import 'package:jyngles/utils/appurl.dart';
import 'package:jyngles/widgets/controller.dart';
import 'package:jyngles/widgets/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../utils/colors.dart';
import '../../widgets/chat_icon_button.dart';
import '../../widgets/notification_icon_button.dart';
import 'package:http/http.dart'as http;
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
  var month_from,month_to;
  final MyHomePageController? controller = Get.put(MyHomePageController());

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }
var i1,e1,s1,i2,e2,s2;
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  Monthly_() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"
    };

    var response =
    await http.get(Uri.parse(AppUrl.compare+month_from.toString()+'/'+month_to.toString()+'/'+'m'), headers: requestHeaders);
    if (response.statusCode == 200) {
      print('Get post collected' + response.body);
      var userData1 = jsonDecode(response.body)['data'];
      var userData2 = jsonDecode(response.body)['dataCompare'];
      print(userData1);
      setState(() {
        i1=userData1['income'];
        e1=userData1['expense'];
        s1=userData1['saving'];

        i2=userData2['incomeCompare'];
        e2=userData2['expenseCompare'];
        s2=userData2['savingCompare'];


      });
      Get.to(
        Comparison(
          monthOrYear: category,
          fromMonth: month1,
          fromYear: year1,
          toMonth: month2,
          toYear: year2,
          expence1: e1.toString(),
          expence2: e2.toString(),
          income1: i1.toString(),
          income2: i2.toString(),
          saving1: s1.toString(),
          saving3: s2.toString(),
          expense: jsonDecode(response.body)['expenseCurve'],
          income: jsonDecode(response.body)['incomeCurve'],
        ),
        transition: Transition.rightToLeft,
      );
      return userData1;
    } else {
      print("post have no Data${response.body}");
      var userData1 = jsonDecode(response.body)['data'];
      return userData1;
    }
  }
  yearly_() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"
    };

    var response =
    await http.get(Uri.parse(AppUrl.compare+year1+'/'+year1+'/'+'y'), headers: requestHeaders);
    if (response.statusCode == 200) {
      print('Get post collected' + response.body);
      var userData1 = jsonDecode(response.body)['data'];
      var userData2 = jsonDecode(response.body)['dataCompare'];
      print(userData1);
      setState(() {
        i1=userData1['income'];
        e1=userData1['expense'];
        s1=userData1['saving'];

        i2=userData1['incomeCompare'];
        e2=userData1['expenseCompare'];
        s2=userData1['savingCompare'];


      });
      Get.to(
        Comparison(
          monthOrYear: category,
          fromMonth: month1,
          fromYear: year1,
          toMonth: month2,
          toYear: year2,
          expence1: e1.toString(),
          expence2: e2.toString(),
          income1: i1.toString(),
          income2: i2.toString(),
          saving1: s1.toString(),
          saving3: s2.toString(),
          expense: jsonDecode(response.body)['expenseCurve'],
          income: jsonDecode(response.body)['incomeCurve'],
        ),
        transition: Transition.rightToLeft,
      );
      return userData1;
    } else {
      print("post have no Data${response.body}");
      var userData1 = jsonDecode(response.body)['data'];
      return userData1;
    }
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
            backgroundColor: controller!.change_color.value,
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
Monthly(),
                      //!Yearly page
yearly(),
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
                                        'Vs',
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
                                                  month_from=month1=='January'?1:month1=='February'?2:month1=='March'?3:month1=='April'?4:month1=='May'?5:month1=='June'?
                                                  6:month1=='July'?7:month1=='August'?8:month1=='September'?9:month1=='October'?10:month1=='November'?11:12;
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
                                        'Vs',
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
                                                  month_to=month2=='January'?1:month2=='February'?2:month2=='March'?3:month2=='April'?4:month2=='May'?5:month2=='June'?
                                                  6:month2=='July'?7:month2=='August'?8:month2=='September'?9:month2=='October'?10:month2=='November'?11:12;
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
                                  category=='Yearly Comparison'?yearly_():Monthly_();
                                  print(month_from);
                                  print(month_to);

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
                            ),
                            // SfCartesianChart(
                            //     primaryXAxis: CategoryAxis(),
                            //     // Chart title
                            //     // Enable legend
                            //
                            //     legend: Legend(),
                            //     // Enable tooltip
                            //     tooltipBehavior: TooltipBehavior(enable: true),
                            //     series: <ChartSeries>[
                            //       LineSeries(xAxisName: 'Month',
                            //           dataSource: data,
                            //           xValueMapper: (datum, index) => data[index]['m'],
                            //           yValueMapper: (datum, index) => data[index]['r'],
                            //           name: '',
                            //
                            //           // Enable data label
                            //           dataLabelSettings: DataLabelSettings(isVisible: true))
                            //     ]),

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
  }  List data = [
    {'m':4,'r':95},
    {'m':5,'r':4933},
    {'m':6,'r':295},
    {'m':7,'r':4595},
  ]; List data2= [
    {'m':3,'r':3},
    {'m':3,'r':554},
    {'m':6,'r':452},
    {'m':7,'r':455},
  ];
  List x=[1,3,45,56,565,65,78,768.87878];
  List y=[1,4,5,6,7,8,9];
}
class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
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
