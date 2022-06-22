// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jyngles/utils/appurl.dart';
import 'package:jyngles/utils/colors.dart';
import 'package:jyngles/widgets/controller.dart';
import 'package:jyngles/widgets/custom_bottom_navigation.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  Future? getincome;
  Future getIncome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"
    };

    var response =
    await http.get(Uri.parse(AppUrl.notification), headers: requestHeaders);
    if (response.statusCode == 200) {
      print('Get post collected' + response.body);
      var userData1 = jsonDecode(response.body)['data']['dataInAppPush'];
      print(userData1);
      return userData1;
    } else {
      print("post have no Data${response.body}");
      var userData1 = jsonDecode(response.body)['data']['dataInAppPush'];
      return userData1;
    }
  }
  @override
  void initState() {
    super.initState();
    getincome = getIncome();
  }
  final MyHomePageController? controller = Get.put(MyHomePageController());

  @override
  Widget build(BuildContext context) {  final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: controller!.change_color.value,
        elevation: 2,
        title: const Text(
          'Notification',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: InkWell(
          onTap: () {
Navigator.push(context, MaterialPageRoute(builder: (_)=>CustomBottomNavigationBar()));          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(

              ),
              constraints: const BoxConstraints(),
              child: FutureBuilder(
                future: getincome,
                builder: (_, AsyncSnapshot snapshot) {
                  print(snapshot.data);
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height:
                        MediaQuery.of(context).size.height / 5,
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.withOpacity(0.3),
                          highlightColor:
                          Colors.grey.withOpacity(0.1),
                          child: ListView.builder(
                            itemBuilder: (_, __) => Padding(
                              padding:
                              const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: 48.0,
                                    height: 48.0,
                                    color: Colors.white,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          width: double.infinity,
                                          height: 8.0,
                                          color: Colors.white,
                                        ),
                                        const Padding(
                                          padding:
                                          EdgeInsets.symmetric(
                                              vertical: 2.0),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 8.0,
                                          color: Colors.white,
                                        ),
                                        const Padding(
                                          padding:
                                          EdgeInsets.symmetric(
                                              vertical: 2.0),
                                        ),
                                        Container(
                                          width: 40.0,
                                          height: 8.0,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            itemCount: 6,
                          ),
                        ),
                      );
                    default:
                      if (snapshot.hasError) {
                        Text('Error: ${snapshot.error}');
                      } else {
                        return snapshot.hasData
                            ? Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: SizedBox(
                            height: height / 1,
                            child: ListView.builder(
                              itemCount: snapshot.data.length,
                              shrinkWrap:true,
                              itemBuilder: (_, int index) {
                                return             Container(
                                  child:Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [

                                        Row(crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Flexible(child: Text(snapshot.data[index]['message'],style: TextStyle(fontWeight: FontWeight.w700,color: Colors.black),)),

                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Text(DateFormat.yMd().add_jm().format(DateTime.parse(snapshot.data[index]['created_at'])),style:TextStyle(fontSize:10)),
                                        ),
                                        Divider(color: Colors.black,)
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                            : const Text('No data');
                      }
                  }
                  return Center(child: const CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
