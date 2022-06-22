import 'dart:convert';

import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jyngles/screens/transactions/transaction.dart';
import 'package:jyngles/utils/appurl.dart';
import 'package:jyngles/widgets/controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/colors.dart';

class exit_exp extends StatefulWidget {
  exit_exp({
    Key? key,
    required this.amount,
    required this.category,
    required this.desc,
    required this.id,    required this.date,

    required this.tax,
    required this.catagory_id,

  }) : super(key: key);
  final String amount;
  String category;
  final String desc;
  final String id;  final String date;

  final String tax;
  final String catagory_id;

  @override
  State<exit_exp> createState() => _exit_expState();
}

class _exit_expState extends State<exit_exp> {
  String category = 'Select Category';
  bool isInEdit = false;

  DateTime selectedDate = DateTime.now();
  var number_emp;
  Future? slide;
  Future? Expence_lsit;
  var location,income_cat,expence_catagory;
  List shots = [];
  List shots2 = [];
  var _mySelection,c_name,expence_value,expence_id,income_value,income_id,expence_selection;
  Future? myFuture,expence;
  Future get_notification() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"

    };

    var response =
    await http.get(Uri.parse(AppUrl.catagory+'expense'), headers: requestHeaders);
    if (response.statusCode == 200) {
      var userData = jsonDecode(response.body)['data'];
      print("Get Profile has Data");
      print(userData);
      print('pera');

      return userData;
    } else {
      var userData = jsonDecode(response.body)['data'];

      print("Get Profile No Data${response.body}");
      print('pera');

      return userData;
    }
  }
  Future get_expence_catagory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"

    };

    var response =
    await http.get(Uri.parse(AppUrl.catagory+'expense'), headers: requestHeaders);
    if (response.statusCode == 200) {
      var userData = jsonDecode(response.body)['data'];
      print("Get Profile has Data");
      print(userData);
      print('pera');

      return userData;
    } else {
      var userData = jsonDecode(response.body)['data'];

      print("Get Profile No Data${response.body}");
      print('pera');

      return userData;
    }
  }

  var id,val,class_id;
  TextEditingController amountController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();




  Future editExpense(String date, String amount, String category_id,String tax,
      String description) async {
    print(amount+category_id+tax+description);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"
    };
    var request = await http.MultipartRequest(
      'POST',
      Uri.parse(AppUrl.editExpense + widget.id),
    );
    request.fields.addAll({
      'date': date,
      'amount': amount,
      'category_id': category_id,
      'description': description,
      'type':tax

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
              msg: "Edited Successfully",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.white,
              textColor: Colors.black,
              fontSize: 16.0,
            );
            Navigator.push(context, MaterialPageRoute(builder: (_)=>Transactions(selected_index: 1,)));          } else {
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
        }
      });
    });
  }

  //!DELETE API

  Future deleteIncome(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"
    };

    var response = await http.get(Uri.parse(AppUrl.deleteExpense + id),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      print(response.body);
      var data = jsonDecode(response.body);
      Fluttertoast.showToast(
        msg: 'Expense Deleted Successfully',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0,
      );
      Navigator.push(context, MaterialPageRoute(builder: (_)=>Transactions(selected_index: 1,)));
    } else {
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
  final MyHomePageController? controller = Get.put(MyHomePageController());
  Future deleteExpence(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"
    };

    var response = await http.get(Uri.parse(AppUrl.deleteExpense + id),
        headers: requestHeaders);
    if (response.statusCode == 200) {
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
      Get.back();
    } else {
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

  List<bool> values = [false, false];
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2050));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;

      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.catagory_id);
    print(widget.category);
    amountController.text=widget.amount;
    descriptionController.text=widget.desc;
    c_name=widget.category;
    _mySelection='';
    selectedDate=DateTime.parse(widget.date);

    tax=widget.tax=='wants'?'Wants':widget.tax=='savings'?'Savings':'Needs';
    myFuture=get_notification();
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
            backgroundColor: AppColors.lightBlue,
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
              'Edit Expense' ,
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
                  SizedBox(height: height * 0.01),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Amount',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ],
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
                    child: SizedBox(
                      height: height * 0.04,
                      width: width * 0.7,
                      child: TextField(
                        controller: amountController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '${controller!.count.value}'+' ${widget.amount.toString()}',
                          hintStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black
                          ),
                        ),
                      ),
                    ),
                  ),
                  //!Category
                  SizedBox(height: height * 0.03),
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Date',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.02),
                  InkWell(
                    onTap: (){
                      _selectDate(context);
                    },
                    child:  Container(
                      height: height * 0.05,
                      width: width,
                      decoration: BoxDecoration(
                        color: AppColors.textFieldBackground1,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Padding(
                        padding:
                        EdgeInsets.only(left: 15,top: 7,right: 15),
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${selectedDate.toLocal()}.split('
                                  ')[0]'
                                  .split(' ')[0],
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              'Tap here',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  //!Category
                  SizedBox(height: height * 0.03),                  //!Category

                  const Text(
                    'Category',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: height * 0.015),
                  Container(
                    width: width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                        border: Border.all()),
                    child: FutureBuilder(
                        future: myFuture!,
                        builder: (context, snapshot) {

                          shots = (snapshot.data ?? []) as List;
                          return snapshot.hasData ? shots != null
                              ? Container(
                            child: new DropdownButton<String>(
                              isExpanded: true,
                              hint: _mySelection == null
                                  ? Text(" Select Catagory",
                                  style: TextStyle(
                                      fontWeight:
                                      FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.grey))
                                  : Text(' '+c_name!,
                                  style: TextStyle(
                                      fontWeight:
                                      FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.grey)),
                              items: shots
                                  .map<
                                  DropdownMenuItem<
                                      String>>((value) =>
                              new DropdownMenuItem<String>(
                                value:
                                value["id"].toString() +
                                    "_" +
                                    value['name'],
                                child: new Text(
                                  value['name'],
                                ),
                              ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _mySelection = value;
                                  val = _mySelection!.split('_');
                                  print(val[0] + " NEw value");
                                  print(val[1] + " class value");
                                  c_name = val[1];
                                  class_id = val[1];
                                  location=class_id;
                                  income_id=val[0];

                                });
                                print(_mySelection);
                              },
                              underline:
                              DropdownButtonHideUnderline(
                                  child: Container()),
                            ),
                          )
                              : Center(child:CircularProgressIndicator())
                              : Container();
                        }),
                  ),

                  SizedBox(height: height * 0.015),

                  //!Description
                  const Text(
                    'Description',
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
                    height: height * 0.2,
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: AppColors.lightBlue,
                    ),
                    child:TextField(
                      controller: descriptionController,
                      maxLines: 8,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '${widget.desc}',
                        hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black
                        ),
                      ),
                    ),
                  ),                  SizedBox(height: height * 0.015),

                  Container(
                    width: width,
                    height: height * 0.05,
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.03),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: AppColors.textFieldBackground1,
                    ),
                    child: DropdownButton<String>(
                      value: tax,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      isExpanded: true,
                      style: const TextStyle(color: Colors.black),
                      onChanged: (String? newValue) {
                        setState(() {
                          tax = newValue!;
                        });
                      },
                      items: <String>[
                        'Select Tax Information',
                        'Needs',

                        'Wants',
                        'Savings'

                      ].map<DropdownMenuItem<String>>(
                              (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                    ),
                  ),


                  SizedBox(height: height * 0.08),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     //!Delete
                  //     InkWell(
                  //       onTap: () {
                  //         // showDialog(
                  //         //   context: context,
                  //         //   builder: (context) => CustomDialog(
                  //         //     height: height,
                  //         //     width: width,
                  //         //     mgs: 'Update',
                  //         //   ),
                  //         // );
                  //     editIncome(
                  //           '${selectedDate.toLocal()}.split('
                  //               ')[0]'
                  //               .split(' ')[0],
                  //           amountController.text.isEmpty
                  //               ? widget.amount
                  //               : amountController.text,
                  //           income_id,
                  //           widget.category,
                  //           descriptionController.text.isEmpty
                  //               ? widget.desc
                  //               : descriptionController.text,
                  //         );
                  //       },
                  //       child: Container(
                  //         height: height * 0.065,
                  //         width: width * 0.3,
                  //         decoration: BoxDecoration(
                  //           color: const Color(0xff0EDAF5),
                  //           borderRadius: BorderRadius.circular(2),
                  //         ),
                  //         child: const Center(
                  //           child: Text(
                  //             'Submit',
                  //             style: TextStyle(
                  //               fontSize: 18,
                  //               fontWeight: FontWeight.w500,
                  //               color: Color(0xff063A98),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //!Delete
                      InkWell(
                        onTap: () {
                          // widget.isIncome
                          //     ? deleteIncome(widget.id)
                          //     : deleteExpence(widget.id);

                          // showDialog(
                          //   context: context,
                          //   builder: (context) => CustomDialog(
                          //     height: height,
                          //     width: width,
                          //     mgs: 'Delete',
                          //   ),
                          // );
                          deleteIncome(widget.id.toString());
                        },
                        child: Container(
                          height: height * 0.065,
                          width: width * 0.3,
                          decoration: BoxDecoration(
                            color: const Color(0xff0EDAF5),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: const Center(
                            child: Text(
                              'Delete',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff063A98),
                              ),
                            ),
                          ),
                        ),
                      ),

                      //!Edit
                      submitted==false?InkWell(
                        onTap: () {
                          // showDialog(
                          //   context: context,
                          //   builder: (context) => CustomDialog(
                          //       height: height, width: width, mgs: 'Edit'),
                          // );
                          print('tapped');
                          setState(() {
                            submitted=true;
                          });
                          editExpense('${selectedDate.toLocal()}.split('
                              ')[0]'
                              .split(' ')[0],
                            amountController.text,
                            income_id!=null?  income_id.toString():widget.catagory_id,
                            tax=='Select Tax Information'?widget.tax=='Wants'?'wants':'needs':tax=='Wants'?'wants':tax=='Savings'?'savings':'needs',

                            descriptionController.text,
                          );
                        },
                        child: Container(
                          height: height * 0.065,
                          width: width * 0.3,
                          decoration: BoxDecoration(
                            color: const Color(0xff0EDAF5),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: const Center(
                            child: Text(
                              'Update',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff063A98),
                              ),
                            ),
                          ),
                        ),
                      ):CircularProgressIndicator(),
                    ],
                  ),


                  SizedBox(height: height * 0.08),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }  String tax = 'Select Tax Information';
  bool submitted=false;

}

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    Key? key,
    required this.height,
    required this.width,
    required this.mgs,
  }) : super(key: key);

  final double height;
  final double width;
  final String mgs;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: SizedBox(
        height: height * 0.35,
        width: width * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 33,
              backgroundColor: Color(0xff0DAEC4),
              child: Icon(
                Icons.done,
                color: Colors.white,
                size: 35,
              ),
            ),
            SizedBox(height: height * 0.03),
            const Text(
              'Are You Sure? ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: height * 0.02),
            Text(
              'Do you really want to $mgs?',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: height * 0.06,
                    width: width * 0.3,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: AppColors.textColor2),
                    ),
                    child: Center(
                      child: Text(
                        'Cancel'.toUpperCase(),
                        style: const TextStyle(
                          color: AppColors.textColor2,
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                    showDialog(
                      context: context,
                      builder: (context) =>
                          CustomDialog2(height: height, width: width),
                    );
                  },
                  child: Container(
                    height: height * 0.06,
                    width: width * 0.3,
                    decoration: const BoxDecoration(
                      color: AppColors.textColor2,
                    ),
                    child: Center(
                      child: Text(
                        mgs.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CustomDialog2 extends StatelessWidget {
  const CustomDialog2({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: SizedBox(
        height: height * 0.35,
        width: width * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 33,
              backgroundColor: Color(0xff0DAEC4),
              child: Icon(
                Icons.done,
                color: Colors.white,
                size: 35,
              ),
            ),
            SizedBox(height: height * 0.03),
            const Text(
              'Done',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
