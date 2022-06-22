import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jyngles/screens/profile/add_user.dart';
import 'package:jyngles/utils/appurl.dart';
import 'package:jyngles/utils/colors.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class ViewUser extends StatefulWidget {
  const ViewUser({Key? key}) : super(key: key);

  @override
  State<ViewUser> createState() => _ViewUserState();
}

class _ViewUserState extends State<ViewUser> {
  Future? getincome;
  Future getIncome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"
    };

    var response =
    await http.get(Uri.parse(AppUrl.show_child), headers: requestHeaders);
    if (response.statusCode == 200) {
      print('Get post collected' + response.body);
      var userData1 = jsonDecode(response.body)['data'];
      print(userData1);
      return userData1;
    } else {
      print("post have no Data${response.body}");
      var userData1 = jsonDecode(response.body)['data'];
      return userData1;
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getincome=getIncome();

  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.lightBlue,
        elevation: 2,
        title: const Text(
          'User',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: width / 15,
            right: width / 15,
            top: height * 0.05,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                constraints: const BoxConstraints(),
                decoration: const BoxDecoration(

                ),
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
                                              vertical: 2.0,
                                            ),
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
                              itemCount: 10,
                            ),
                          ),
                        );
                      default:
                        if (snapshot.hasError) {
                          Text('Error: ${snapshot.error}');
                        } else {
                          return snapshot.hasData
                              ?  Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color.fromARGB(255, 216, 216, 216)
                                        .withOpacity(0.5),
                                    spreadRadius: 0.1,
                                    blurRadius: 10,
                                    offset: const Offset(0, 0),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      snapshot.data['image']!=null?CircleAvatar(
                                        radius: 40,
                                        backgroundColor: AppColors.lightBlue,

                                        backgroundImage:NetworkImage(AppUrl.picurl+ snapshot.data['image']!),
                                      ):CircleAvatar(
                                        radius: 40,
                                        backgroundColor: AppColors.lightBlue,
                                        child: Center(
                                          child: Text(                                                 snapshot.data['username'][0].toUpperCase(),style: TextStyle(color: AppColors.sidebarColor1,fontSize: 20,fontWeight: FontWeight.bold),),
                                        ),
                                      ),
                                      SizedBox(width: width * 0.05),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot.data['username'],
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(height: height * 0.01),
                                          Text(
                                            snapshot.data['email'],
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  // Container(
                                  //   height: height * 0.05,
                                  //   width: width * 0.25,
                                  //   decoration: BoxDecoration(
                                  //     border: Border.all(
                                  //       color: AppColors.textColor2,
                                  //     ),
                                  //     borderRadius: BorderRadius.circular(5),
                                  //   ),
                                  //   child: const Center(
                                  //     child: Text(
                                  //       'View Profile',
                                  //       style: TextStyle(
                                  //         fontSize: 12,
                                  //         fontWeight: FontWeight.w400,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          )
                              : const Text('No data');
                        }
                    }
                    return const CircularProgressIndicator();
                  },
                ),

              ),

            ],
          ),
        ),
      ),
    );
  }
}
