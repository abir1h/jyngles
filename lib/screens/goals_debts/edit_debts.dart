import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jyngles/widgets/controller.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/appurl.dart';
import '../../utils/colors.dart';
import 'goals_debt_screen.dart';

class EditDebts extends StatefulWidget {
  const EditDebts({
    Key? key,
    required this.id,
    required this.status,
    required this.date,
    required this.amount,
    required this.description,
    required this.title,
  }) : super(key: key);
  final String id;
  final String status;
  final String date;
  final String amount;
  final String title;
  final String description;

  @override
  State<EditDebts> createState() => _EditDebtsState();
}

class _EditDebtsState extends State<EditDebts> with SingleTickerProviderStateMixin{
  // bool value = false;
  List<bool> values = [false, false, false];

  final MyHomePageController? controller = Get.put(MyHomePageController());
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

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController amountSavedController = TextEditingController();
  //!Edit Transaction
  Future updateGoals(
      String title,
      String description,
      String amount,
      String date,
      String status_,
      ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"
    };
    var request = await http.MultipartRequest(
      'POST',
      Uri.parse(AppUrl.debtEdit + widget.id),
    );
    request.fields.addAll({
      'title': title,
      'description': description,
      'amount': amount,
      'date': date,
      'status': status_,
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

            if(status_=='1'){
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
                    Text('You have completed your Debt',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 14),),
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Got ',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 14),),
                        Text(data['point'].toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 14),),
                        Text(' Points',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 14),),

                      ],
                    )
                  ],
                ),
                title: 'This is Ignored',
                desc:   'This is also Ignored',
                btnOkOnPress: () {
                  Get.to(
                        () => const GoalsDebtsScreen(fromBottomNav: false,selected_index: 0,),
                    transition: Transition.rightToLeft,
                  );
                },
              ).show();
            }else if(status_=='0'){
              AwesomeDialog(
                context: context,
                animType: AnimType.SCALE,
                dialogType: DialogType.WARNING,
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
                    Text('Oopps!!',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
                    Text('Your debt is still pending',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 14),),

                  ],
                ),
                title: 'This is Ignored',
                desc:   'This is also Ignored',
                btnOkOnPress: () {
                  Get.to(
                        () => const GoalsDebtsScreen(fromBottomNav: false,selected_index: 0,),
                    transition: Transition.rightToLeft,
                  );
                },
              )..show();
            }else{
              AwesomeDialog(
                context: context,
                animType: AnimType.SCALE,
                dialogType: DialogType.ERROR,
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
                    Text('Oopps!!',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
                    Text('You are failed to complete this debt',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 14),),

                  ],
                ),
                title: 'This is Ignored',
                desc:   'This is also Ignored',
                btnOkOnPress: () {
                  Get.to(
                        () => const GoalsDebtsScreen(fromBottomNav: false,selected_index: 0,),
                    transition: Transition.rightToLeft,
                  );
                },
              )..show();

            }

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
  Future delet(

      ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"
    };
    var request = await http.MultipartRequest(
      'POST',
      Uri.parse(AppUrl.debt_delete + widget.id),
    );


    request.headers.addAll(requestHeaders);

    request.send().then((result) async {
      http.Response.fromStream(result).then((response) {
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);

          if (data['status_code'] == 200) {
            var data = jsonDecode(response.body);
            print(data);
            print('response.body ' + data.toString());
            Get.to(
                  () => const GoalsDebtsScreen(fromBottomNav: false,selected_index: 0,),
              transition: Transition.rightToLeft,
            );
            Fluttertoast.showToast(
              msg: "Deleted Successfully",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
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
  }  late final AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this);
    selectedDate=DateTime.parse(widget.date);


  }
  var status;
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
            title: const Text(
              'Update Debt',
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
                  SizedBox(height: height * 0.01),

                  //!Status
                  const Text(
                    'Status',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: height * 0.015),
                  //!Checkbox group
                  Column(
                    children: [
                      Row(
                        children: [
                          Theme(
                            data: Theme.of(context).copyWith(
                              unselectedWidgetColor: Colors.white,
                            ),
                            child: Checkbox(
                              value: values[0],
                              onChanged: (bool? value) {
                                setState(() {
                                  values[0] = value!;
                                  values[2] = false;
                                  values[1] = false;
                                  status=0;

                                });
                                print(status);
                              },
                            ),
                          ),
                          const Text(
                            'Pending',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Theme(
                            data: Theme.of(context).copyWith(
                              unselectedWidgetColor: Colors.white,
                            ),
                            child: Checkbox(
                              value: values[1],
                              onChanged: (bool? value) {
                                setState(() {
                                  values[2] = false;
                                  values[0] = false;
                                  values[1] = value!;
                                  status=1;

                                });                                print(status);

                              },
                            ),
                          ),
                          const Text(
                            'Completed',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Theme(
                            data: Theme.of(context).copyWith(
                              unselectedWidgetColor: Colors.white,
                            ),
                            child: Checkbox(
                              value: values[2],
                              onChanged: (bool? value) {
                                setState(() {
                                  values[2] = value!;
                                  values[0] = false;
                                  values[1] = false;
                                  status=2;

                                });                                print(status);

                              },
                            ),
                          ),
                          const Text(
                            'Failed',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // SimpleGroupedCheckbox<int>(
                  //   controller: controller,
                  //   itemsTitle: ["1", "2", "4", "5"],
                  //   values: [1, 2, 4, 5],
                  //   groupStyle: GroupStyle(
                  //     activeColor: Colors.red,
                  //     itemTitleStyle: TextStyle(fontSize: 13),
                  //   ),
                  //   checkFirstElement: false,
                  // ),

                  SizedBox(height: height * 0.015),

                  //!Title
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
                          child: TextField(
                            controller: titleController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: widget.title,
                              hintStyle: const TextStyle(
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
                        EdgeInsets.only(left: 15,top: 10),
                        child:  Text(
                          '${selectedDate.toLocal()}.split('
                              ')[0]'
                              .split(' ')[0],
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
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
                        controller: descriptionController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: widget.description,
                          hintStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.disabledTextColor,
                          ),
                        ),
                      ),
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
                          child: TextField(                                      keyboardType: TextInputType.number,

                            controller: amountController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '${controller!.count.value}'+' ${widget.amount}',
                              hintStyle: const TextStyle(
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

                  //!Amount saved
                  // const Text(
                  //   'Amount Saved',
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
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       SizedBox(
                  //         height: height * 0.04,
                  //         width: width * 0.7,
                  //         child: TextField(
                  //           controller: amountSavedController,
                  //           decoration: InputDecoration(
                  //             border: InputBorder.none,
                  //             hintText: '\$ ${widget.amountSaved}',
                  //             hintStyle: const TextStyle(
                  //               fontSize: 14,
                  //               fontWeight: FontWeight.w400,
                  //               color: AppColors.disabledTextColor,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  SizedBox(height: height * 0.1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // showDialog(
                          //   context: context,
                          //   builder: (context) =>
                          //       CustomDialog(height: height, width: width),
                          // );

                          delet();

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
                              'Delete',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // showDialog(
                          //   context: context,
                          //   builder: (context) =>
                          //       CustomDialog(height: height, width: width),
                          // );

                          if(status==null){
                            Fluttertoast.showToast(
                              msg: "Please change status to update",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black54,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          }else{
                            updateGoals(
                              titleController.text.isEmpty
                                  ? widget.title
                                  : titleController.text,
                              descriptionController.text.isEmpty
                                  ? widget.description
                                  : descriptionController.text,
                              amountController.text.isEmpty
                                  ? widget.amount
                                  : amountController.text,

                              '${selectedDate.toLocal()}.split('
                                  ')[0]'
                                  .split(' ')[0],
                              status.toString(),
                            );

                          }

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
                              'Update Debt',
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

class CustomDialog extends StatelessWidget {
  const CustomDialog({
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
              'Are You Sure? ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: height * 0.02),
            const Text(
              'Do you really want to update?',
              style: TextStyle(
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
                    child: const Center(
                      child: Text(
                        'Cancel',
                        style: TextStyle(
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
                    child: const Center(
                      child: Text(
                        'Update',
                        style: TextStyle(
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
