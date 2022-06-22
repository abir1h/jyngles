import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jyngles/utils/appurl.dart';
import 'package:jyngles/widgets/controller.dart';
import 'package:jyngles/widgets/custom_bottom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/colors.dart';
import 'package:http/http.dart'as http;

import 'calender_hostory.dart';
class calendar_edit extends StatefulWidget {
  final String title,time_,ammount,date,id;
  const calendar_edit({Key? key,required this.title,required this.time_,required this.ammount,required this.date,required this.id}) : super(key: key);

  @override
  State<calendar_edit> createState() => _calendar_editState();
}

class _calendar_editState extends State<calendar_edit> {
  DateTime selectedDate = DateTime.now();
  bool               submitted=false;final MyHomePageController? controller = Get.put(MyHomePageController());
  TextEditingController ammount=TextEditingController();
  TextEditingController title=TextEditingController();
  Future Delete_calender() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"
    };
    var request = await http.MultipartRequest(
      'POST',
      Uri.parse(AppUrl.calader_delete + widget.id),
    );
    request.fields.addAll({

    });

    request.headers.addAll(requestHeaders);

    request.send().then((result) async {
      http.Response.fromStream(result).then((response) {
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);

          if (data['status_code'] == 200) {
            var data = jsonDecode(response.body);
            print(data);
            print('response.body ' + data.toString());

            Fluttertoast.showToast(
              msg: "Deleted Successfully",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.white,
              textColor: Colors.black,
              fontSize: 16.0,
            );
            Get.to(()=>CustomBottomNavigationBar());
          } else {
            print("post have no Data${response.body}");
            var data = jsonDecode(response.body);
            Fluttertoast.showToast(
              msg: data['message'],
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
          return response.body;
        }
      });
    });
  }
  Future deleteIncome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"
    };

    var response = await http.get(Uri.parse(AppUrl.calader_delete + widget.id),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      print(response.body);
      var data = jsonDecode(response.body);
      Fluttertoast.showToast(
        msg:"Deleted Successfully",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0,
      );
      setState(() {
        deleted=false;
      });
      Navigator.push(context, MaterialPageRoute(builder: (_)=>CustomBottomNavigationBar()));        } else {  setState(() {
      deleted=false;
    });
      print(response.body);
      var data = jsonDecode(response.body);
      Fluttertoast.showToast(
        msg: data['message'],
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0,
      );
    }
  }
bool deleted=false;

  Future editExpense(String dateae) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"
    };
    var request = await http.MultipartRequest(
      'POST',
      Uri.parse(AppUrl.calender_post_edit+widget.id),
    );
    request.fields.addAll({
      'time':time,
      'date': dateae,
      'amount':ammount.text,
      'title':title.text,



    });

    request.headers.addAll(requestHeaders);

    request.send().then((result) async {
      http.Response.fromStream(result).then((response) {
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);

          if (data['status_code'] == 200) {
            setState(() {
              submitted=false;
            });
            var data = jsonDecode(response.body);
            print(data);
            print('response.body ' + data.toString());

            Fluttertoast.showToast(
              msg: "Updated Successfully",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.white,
              textColor: Colors.black,
              fontSize: 16.0,
            );
            Navigator.push(context, MaterialPageRoute(builder: (_)=>calender_history()));          } else {
            setState(() {
              submitted=false;
            });
            print("post have no Data${response.body}");
            var data = jsonDecode(response.body);
            Fluttertoast.showToast(
              msg: data['message'],
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
          return response.body;
        }else{
          print("post have no Data${response.body}");

        }
      });
    });
  }


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
  TimeOfDay selectedTime = TimeOfDay.now();
  String time=DateFormat.Hms().format(DateTime.now());
  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,

    );
    if(timeOfDay != null && timeOfDay != selectedTime)
    {
      setState(() {
        selectedTime = timeOfDay;
        print(selectedTime.hour);
        print(selectedTime.minute);
        final now = new DateTime.now();

        time=DateFormat.Hms().format(DateTime(now.year, now.month, now.day, selectedTime.hour, selectedTime.minute));
        // time=DateFormat.Hms().format(DateTime.parse(selectedTime.toString()));
      });
    }
  }
  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm();
    print(format.format(dt));
    //"6:00 AM"
    return format.format(dt);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    time=widget.time_;
    ammount.text=widget.ammount;
    title.text=widget.title;

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
            title: const Text(
              'Add Bill',
              style: TextStyle(
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
                  SizedBox(height: height * 0.08),

                  //!Time
                  const Text(
                    'Time',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: height * 0.015),
                  InkWell(

                    child: Container(
                      padding:
                      const EdgeInsets.only(left: 6, right: 6, bottom: 4),
                      height: height * 0.05,
                      width: width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: AppColors.lightBlue,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: height * 0.04,
                            width: width * 0.7,
                            child: InkWell(onTap: (){
                              _selectTime(context);
                            },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(time.toString()),
                                )
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.015),

                  //!Date
                  const Text(
                    'Date',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: height * 0.015),
                  Container(
                    padding:
                    const EdgeInsets.only(left: 6, right: 6, bottom: 4),
                    height: height * 0.05,
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: AppColors.lightBlue,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: height * 0.04,
                          width: width * 0.7,
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText:
                              widget.date!=null?widget.date:'${selectedDate.toLocal()}.split(' ')[0]'.split(' ')[0],
                              hintStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.disabledTextColor,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _selectDate(context);
                          },
                          child: const Icon(
                            Icons.calendar_today_outlined,
                            color: AppColors.iconColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.015),

                  //!Amount
                  const Text(
                    'Amount',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: height * 0.015),
                  Container(
                    padding:
                    const EdgeInsets.only(left: 6, right: 6, bottom: 4),
                    height: height * 0.05,
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: AppColors.lightBlue,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: height * 0.04,
                          width: width * 0.7,
                          child:  TextField(
                            controller: ammount,                                      keyboardType: TextInputType.number,

                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '${controller!.count.value}'+' 0.00',
                              hintStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.disabledTextColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.015),

                  //!title
                  const Text(
                    'Title',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: height * 0.015),
                  Container(
                    padding:
                    const EdgeInsets.only(left: 6, right: 6, bottom: 4),
                    height: height * 0.05,
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: AppColors.lightBlue,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: height * 0.04,
                          width: width * 0.7,
                          child:  TextField(
                            controller: title,

                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter Your Title',
                              hintStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.disabledTextColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      deleted==false?GestureDetector(
                        onTap: () {
                          // showDialog(
                          //   context: context,
                          //   builder: (context) =>
                          //       CustomDialog(height: height, width: width),
                          // );
                          setState(() {
                            deleted=false;
                          });
                          Delete_calender();
                        },
                        child: Container(
                          height: height * 0.065,
                          width: width * 0.3,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(
                              color: AppColors.textColor2,
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Delete',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textColor2,
                              ),
                            ),
                          ),
                        ),
                      ):CircularProgressIndicator(),
                      GestureDetector(
                        onTap: () {
                          // showDialog(
                          //   context: context,
                          //   builder: (context) =>
                          //       CustomDialog2(height: height, width: width),
                          // );
                          print('tapped');
                          editExpense(DateFormat('yyyy-MM-dd').format(selectedDate).toString());

                        },
                        child: Container(
                          height: height * 0.065,
                          width: width * 0.3,
                          decoration: BoxDecoration(
                            color: AppColors.containerButton,
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: const Center(
                            child: Text(
                              'Update',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
//
// class CustomDialog extends StatelessWidget {
//   const CustomDialog({
//     Key? key,
//     required this.height,
//     required this.width,
//   }) : super(key: key);
//
//   final double height;
//   final double width;
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12.0),
//       ),
//       child: SizedBox(
//         height: height * 0.35,
//         width: width * 0.8,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const CircleAvatar(
//               radius: 33,
//               backgroundColor: Color(0xff0DAEcalendar_edit),
//               child: Icon(
//                 Icons.close,
//                 color: Colors.white,
//                 size: 35,
//               ),
//             ),
//             SizedBox(height: height * 0.03),
//             const Text(
//               'Are You Sure? ',
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 24,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             SizedBox(height: height * 0.03),
//             const Text(
//               'Do you really want to delete?',
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 12,
//                 fontWeight: FontWeight.w300,
//               ),
//             ),
//             SizedBox(height: height * 0.03),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     Get.back();
//                   },
//                   child: Container(
//                     height: height * 0.06,
//                     width: width * 0.3,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       border: Border.all(color: AppColors.textColor2),
//                     ),
//                     child: const Center(
//                       child: Text(
//                         'Cancel',
//                         style: TextStyle(
//                           color: AppColors.textColor2,
//                           fontSize: 22,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     // Get.back();
//                     // showDialog(
//                     //   context: context,
//                     //   builder: (context) =>
//                     //       CustomDialog2(height: height, width: width),
//                     // );
//                   },
//                   child: Container(
//                     height: height * 0.06,
//                     width: width * 0.3,
//                     decoration: const BoxDecoration(
//                       color: AppColors.textColor2,
//                     ),
//                     child: const Center(
//                       child: Text(
//                         'Delete',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 22,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class CustomDialog2 extends StatelessWidget {
//   const CustomDialog2({
//     Key? key,
//     required this.height,
//     required this.width,
//   }) : super(key: key);
//
//   final double height;
//   final double width;
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12.0),
//       ),
//       child: SizedBox(
//         height: height * 0.35,
//         width: width * 0.8,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const CircleAvatar(
//               radius: 33,
//               backgroundColor: Color(0xff0DAEcalendar_edit),
//               child: Icon(
//                 Icons.done,
//                 color: Colors.white,
//                 size: 35,
//               ),
//             ),
//             SizedBox(height: height * 0.03),
//             const Text(
//               'Done',
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 24,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
