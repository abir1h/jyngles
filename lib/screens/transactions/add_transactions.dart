import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:jyngles/screens/tax.dart';
import 'package:jyngles/screens/transactions/transaction_history.dart';
import 'package:jyngles/widgets/controller.dart';
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
  String tax = 'Select Tax Information';
  String dropdownValue = '\$';
  DateTime selectedDate = DateTime.now();


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
List income_catagory=['test','redfgs','dfgsrfg'];
  //!Add Income
  final MyHomePageController? controller = Get.put(MyHomePageController());
  Future addIncomeApi(
    String date,
    String cate,
    String desc,
    String amount,
    String category_id,
      String tax_info
  ) async {
    print(tax_info);
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
      'tax':tax_info
    });

    request.headers.addAll(requestHeaders);

    request.send().then((result) async {
      http.Response.fromStream(result).then((response) {
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          print(data);
         if(data['status_code']==200){
           print('response.body ' + data.toString());
           Fluttertoast.showToast(
             msg: data['message'],
             toastLength: Toast.LENGTH_LONG,
             gravity: ToastGravity.BOTTOM,
             timeInSecForIosWeb: 1,
             backgroundColor: Colors.green,
             textColor: Colors.white,
             fontSize: 16.0,
           );
           setState(() {
             income=false;
           });
           AwesomeDialog(
             context: context,
             animType: AnimType.SCALE,
             dialogType: DialogType.SUCCES,
             body:Column(
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 // Lottie.asset(
                 //   'assets/images/congrats.json',
                 //   controller: _controller,
                 //   onLoaded: (composition) {
                 //     // Configure the AnimationController with the duration of the
                 //     // Lottie file and start the animation.
                 //     _controller
                 //       ..duration = composition.duration
                 //       ..forward();
                 //   },
                 // ),
                 Text('Congratulation!!',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
                 Text('You have added your income',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 14),),
                 // Row(mainAxisAlignment: MainAxisAlignment.center,
                 //   children: [
                 //     Text('Got ',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 14),),
                 //     Text(data['point'].toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 14),),
                 //     Text(' Points',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 14),),
                 //
                 //   ],
                 // )
               ],
             ),
             title: 'This is Ignored',
             desc:   'This is also Ignored',
             btnOkOnPress: () {
Get.back();             },
           ).show();
           Navigator.push(context, MaterialPageRoute(builder: (_)=>TransactionHistory(selected_index: 0,)));
         }else{
           var data = jsonDecode(response.body);
           setState(() {
             income=false;
           });

           AwesomeDialog(
             context: context,
             animType: AnimType.SCALE,
             dialogType: DialogType.INFO,
             body:Column(
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 // Lottie.asset(
                 //   'assets/images/congrats.json',
                 //   controller: _controller,
                 //   onLoaded: (composition) {
                 //     // Configure the AnimationController with the duration of the
                 //     // Lottie file and start the animation.
                 //     _controller
                 //       ..duration = composition.duration
                 //       ..forward();
                 //   },
                 // ),
                 Text("Feedback",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
                 Text(data['message'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 14),),
               ],
             ),
             title: 'This is Ignored',
             desc:   'This is also Ignored',
             btnOkOnPress: () {
               Get.to(
                     () =>  tax_zone(),
                 transition: Transition.rightToLeft,
               );
             },
           ).show();

         }


        } else {
         print(jsonDecode(response.body));
        }
      });
    });
  }  Future<void> _selectDate(BuildContext context) async {
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

  bool income=false;
  bool expense=false;
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
      'title':  _expenseDescController.text,
      'description': _expenseDescController.text,
      'amount': amount,
      'type': type=='Wants'?'wants':type=='Savings'?'savings':'needs',
      'category_id': category_id,

    });

    request.headers.addAll(requestHeaders);

    request.send().then((result) async {
      http.Response.fromStream(result).then((response) {
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          print(data);
      if(data['status_code']==200){
        print('response.body ' + data.toString());
        Fluttertoast.showToast(
          msg: data['message'],
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        setState(() {
          expense=false;
        });
        Navigator.push(context, MaterialPageRoute(builder: (_)=>TransactionHistory(selected_index: 1,)));
      }else{
        var data = jsonDecode(response.body);
        print(data); print('response.body ' + data.toString());
        Fluttertoast.showToast(
          msg: data['message'],
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        setState(() {
          expense=false;
        });
      }

          // Navigator.push(context, MaterialPageRoute(builder: (_)=>OtpVerificationScreen(phone: phone,)));

        } else {
          var data = jsonDecode(response.body);
          setState(() {
            expense=false;
          });
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
    _tabController = TabController(vsync: this, length: 2);
    _tabController.animateTo((_tabController.index + widget.tabbarIndex) % 2);
    myFuture=get_notification();
    Expence_lsit=get_expence_catagory();
  }
  var type='Select Expense Type';

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
            leading: IconButton(onPressed: (){Get.back();},icon: Icon(Icons.arrow_back_outlined,color: Colors.black,),),
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
                                      controller: _incomeAmoutController,                                      keyboardType: TextInputType.number,

                                      decoration:  InputDecoration(
                                        border: InputBorder.none,
                                        hintText: '${controller!.count.value}'+' 0.00',
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
                                // Container(
                                //   width: width,
                                //   height: height * 0.05,
                                //   padding: EdgeInsets.symmetric(
                                //       horizontal: width * 0.03),
                                //   decoration: BoxDecoration(
                                //     borderRadius: BorderRadius.circular(2),
                                //     color: AppColors.textFieldBackground1,
                                //   ),
                                //   child: DropdownButton<String>(
                                //     value: category,
                                //     icon: const Icon(Icons.keyboard_arrow_down),
                                //     isExpanded: true,
                                //     style: const TextStyle(color: Colors.black),
                                //     onChanged: (String? newValue) {
                                //       setState(() {
                                //         category = newValue!;
                                //       });
                                //     },
                                //     items: <String>[
                                //       'Select Category',
                                //       'Salary',
                                //       'Income from rent',
                                //       'Interest',
                                //       'Pension',
                                //       'Work on demand',
                                //       'Tax return',
                                //       'Coupon',
                                //     ].map<DropdownMenuItem<String>>(
                                //         (String value) {
                                //       return DropdownMenuItem<String>(
                                //         value: value,
                                //         child: Text(value),
                                //       );
                                //     }).toList(),
                                //   ),
                                // ),
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
                                                category=c_name;

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
                                SizedBox(height: height * 0.02),

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
                                              _mySelection==null || tax=='Select Tax Information') {
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
                                            setState(() {
                                              income=true;
                                            });
                                            addIncomeApi(
                                              '${selectedDate.toLocal()}.split('
                                                      ')[0]'
                                                  .split(' ')[0],
                                              _incomeDescController.text,
                                              category,
                                              _incomeAmoutController.text,
                                              income_id,tax=='Include Tax'?'yes':'no'
                                            );
                                            // Get.offAll(
                                            //   () => const TransactionHistory(),
                                            //   transition:
                                            //       Transition.leftToRight,
                                            // );
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
                          // Positioned(
                          //   top: height * 0.65,
                          //   child: Container(
                          //     width: width * 0.25,
                          //     height: height * 0.075,
                          //     decoration: const BoxDecoration(
                          //       gradient: LinearGradient(
                          //         begin: Alignment.centerLeft,
                          //         end: Alignment.centerRight,
                          //         colors: [
                          //           Color(0xF6F8FFE0),
                          //           Color(0xff87CBF2),
                          //           Color(0xff096885),
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // Positioned(
                          //   top: height * 0.649,
                          //   left: width * 0.15,
                          //   child: GestureDetector(
                          //     onTap: () {
                          //       Get.back();
                          //     },
                          //     child: SvgPicture.asset('assets/icons/minus.svg'),
                          //   ),
                          // ),
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
                                    InkWell(
                                      onTap: (){
                                        _selectDate(context);
                                      },
                                      child: Text(
                                        '${selectedDate.toLocal()}.split('
                                                ')[0]'
                                            .split(' ')[0],
                                        style: const TextStyle(
                                          color: Color(0xffD4D4D4),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
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
                                      keyboardType: TextInputType.number,
                                      decoration:  InputDecoration(
                                        border: InputBorder.none,
                                        hintText: '${controller!.count.value}'+' 0.00',
                                        hintStyle: TextStyle(
                                          color: AppColors.disabledColor,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ), SizedBox(height: height * 0.03),
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
                                  child: Container(
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
                                              print(expence_id+expence_value);
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

                                //!Description
                                SizedBox(height: height * 0.03),
                                Row(
                                  children: [
                                    const Text(
                                      'Title',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(width: width * 0.04),

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
                                        hintText: 'Enter Your Title',
                                        hintStyle: TextStyle(
                                          color: AppColors.disabledColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      maxLines: 5,
                                    ),
                                  ),
                                ),    SizedBox(height: height * 0.02),
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
                                    value: type,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    isExpanded: true,
                                    style: const TextStyle(color: Colors.black),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        type = newValue!;
                                      });
                                    },
                                    items: <String>[
                                      'Select Expense Type',
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

                                //!Description
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
                                                  .text.isEmpty || type=='Select Expense Type' ) {
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
                                              expence_id,
                                            );

                                            // Get.offAll(
                                            //   () => const TransactionHistory(),
                                            //   transition:
                                            //       Transition.leftToRight,
                                            // );
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
                          // Positioned(
                          //   top: height * 0.65,
                          //   child: Container(
                          //     width: width * 0.25,
                          //     height: height * 0.075,
                          //     decoration: const BoxDecoration(
                          //       gradient: LinearGradient(
                          //         begin: Alignment.centerLeft,
                          //         end: Alignment.centerRight,
                          //         colors: [
                          //           Color(0xF6F8FFE0),
                          //           Color(0xff87CBF2),
                          //           Color(0xff096885),
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // Positioned(
                          //   top: height * 0.649,
                          //   left: width * 0.15,
                          //   child: GestureDetector(
                          //     onTap: () {
                          //       Get.back();
                          //     },
                          //     child: SvgPicture.asset('assets/icons/minus.svg'),
                          //   ),
                          // ),
                        ],
                      ),

                      //!Banking
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
