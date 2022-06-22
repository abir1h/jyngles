import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jyngles/screens/home/chart_screen.dart';
import 'package:jyngles/utils/appurl.dart';
import 'package:jyngles/utils/colors.dart';
import 'package:http/http.dart' as http;
import 'package:jyngles/widgets/controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class yearly extends StatefulWidget {
  @override
  _yearlyState createState() => _yearlyState();
}

class _yearlyState extends State<yearly> {
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
  Future getpost(String Date,String type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"
    };

    var response = await http.get(Uri.parse(AppUrl.monthly+Date+'/'+type),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      print('Get post collected' + response.body);
      var userData1 = jsonDecode(response.body)['data'];

      setState(() {
        getdata=true;
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


  @override
  void initState() {
    DateTime now = DateTime.now();
    _year = now.year;
    _month = now.month;
    // TODO: implement initState
    super.initState();
    myfuture=getpost('0','y');
  }
  TextEditingController tax_percent=TextEditingController();
  bool edit=false;
  String date_pick=            DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  Widget build(BuildContext context) {    final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;
  return SafeArea(
    child: Scaffold(
      backgroundColor: AppColors.sidebarColor1,
      body: SingleChildScrollView(
          child:   getdata==true?
          Column(
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

                                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: height * 0.03),
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
                                                myfuture=getpost(date_pick, 'y');

                                              });
                                            },
                                            pickerModel: CustomMonthPicker(

                                                minTime: DateTime(2012, 1, 1),
                                                maxTime: DateTime(2050, 1, 1),
                                                currentTime: DateTime.now()
                                            ),
                                          );
                                        },
                                        child:  Center(
                                          child: Text(
                                            date_pick,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
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
                                              text: '\$'+snapshot.data['income'].toString()+'\nTotal Income',
                                            ),
                                            CustomContainer(
                                              height: height,
                                              width: width,
                                              color: AppColors.container2,
                                              image: 'assets/icons/out.png',
                                              text: '\$'+snapshot.data['expense'].toString()+'\nTotal Expense',
                                            ),
                                            CustomContainer(
                                              height: height,
                                              width: width,
                                              color: AppColors.container3,
                                              image: 'assets/icons/piggibank.png',
                                              text: '\$'+snapshot.data['saving'].toString()+'\nTotal Savings',
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Text("Income",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                      ),
                                      snapshot.data['categoryIncome'].length>0?ListView.builder(
                                          itemCount:snapshot.data['categoryIncome'].length,
                                          shrinkWrap:true,
                                          itemBuilder: (_,index){
                                            return    snapshot.data['categoryIncome'][index]['cat_income_sum']!=0?   Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Image.network(AppUrl.picurl+ snapshot.data['categoryIncome'][index]['image'],height: 40,width: 40,),

                                                      SizedBox(width: width * 0.01),
                                                      Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            snapshot.data['categoryIncome'][index]['name'],
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight: FontWeight.w400,
                                                                color: Colors.white

                                                            ),
                                                          ),
                                                          SizedBox(height: height * 0.002),
                                                          // Text(
                                                          //   DateFormat('yyyy-MM-dd').format(DateTime.parse(snapshot.data['categoryIncome'][index]['created_at'])).toString()
                                                          //   ,
                                                          //   style: TextStyle(
                                                          //       fontSize: 12,
                                                          //       fontWeight: FontWeight.w400,
                                                          //       color: Colors.white
                                                          //   ),
                                                          // ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [

                                                      Obx(() => Text('${controller!.count.value}',
                                                        style: TextStyle(fontSize:16,                                                        color: Colors.white
                                                        ),),),
                                                      Text(
                                                        ' '+ snapshot.data['categoryIncome'][index]['cat_income_sum'].toString(),
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.w400,                                                        color: Colors.white

                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ):Container()
                                            ;
                                          }):Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Center(child: Text("No tranaction yet",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Text("Expences",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                      ),
                                      snapshot.data['categoryExpense'].length>0?ListView.builder(
                                          itemCount:snapshot.data['categoryExpense'].length,
                                          shrinkWrap:true,
                                          itemBuilder: (_,index){
                                            return   snapshot.data['categoryExpense'][index]['cat_expense_sum']!=0?   Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Image.network(AppUrl.picurl+ snapshot.data['categoryExpense'][index]['image'],height: 40,width: 40,),

                                                      SizedBox(width: width * 0.01),
                                                      Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            snapshot.data['categoryExpense'][index]['name'],
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight: FontWeight.w400,
                                                                color: Colors.white

                                                            ),
                                                          ),
                                                          SizedBox(height: height * 0.002),
                                                          // Text(
                                                          //   DateFormat('yyyy-MM-dd').format(DateTime.parse(snapshot.data['categoryExpense'][index]['created_at'])).toString()
                                                          //   ,
                                                          //   style: TextStyle(
                                                          //       fontSize: 12,
                                                          //       fontWeight: FontWeight.w400,
                                                          //       color: Colors.white
                                                          //   ),
                                                          // ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [

                                                      Obx(() => Text('${controller!.count.value}',
                                                        style: TextStyle(fontSize:16,                                                        color: Colors.white
                                                        ),),),
                                                      Text(
                                                        ' '+ snapshot.data['categoryExpense'][index]['cat_expense_sum'].toString(),
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.w400,                                                        color: Colors.white

                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ):Container()
                                            ;
                                          }):Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Center(child: Text("No tranaction yet",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),)),
                                      ),
                                  SizedBox(height: height * 0.1),
                                  snapshot.data['income']==0 && snapshot.data['expense']==0 && snapshot.data['saving']==0 ?Text(
                                    'You have not entered any data for the selected month',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ):Container(),


                                ],
                              )




                       ] ): Column(
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
          ):Center(
            child: Column(
              children: [
                Center(child: CircularProgressIndicator(),)
              ],
            ),
          )
      ),

    ),
  );
  }
}
class CustomMonthPicker extends DatePickerModel {
  CustomMonthPicker({required DateTime currentTime, required DateTime minTime, required DateTime maxTime,
  }) : super( minTime: minTime, maxTime:
  maxTime, currentTime: currentTime);

  @override
  List<int> layoutProportions() {
    return [1, 1, 0];
  }
}