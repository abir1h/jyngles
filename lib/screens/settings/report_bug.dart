import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:jyngles/utils/appurl.dart';
import 'package:jyngles/utils/colors.dart';
import 'package:jyngles/widgets/chat_icon_button.dart';
import 'package:jyngles/widgets/controller.dart';
import 'package:jyngles/widgets/custom_bottom_navigation.dart';
import 'package:jyngles/widgets/notification_icon_button.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

class ReportABug extends StatefulWidget {
  const ReportABug({Key? key}) : super(key: key);

  @override
  State<ReportABug> createState() => _ReportABugState();
}

class _ReportABugState extends State<ReportABug> {
  TextEditingController title=TextEditingController();
  TextEditingController details=TextEditingController();
  bool submit=false;
  final GlobalKey<FormState> _key = GlobalKey();
  final MyHomePageController? controller = Get.put(MyHomePageController());

  Future addIncomeApi(

      ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"
    };

    var request = await http.MultipartRequest(
      'POST',
      Uri.parse(AppUrl.bug_details),
    );

    var response =
    await http.get(Uri.parse(AppUrl.homePage), headers: requestHeaders);

    //TODO: Need to fix the category id
    request.fields.addAll({
      'title':title.text,
      'bug_details':details.text
    });

    request.headers.addAll(requestHeaders);

    request.send().then((result) async {
      http.Response.fromStream(result).then((response) {
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          print(data);
          print('response.body ' + data.toString());
         setState(() {
            submit=false;
          });
          Navigator.push(context, MaterialPageRoute(builder: (_)=>CustomBottomNavigationBar()));


        } else {
          var data = jsonDecode(response.body);
          setState(() {
            submit=false;
          });

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
      });
    });
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
            elevation: 2,
            title: const Text(
              'Report a Bug',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            leading: GestureDetector(
              onTap: () {
                Get.back();
                // _key.currentState!.openDrawer();
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            actions: [
              ChatIconButton(width: width),
              NotificationIconButton(width: width),
            ],
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 15),
              child: Form(
                key: _key,
                child: Column(
                  children: [
                    SizedBox(height: height * 0.06),
                    Row(
                      children: const [
                        Text(
                          'Title',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.02),
                    Container(
                      width: width,
                      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: AppColors.lightBlue,
                      ),
                      child:  TextFormField(
                        controller: title,
                        validator: (v)=>v!.isEmpty?"Can't be empty":null,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Title',
                          hintStyle: TextStyle(
                            color: AppColors.disabledColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.03),
                    Row(
                      children: const [
                        Text(
                          'Bug Details',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.02),
                    Container(
                      width: width,
                      height: height * 0.2,
                      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: AppColors.lightBlue,
                      ),
                      child:  TextFormField(
                        maxLines: 10,
                        controller: details,                      validator: (v)=>v!.isEmpty?"Can't be empty":null,

                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter bug details',
                          hintStyle: TextStyle(
                            color: AppColors.disabledColor,
                          ),
                        ),
                      ),
                    ),
                SizedBox(height: 25,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: (){
                    if(_key.currentState!.validate()){
                      setState(() {
                        submit=true;
                      });
                      addIncomeApi();
                    }
                    },
                    child: Container(
                          width: width,
                          height: height/20,
                          decoration: BoxDecoration(
                            color: AppColors.lightBlue,
                            borderRadius: BorderRadius.circular(8)
                          ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: submit==false?Text('Submit',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),):CircularProgressIndicator(color: Colors.black,)),
                      ),
                        ),
                  ),
                )

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
