import 'dart:convert';

import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jyngles/utils/appurl.dart';
import 'package:jyngles/widgets/controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/colors.dart';

class EditTransaction extends StatefulWidget {
  EditTransaction({
    Key? key,
    required this.isIncome,
    required this.amount,
    required this.category,
    required this.date,
    required this.desc,
    required this.id,
  }) : super(key: key);
  final bool isIncome;
  final String amount;
  String category;
  final String desc;
  final String id;
  final String date;

  @override
  State<EditTransaction> createState() => _EditTransactionState();
}

class _EditTransactionState extends State<EditTransaction> {
  String category = 'Select Category';
  bool isInEdit = false;

  DateTime selectedDate = DateTime.now();
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
    await http.get(Uri.parse(AppUrl.catagory+'income'), headers: requestHeaders);
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

  //!Edit Transaction
  Future editIncome(String date, String amount, String category_id,
      String title, String description) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"
    };
    var request = await http.MultipartRequest(
      'POST',
      Uri.parse(AppUrl.editIncome + widget.id),
    );
    request.fields.addAll({
      'date': date,
      'amount': amount,
      'category_id': category_id,
      'title': title,
      'description': description,
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
              msg: "Edited Successfully",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.white,
              textColor: Colors.black,
              fontSize: 16.0,
            );
            Get.back();
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


  Future editExpense(String date, String amount, String category_id,
      String title, String description) async {
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
      'title': title,
      'description': description,
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
              msg: "Edited Successfully",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.white,
              textColor: Colors.black,
              fontSize: 16.0,
            );
            Get.back();
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
  final MyHomePageController? controller = Get.put(MyHomePageController());
  //!DELETE API

  Future deleteIncome(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"
    };

    var response = await http.get(Uri.parse(AppUrl.deleteIncome + id),
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

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    myFuture=get_notification();
    Expence_lsit=get_expence_catagory();
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
              widget.isIncome ? 'Edit Income' : 'Edit Expense',
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
                  //!Checkbox group
                  // Row(
                  //   children: [
                  //     const Text(
                  //       'Type: ',
                  //       style: TextStyle(
                  //         fontSize: 18,
                  //         fontWeight: FontWeight.w400,
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //     Row(
                  //       children: [
                  //         Theme(
                  //           data: Theme.of(context).copyWith(
                  //             unselectedWidgetColor: Colors.white,
                  //           ),
                  //           child: Checkbox(
                  //             value: values[0],
                  //             onChanged: (bool? value) {
                  //               setState(() {
                  //                 values[0] = value!;
                  //                 values[1] = false;
                  //               });
                  //             },
                  //           ),
                  //         ),
                  //         const Text(
                  //           'Expense',
                  //           style: TextStyle(
                  //             color: Colors.white,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     Row(
                  //       children: [
                  //         Theme(
                  //           data: Theme.of(context).copyWith(
                  //             unselectedWidgetColor: Colors.white,
                  //           ),
                  //           child: Checkbox(
                  //             value: values[1],
                  //             onChanged: (bool? value) {
                  //               setState(() {
                  //                 values[0] = false;
                  //                 values[1] = value!;
                  //               });
                  //             },
                  //           ),
                  //         ),
                  //         const Text(
                  //           'Income',
                  //           style: TextStyle(
                  //             color: Colors.white,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ],
                  // ),

                  SizedBox(height: height * 0.015),
                  //!Date of pay
                  // const Text(
                  //   'Date',
                  //   style: TextStyle(
                  //     fontSize: 18,
                  //     fontWeight: FontWeight.w400,
                  //     color: Colors.white,
                  //   ),
                  // ),
                  // SizedBox(height: height * 0.015),
                  // Container(
                  //   padding:
                  //       const EdgeInsets.only(left: 6, right: 6, bottom: 4),
                  //   height: height * 0.05,
                  //   width: width,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(2),
                  //     color: AppColors.lightBlue,
                  //   ),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       SizedBox(
                  //         height: height * 0.04,
                  //         width: width * 0.7,
                  //         child: TextField(
                  //           decoration: InputDecoration(
                  //             border: InputBorder.none,
                  //             hintText:
                  //                 '${selectedDate.toLocal()}.split(' ')[0]'
                  //                     .split(' ')[0],
                  //             hintStyle: const TextStyle(
                  //               fontSize: 14,
                  //               fontWeight: FontWeight.w400,
                  //               color: Colors.black,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //       GestureDetector(
                  //         onTap: () {
                  //           _selectDate(context);
                  //         },
                  //         child: const Icon(Icons.calendar_month),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(height: height * 0.015),

                  //!Amount
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
                      Text(
                        '${selectedDate.toLocal()}.split(' ')[0]'.split(' ')[0],
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: Color(0xffD4D4D4),
                        ),
                      )
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
                        controller: amountController,                                      keyboardType: TextInputType.number,

                        decoration: InputDecoration(
                          enabled: isInEdit ? true : false,
                          border: InputBorder.none,
                          hintText: '${controller!.count.value}'+' ${widget.amount.toString()}',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: isInEdit
                                ? Colors.black
                                : AppColors.disabledTextColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.015),
                  //!Category
                  const Text(
                    'Category',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: height * 0.015),
                  // Container(
                  //   padding:
                  //       const EdgeInsets.only(left: 6, right: 6, bottom: 4),
                  //   height: height * 0.05,
                  //   width: width,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(2),
                  //     color: AppColors.lightBlue,
                  //   ),
                  //   child: AbsorbPointer(
                  //     absorbing: isInEdit ? false : true,
                  //     child: DropdownButton<String>(
                  //       value: widget.category,
                  //       icon: const Icon(Icons.keyboard_arrow_down),
                  //       isExpanded: true,
                  //       style: TextStyle(
                  //         color:
                  //             isInEdit ? Colors.black : AppColors.disabledColor,
                  //       ),
                  //       onChanged: (String? newValue) {
                  //         setState(() {
                  //           widget.category =
                  //               newValue!; //TODO changed here. needs to recheck
                  //         });
                  //       },
                  //       items: <String>[
                  //         '${widget.category} ',
                  //         'Salary',
                  //         'Income from rent',
                  //         'Interest',
                  //         'Pension',
                  //         'Work on demand',
                  //         'Tax return',
                  //         'Coupon',
                  //       ].map<DropdownMenuItem<String>>((String value) {
                  //         return DropdownMenuItem<String>(
                  //           value: value,
                  //           child: Text(value),
                  //         );
                  //       }).toList(),
                  //     ),
                  //   ),
                  // ),
                  widget.isIncome?                                Container(
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
                  ):                                Container(
                    width: width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                        border: Border.all()),
                    child: FutureBuilder(
                        future: Expence_lsit,
                        builder: (context, snapshot) {

                          shots2 = (snapshot.data ?? []) as List;
                          return snapshot.hasData ? shots != null
                              ? Container(
                            child: new DropdownButton<String>(
                              isExpanded: true,
                              hint: expence_selection == null
                                  ? Text(" Select Catagory",
                                  style: TextStyle(
                                      fontWeight:
                                      FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.grey))
                                  : Text(' '+expence_value!,
                                  style: TextStyle(
                                      fontWeight:
                                      FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.grey)),
                              items: shots2
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
                                  expence_selection = value;
                                  val = expence_selection!.split('_');
                                  print(val[0] + " NEw value");
                                  print(val[1] + " class value");
                                  expence_id = val[0];
                                  expence_value = val[1];

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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: height * 0.04,
                          width: width * 0.7,
                          child: TextField(
                            controller: descriptionController,
                            enabled: isInEdit ? true : false,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '${widget.desc}',
                              hintStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: isInEdit
                                    ? Colors.black
                                    : AppColors.disabledTextColor,
                              ),
                            ),
                          ),
                        ),
                      ],
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
                        'Include Tax',
                        'Exclude Tax',

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
                  isInEdit
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //!Delete
                            InkWell(
                              onTap: () {
                                // showDialog(
                                //   context: context,
                                //   builder: (context) => CustomDialog(
                                //     height: height,
                                //     width: width,
                                //     mgs: 'Update',
                                //   ),
                                // );
                                widget.isIncome
                                    ? editIncome(
                                        '${selectedDate.toLocal()}.split('
                                                ')[0]'
                                            .split(' ')[0],
                                        amountController.text.isEmpty
                                            ? widget.amount
                                            : amountController.text,
                                       income_id,
                                        widget.category,
                                        descriptionController.text.isEmpty
                                            ? widget.desc
                                            : descriptionController.text,
                                      )
                                    : editExpense(
                                        '${selectedDate.toLocal()}.split('
                                                ')[0]'
                                            .split(' ')[0],
                                        amountController.text.isEmpty
                                            ? widget.amount
                                            : amountController.text,
                                        expence_id,
                                        widget.category,
                                        descriptionController.text.isEmpty
                                            ? widget.desc
                                            : descriptionController.text,
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
                                    'Submit',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff063A98),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //!Delete
                            InkWell(
                              onTap: () {
                                widget.isIncome
                                    ? deleteIncome(widget.id)
                                    : deleteExpence(widget.id);

                                // showDialog(
                                //   context: context,
                                //   builder: (context) => CustomDialog(
                                //     height: height,
                                //     width: width,
                                //     mgs: 'Delete',
                                //   ),
                                // );
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
                            InkWell(
                              onTap: () {
                                // showDialog(
                                //   context: context,
                                //   builder: (context) => CustomDialog(
                                //       height: height, width: width, mgs: 'Edit'),
                                // );
                                setState(() {
                                  isInEdit = true;
                                });
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
                                    'Edit',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff063A98),
                                    ),
                                  ),
                                ),
                              ),
                            ),
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
