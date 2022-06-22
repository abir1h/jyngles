import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:jyngles/screens/reports/Monthly.dart';
import 'package:jyngles/utils/appurl.dart';
import 'package:jyngles/utils/colors.dart';
import 'package:jyngles/widgets/controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/drawer.dart';
import '../../widgets/pie_chart.dart';
import 'package:http/http.dart'as http;

class ChartScreen extends StatefulWidget {
  const ChartScreen({Key? key}) : super(key: key);

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  String _datetime = '';
  int _year = 2018;
  int _month = 11;
  final MyHomePageController? controller = Get.put(MyHomePageController());
  String _lang = 'en';
  String _format = 'yyyy-mm';
  bool _showTitleActions = true;
  // Future withdraw(String percentage) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? token = prefs.getString('token');
  //
  //   Map<String, String> requestHeaders = {
  //     'Accept': 'application/json',
  //     'authorization': "Bearer $token"
  //   };
  //   var request = await http.MultipartRequest(
  //     'POST',
  //     Uri.parse(AppUrl.taxt_post),
  //   );
  //   request.fields.addAll({
  //
  //     'tax':percentage
  //
  //   });
  //
  //
  //   request.headers.addAll(requestHeaders);
  //
  //   request.send().then((result) async {
  //     http.Response.fromStream(result).then((response) {
  //       if (response.statusCode == 200) {
  //
  //
  //         setState(() {
  //           myfuture=getpost();
  //
  //         });
  //         Fluttertoast.showToast(
  //             msg: "Tax information updated Succesfully",
  //             toastLength: Toast.LENGTH_LONG,
  //             gravity: ToastGravity.BOTTOM,
  //             timeInSecForIosWeb: 1,
  //             backgroundColor: Colors.green,
  //             textColor: Colors.white,
  //             fontSize: 16.0);
  //
  //
  //       }
  //       else {
  //         setState(() {
  //           edit = false;
  //         });
  //         print("Fail! ");
  //         print(response.body.toString());
  //         print(response.statusCode.toString());
  //         Fluttertoast.showToast(
  //             msg: "Error Occured",
  //             toastLength: Toast.LENGTH_LONG,
  //             gravity: ToastGravity.BOTTOM,
  //             timeInSecForIosWeb: 1,
  //             backgroundColor: Colors.red,
  //             textColor: Colors.white,
  //             fontSize: 16.0);
  //         return response.body;
  //       }
  //     });
  //   });
  // }
  bool getdata=false;
  Future getpost(String Date,) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"
    };

    var response = await http.get(Uri.parse(AppUrl.chart+Date),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      print('Get post collected' + response.body);
      var userData1 = jsonDecode(response.body)['data'];

      setState(() {
        getdata=true;
        total=userData1['needToBe']+userData1['savingToBe']+userData1['wantToBe'];
      });
      return userData1;
    } else {
      print("post have no Data${response.body}");
    }
  }  DateTime? _selected;
  String? date_Time; DateTime selectedDate = DateTime.now();
  TimeOfDay currentTime = TimeOfDay.now();
  Future<void> selectDate(BuildContext context) async {
    showDatePicker(

      context: context,

      initialDate: DateTime.now(),
      firstDate: DateTime(1930),
      lastDate: DateTime(2025),
    ).then(
          (date) {
        setState(
              () {
            selectedDate = date!;
            String formattedDate =
            DateFormat('yyyy-MM-dd').format(selectedDate);
            print(formattedDate);
          },
        );
      },
    );
  }

  Future? myfuture;
var total;

  @override
  void initState() {
    DateTime now = DateTime.now();
    _year = now.year;
    _month = now.month;
    // TODO: implement initState
    super.initState();
    myfuture=getpost('0');
  }
  TextEditingController tax_percent=TextEditingController();
  bool edit=false;
  String date_pick=            DateFormat('yyyy-MM-dd').format(DateTime.now());
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
                                ?
                            Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: width / 15, top: height * 0.025),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          InkWell(
                                            onTap:(){
                                              DatePicker.showPicker(context, showTitleActions: true,
                                                onChanged: (date) {
                                                  print('change $date in time zone ' +
                                                      date.timeZoneOffset.inHours.toString());
                                                  setState(() {
                                                    date_pick=            DateFormat('yyyy-MM-dd').format(date);


                                                  });
                                                }, onConfirm: (date) {
                                                  print('confirm $date');
                                                  setState(() {
                                                    date_pick=            DateFormat('yyyy-MM-dd').format(date);
                                                    print(date_pick);
                                                    myfuture=getpost(date_pick,);

                                                  });
                                                },
                                                pickerModel: CustomMonthPicker(

                                                    minTime: DateTime(2012, 1, 1),
                                                    maxTime: DateTime(2050, 1, 1),
                                                    currentTime: DateTime.now()
                                                ),
                                              );
                                            },
                                            child: Container(
                                              height: height * 0.04,
                                              width: width * 0.35,
                                              decoration: BoxDecoration(
                                                border: Border.all(color: Colors.black),
                                                borderRadius: BorderRadius.circular(4),
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children:  [
                                                  Text(
                                                    date_pick,
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
                                               Text(
                                                 '${controller!.count.value}'+ snapshot.data['needToBe'].toString(),
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
                                               Text(
                                                 '${controller!.count.value}'+  snapshot.data['wantToBe'].toString(),
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
                                                    color: AppColors.yellow2
                                                  ),
                                                   Text(
                                                    'Savings',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                               Text(
                                                 '${controller!.count.value}'+     snapshot.data['savingToBe'].toString(),
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
                                               Text(
                                                 '${controller!.count.value}'+   total.toStringAsFixed(1).toString(),
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


                              ],
                            )




                                : Column(
                              children: [
                                SizedBox(height: height/3,),
                                CircularProgressIndicator(),
                                Center(child: Text('',style: TextStyle(fontWeight: FontWeight.bold),)),

                              ],
                            );
                          }
                      }
                      return CircularProgressIndicator();
                    })),

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
