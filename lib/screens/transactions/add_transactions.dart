import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:jyngles/screens/transactions/transaction_history.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/appurl.dart';
import '../../utils/colors.dart';
import 'package:http/http.dart' as http;

class AddTransactions extends StatefulWidget {
  const AddTransactions({
    Key? key,
    required this.tabbarIndex,
  }) : super(key: key);
  final int tabbarIndex;

  @override
  State<AddTransactions> createState() => _AddTransactionsState();
}

class _AddTransactionsState extends State<AddTransactions>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  String category = 'Select Category';
  String category2 = 'Select Category';
  String dropdownValue = '\$';
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

  //!Controllers
  final TextEditingController _incomeDateController = TextEditingController();
  final TextEditingController _expenseDateController = TextEditingController();
  final TextEditingController _incomeAmoutController = TextEditingController();
  final TextEditingController _expenseAmountController =
      TextEditingController();
  final TextEditingController _incomeCategoryController =
      TextEditingController();
  final TextEditingController _expenseCategoryController =
      TextEditingController();
  final TextEditingController _incomeDescController = TextEditingController();
  final TextEditingController _expenseDescController = TextEditingController();

  //!Api Call starts

  //!Add Income
  Future addIncomeApi(
    String date,
    String cate,
    String desc,
    String amount,
    String category_id,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"
    };

    var request = await http.MultipartRequest(
      'POST',
      Uri.parse(AppUrl.addIncome),
    );

    var response =
        await http.get(Uri.parse(AppUrl.homePage), headers: requestHeaders);

    //TODO: Need to fix the category id
    request.fields.addAll({
      'date': date,
      'title': desc,
      'description': cate,
      'amount': amount,
      'category_id': category_id,
    });

    request.headers.addAll(requestHeaders);

    request.send().then((result) async {
      http.Response.fromStream(result).then((response) {
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          print(data);
          print('response.body ' + data.toString());
          Fluttertoast.showToast(
            msg: data['message'],
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black54,
            textColor: Colors.white,
            fontSize: 16.0,
          );

          // Navigator.push(context, MaterialPageRoute(builder: (_)=>OtpVerificationScreen(phone: phone,)));

        } else {
          var data = jsonDecode(response.body);

          print("${data['message']}");

          Fluttertoast.showToast(
            msg: 'Failed!',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          return response.body;
        }
      });
    });
  }

  //!Add Expense
  Future addExpenseApi(
    String date,
    String cate,
    String desc,
    String amount,
    String category_id,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"
    };

    var request = await http.MultipartRequest(
      'POST',
      Uri.parse(AppUrl.addExpence),
    );

    var response =
        await http.get(Uri.parse(AppUrl.homePage), headers: requestHeaders);

    //TODO: Need to fix the category id
    request.fields.addAll({
      'date': date,
      'title': desc,
      'description': cate,
      'amount': amount,
      'category_id': category_id,
    });

    request.headers.addAll(requestHeaders);

    request.send().then((result) async {
      http.Response.fromStream(result).then((response) {
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          print(data);
          print('response.body ' + data.toString());
          Fluttertoast.showToast(
            msg: data['message'],
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black54,
            textColor: Colors.white,
            fontSize: 16.0,
          );

          // Navigator.push(context, MaterialPageRoute(builder: (_)=>OtpVerificationScreen(phone: phone,)));

        } else {
          var data = jsonDecode(response.body);

          print("${data['message']}");

          Fluttertoast.showToast(
            msg: 'Failed!',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          return response.body;
        }
      });
    });
  }

  //!Api Call ends

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    _tabController.animateTo((_tabController.index + widget.tabbarIndex) % 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _expenseDescController.dispose();
    _incomeDescController.dispose();
    _expenseCategoryController.dispose();
    _incomeCategoryController.dispose();
    _expenseAmountController.dispose();
    _incomeAmoutController.dispose();
    _expenseDateController.dispose();
    _incomeDateController.dispose();
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
          appBar: AppBar(
            backgroundColor: AppColors.lightBlue,
            elevation: 2,
            title: const Text(
              'ADD TRANSACTIONS',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            leading: Container(),
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
                            'Income',
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
                            'Expense',
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
                            'Banking',
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
                      //!Imcome
                      Stack(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width / 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: height * 0.03),
                                // //!Date
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
                                //   padding: const EdgeInsets.only(
                                //       left: 6, right: 6, bottom: 4),
                                //   height: height * 0.05,
                                //   width: width,
                                //   decoration: BoxDecoration(
                                //     borderRadius: BorderRadius.circular(2),
                                //     color: AppColors.lightBlue,
                                //   ),
                                //   child: Row(
                                //     mainAxisAlignment:
                                //         MainAxisAlignment.spaceBetween,
                                //     children: [
                                //       SizedBox(
                                //         height: height * 0.04,
                                //         width: width * 0.7,
                                //         child: TextField(
                                //           controller: _incomeDateController,
                                //           decoration: InputDecoration(
                                //             border: InputBorder.none,
                                //             hintText:
                                //                 '${selectedDate.toLocal()}.split('
                                //                         ')[0]'
                                //                     .split(' ')[0],
                                //             hintStyle: const TextStyle(
                                //               fontSize: 14,
                                //               fontWeight: FontWeight.w400,
                                //               color:
                                //                   AppColors.disabledTextColor,
                                //             ),
                                //           ),
                                //         ),
                                //       ),
                                //       GestureDetector(
                                //         onTap: () {
                                //           _selectDate(context);
                                //         },
                                //         child: const Icon(
                                //           Icons.calendar_today_outlined,
                                //           color: AppColors.iconColor,
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),

                                //!Amount
                                SizedBox(height: height * 0.03),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Amount',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      '${selectedDate.toLocal()}.split('
                                              ')[0]'
                                          .split(' ')[0],
                                      style: const TextStyle(
                                        color: Color(0xffD4D4D4),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: height * 0.02),
                                Container(
                                  height: height * 0.05,
                                  width: width,
                                  decoration: BoxDecoration(
                                    color: AppColors.textFieldBackground1,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(left: width * 0.015),
                                    child: TextField(
                                      controller: _incomeAmoutController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: '\$ 0.00',
                                        hintStyle: TextStyle(
                                          color: AppColors.disabledColor,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                //!Category
                                SizedBox(height: height * 0.03),
                                const Text(
                                  'Category',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: height * 0.02),
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
                                    value: category,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    isExpanded: true,
                                    style: const TextStyle(color: Colors.black),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        category = newValue!;
                                      });
                                    },
                                    items: <String>[
                                      'Select Category',
                                      'Salary',
                                      'Income from rent',
                                      'Interest',
                                      'Pension',
                                      'Work on demand',
                                      'Tax return',
                                      'Coupon',
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),

                                //!Description
                                SizedBox(height: height * 0.03),
                                Row(
                                  children: [
                                    const Text(
                                      'Description',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(width: width * 0.04),
                                    const Text(
                                      '(optional)',
                                      style: TextStyle(
                                        color: AppColors.optionalColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: height * 0.02),
                                Container(
                                  height: height * 0.17,
                                  width: width,
                                  decoration: BoxDecoration(
                                    color: AppColors.textFieldBackground1,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.015,
                                    ),
                                    child: TextField(
                                      controller: _incomeDescController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Enter Your Description',
                                        hintStyle: TextStyle(
                                          color: AppColors.disabledColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      maxLines: 5,
                                    ),
                                  ),
                                ),
                                SizedBox(height: height * 0.04),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      height: height * 0.05,
                                      width: width * 0.25,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (_incomeAmoutController.text.isEmpty ||
                                              _incomeAmoutController
                                                  .text.isEmpty ||
                                              category == 'Select Category') {
                                            Fluttertoast.showToast(
                                              msg: 'Fill all the boxes',
                                              toastLength: Toast.LENGTH_LONG,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.black54,
                                              textColor: Colors.white,
                                              fontSize: 16.0,
                                            );
                                          } else {
                                            if (_incomeDescController
                                                .text.isEmpty) {
                                              _incomeDescController.text =
                                                  'No description';
                                            }
                                            addIncomeApi(
                                              '${selectedDate.toLocal()}.split('
                                                      ')[0]'
                                                  .split(' ')[0],
                                              _incomeDescController.text,
                                              category,
                                              _incomeAmoutController.text,
                                              1.toString(),
                                            );
                                            Get.offAll(
                                              () => const TransactionHistory(),
                                              transition:
                                                  Transition.leftToRight,
                                            );
                                          }
                                        },
                                        child: const Text(
                                          'Submit',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.textColor1,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          primary: AppColors.buttonColorBlue2,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          //!Minus button
                          Positioned(
                            top: height * 0.65,
                            child: Container(
                              width: width * 0.25,
                              height: height * 0.075,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color(0xF6F8FFE0),
                                    Color(0xff87CBF2),
                                    Color(0xff096885),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: height * 0.649,
                            left: width * 0.15,
                            child: GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: SvgPicture.asset('assets/icons/minus.svg'),
                            ),
                          ),
                        ],
                      ),

                      //!Expenses
                      Stack(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width / 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: height * 0.03),
                                // //!Date
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
                                //   padding: const EdgeInsets.only(
                                //       left: 6, right: 6, bottom: 4),
                                //   height: height * 0.05,
                                //   width: width,
                                //   decoration: BoxDecoration(
                                //     borderRadius: BorderRadius.circular(2),
                                //     color: AppColors.lightBlue,
                                //   ),
                                //   child: Row(
                                //     mainAxisAlignment:
                                //         MainAxisAlignment.spaceBetween,
                                //     children: [
                                //       SizedBox(
                                //         height: height * 0.04,
                                //         width: width * 0.7,
                                //         child: TextField(
                                //           controller: _expenseDateController,
                                //           decoration: InputDecoration(
                                //             border: InputBorder.none,
                                //             hintText:
                                //                 '${selectedDate.toLocal()}.split('
                                //                         ')[0]'
                                //                     .split(' ')[0],
                                //             hintStyle: const TextStyle(
                                //               fontSize: 14,
                                //               fontWeight: FontWeight.w400,
                                //               color:
                                //                   AppColors.disabledTextColor,
                                //             ),
                                //           ),
                                //         ),
                                //       ),
                                //       GestureDetector(
                                //         onTap: () {
                                //           _selectDate(context);
                                //         },
                                //         child: const Icon(
                                //           Icons.calendar_today_outlined,
                                //           color: AppColors.iconColor,
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),

                                //!Amount
                                SizedBox(height: height * 0.03),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Amount',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      '${selectedDate.toLocal()}.split('
                                              ')[0]'
                                          .split(' ')[0],
                                      style: const TextStyle(
                                        color: Color(0xffD4D4D4),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: height * 0.02),
                                Container(
                                  height: height * 0.05,
                                  width: width,
                                  decoration: BoxDecoration(
                                    color: AppColors.textFieldBackground1,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(left: width * 0.015),
                                    child: TextField(
                                      controller: _expenseAmountController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: '\$ 0.00',
                                        hintStyle: TextStyle(
                                          color: AppColors.disabledColor,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                //!Category
                                SizedBox(height: height * 0.03),
                                const Text(
                                  'Category',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: height * 0.02),
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
                                    value: category2,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    isExpanded: true,
                                    style: const TextStyle(color: Colors.black),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        category2 = newValue!;
                                      });
                                    },
                                    items: <String>[
                                      'Select Category',
                                      'Salary',
                                      'Income from rent',
                                      'Interest',
                                      'Pension',
                                      'Work on demand',
                                      'Tax return',
                                      'Coupon',
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),

                                //!Description
                                SizedBox(height: height * 0.03),
                                Row(
                                  children: [
                                    const Text(
                                      'Description',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(width: width * 0.04),
                                    const Text(
                                      '(optional)',
                                      style: TextStyle(
                                        color: AppColors.optionalColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: height * 0.02),
                                Container(
                                  height: height * 0.17,
                                  width: width,
                                  decoration: BoxDecoration(
                                    color: AppColors.textFieldBackground1,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.015,
                                    ),
                                    child: TextField(
                                      controller: _expenseDescController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Enter Your Description',
                                        hintStyle: TextStyle(
                                          color: AppColors.disabledColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      maxLines: 5,
                                    ),
                                  ),
                                ),
                                SizedBox(height: height * 0.04),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      height: height * 0.05,
                                      width: width * 0.25,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (_expenseAmountController.text.isEmpty ||
                                              _expenseAmountController
                                                  .text.isEmpty ||
                                              category2 == 'Select Category') {
                                            Fluttertoast.showToast(
                                              msg: 'Fill all the boxes',
                                              toastLength: Toast.LENGTH_LONG,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.black54,
                                              textColor: Colors.white,
                                              fontSize: 16.0,
                                            );
                                          } else {
                                            if (_expenseDescController
                                                .text.isEmpty) {
                                              _expenseDescController.text =
                                                  'No description';
                                            }
                                            addExpenseApi(
                                              '${selectedDate.toLocal()}.split('
                                                      ')[0]'
                                                  .split(' ')[0],
                                              _expenseDescController.text,
                                              category2,
                                              _expenseAmountController.text,
                                              1.toString(),
                                            );

                                            Get.offAll(
                                              () => const TransactionHistory(),
                                              transition:
                                                  Transition.leftToRight,
                                            );
                                          }
                                        },
                                        child: const Text(
                                          'Submit',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.textColor1,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          primary: AppColors.buttonColorBlue2,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          //!Minus button
                          Positioned(
                            top: height * 0.65,
                            child: Container(
                              width: width * 0.25,
                              height: height * 0.075,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color(0xF6F8FFE0),
                                    Color(0xff87CBF2),
                                    Color(0xff096885),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: height * 0.649,
                            left: width * 0.15,
                            child: GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: SvgPicture.asset('assets/icons/minus.svg'),
                            ),
                          ),
                        ],
                      ),

                      //!Banking
                      const Center(
                        child: Text(
                          'Banking',
                          style: TextStyle(
                            color: Colors.white,
                          ),
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
