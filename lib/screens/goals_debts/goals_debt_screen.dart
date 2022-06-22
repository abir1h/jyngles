import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:jyngles/screens/goals_debts/add_goals.dart';
import 'package:jyngles/screens/goals_debts/edit_debts.dart';
import 'package:jyngles/screens/goals_debts/edit_goal.dart';
import 'package:jyngles/widgets/controller.dart';
import 'package:jyngles/widgets/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../../utils/appurl.dart';
import '../../utils/colors.dart';
import '../../widgets/chat_icon_button.dart';
import '../../widgets/notification_icon_button.dart';
import 'package:http/http.dart' as http;

import 'add_debt.dart';

class GoalsDebtsScreen extends StatefulWidget {
  final int selected_index;

  const GoalsDebtsScreen({
    Key? key,
    required this.fromBottomNav,required this.selected_index
  }) : super(key: key);
  final bool fromBottomNav;

  @override
  State<GoalsDebtsScreen> createState() => _GoalsDebtsScreenState();
}

class _GoalsDebtsScreenState extends State<GoalsDebtsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final MyHomePageController? controller = Get.put(MyHomePageController());

  //!Api starts
  Future<List<dynamic>>? getdebt;
  Future<List<dynamic>> getDebt() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"
    };

    var response =
        await http.get(Uri.parse(AppUrl.debtShow), headers: requestHeaders);
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

  Future<List<dynamic>>? getgoals;
  Future<List<dynamic>> getGoals() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"
    };

    var response =
        await http.get(Uri.parse(AppUrl.goalShow), headers: requestHeaders);
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
  //!Api ends

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2,initialIndex: widget.selected_index);
    getdebt = getDebt();
    getgoals = getGoals();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    List<String> bill = [
      'March savings',
      'April savings',
      'May savings',
      'March savings',
      'April savings',
      'May savings',
      'June savings',
      'June savings',
      'March savings',
      'April savings',
      'May savings',
      'March savings',
      'April savings',
      'May savings',
      'June savings',
      'June savings'
    ];
    List<String> date = [
      '2022-March-27',
      '2022-April-28',
      '2022-May-29',
      '2022-June-30',
      '2022-March-27',
      '2022-April-28',
      '2022-May-29',
      '2022-June-30',
      '2022-March-27',
      '2022-April-28',
      '2022-May-29',
      '2022-June-30',
      '2022-March-27',
      '2022-April-28',
      '2022-May-29',
      '2022-June-30'
    ];
    List<String> amount = [
      '2000',
      '3000',
      '2000',
      '3000',
      '1000',
      '500',
      '1000',
      '2000',
      '3000',
      '2000',
      '3000',
      '1000',
      '500',
      '1000',
      '500',
      '500',
    ];
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
          key: _key,
          drawer: CustomDrawer(height: height, width: width),
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: controller!.change_color.value,
            elevation: 2,
            title: Text(
              widget.fromBottomNav==true?'Goals/Debt'.toUpperCase():"Goals/Debt History".toUpperCase(),
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
            leading: GestureDetector(
              onTap: () {
                _key.currentState!.openDrawer();
              },
              child: const Icon(
                Icons.sort,
                color: Colors.black,
              ),
            ),
            actions: [
              NotificationIconButton(width: width),
            ],
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
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
                            'Debt',
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
                            'Goals',
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
                      //!Debts
                      bill.isEmpty
                          ? Column(
                              children: [
                                SizedBox(height: height * 0.1),
                                Image.asset('assets/images/emoji.png'),
                                SizedBox(height: height * 0.05),
                                const Text(
                                  'You have not added any debt yet!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: height * 0.065),
                                Container(
                                  height: height * 0.065,
                                  width: width * 0.45,
                                  decoration: BoxDecoration(
                                    color: AppColors.containerButton,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Add Debt',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Stack(
                              children: [
                                SizedBox(
                                  height: height,
                                  child: FutureBuilder(
                                    future: getdebt,
                                    builder: (_, AsyncSnapshot snapshot) {
                                      print(snapshot.data);
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.waiting:
                                          return SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                5,
                                            child: Shimmer.fromColors(
                                              baseColor:
                                                  Colors.grey.withOpacity(0.3),
                                              highlightColor:
                                                  Colors.grey.withOpacity(0.1),
                                              child: ListView.builder(
                                                itemBuilder: (_, __) => Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 8.0),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Container(
                                                        width: 48.0,
                                                        height: 48.0,
                                                        color: Colors.white,
                                                      ),
                                                      const Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    8.0),
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Container(
                                                              width: double
                                                                  .infinity,
                                                              height: 8.0,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            const Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                vertical: 2.0,
                                                              ),
                                                            ),
                                                            Container(
                                                              width: double
                                                                  .infinity,
                                                              height: 8.0,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            const Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          2.0),
                                                            ),
                                                            Container(
                                                              width: 40.0,
                                                              height: 8.0,
                                                              color:
                                                                  Colors.white,
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
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                      15.0,
                                                    ),
                                                    child: ListView.builder(
                                                      itemCount:
                                                          snapshot.data.length,
                                                      itemBuilder:
                                                          (_, int index) {
                                                        return InkWell(
                                                          onTap: () {
                                                            Get.to(
                                                              //TODO: Add Debt Page
                                                              () => EditDebts(
                                                                id: snapshot
                                                                    .data[index]
                                                                        ['id']
                                                                    .toString(),
                                                                amount: snapshot
                                                                    .data[index]
                                                                        [
                                                                        'amount']
                                                                    .toString(),

                                                                date: snapshot
                                                                            .data[
                                                                        index]
                                                                    ['date'].toString(),
                                                                description: snapshot
                                                                            .data[
                                                                        index][
                                                                    'description'],
                                                                status: snapshot
                                                                            .data[
                                                                        index]
                                                                    ['status'],
                                                                title: snapshot
                                                                            .data[
                                                                        index]
                                                                    ['title'],
                                                              ),
                                                              transition:
                                                                  Transition
                                                                      .rightToLeft,
                                                            );
                                                          },
                                                          child: BillList(
                                                            width: width,
                                                            height: height,
                                                            billAmount: snapshot
                                                                .data[index]
                                                                    ['amount']
                                                                .toString(),
                                                            billName: snapshot
                                                                    .data[index]
                                                                ['title'],
                                                            billTime: snapshot
                                                                            .data[
                                                                        index]
                                                                    ['date'] ??
                                                                '',
                                                            status: snapshot
                                                                .data[
                                                            index]
                                                            ['status'] ,
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  )
                                                : const Text('No data');
                                          }
                                      }
                                      return const CircularProgressIndicator();
                                    },
                                  ),
                                ),
                                Positioned(
                                  left: width * 0.45,
                                  top: widget.fromBottomNav
                                      ? height * 0.65
                                      : height * 0.73,
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(
                                        const AddDebts(),
                                        transition: Transition.rightToLeft,
                                      );
                                    },
                                    child: const CircleAvatar(
                                      radius: 25,
                                      backgroundColor: Colors.white,
                                      child: Icon(Icons.add),
                                    ),
                                  ),
                                )
                              ],
                            ),

                      //!Goal page
                      bill.isEmpty
                          ? Column(
                              children: [
                                SizedBox(height: height * 0.1),
                                Image.asset('assets/images/emoji.png'),
                                SizedBox(height: height * 0.05),
                                const Text(
                                  'You have not added any goal yet!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: height * 0.065),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(
                                      const AddGoals(),
                                      transition: Transition.rightToLeft,
                                    );
                                  },
                                  child: Container(
                                    height: height * 0.065,
                                    width: width * 0.45,
                                    decoration: BoxDecoration(
                                      color: AppColors.containerButton,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Add Goal',
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
                            )
                          : Stack(
                              children: [
                                SizedBox(
                                  height: height,
                                  child: FutureBuilder(
                                    future: getgoals,
                                    builder: (_, AsyncSnapshot snapshot) {
                                      print(snapshot.data);
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.waiting:
                                          return SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                5,
                                            child: Shimmer.fromColors(
                                              baseColor:
                                                  Colors.grey.withOpacity(0.3),
                                              highlightColor:
                                                  Colors.grey.withOpacity(0.1),
                                              child: ListView.builder(
                                                itemBuilder: (_, __) => Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 8.0),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Container(
                                                        width: 48.0,
                                                        height: 48.0,
                                                        color: Colors.white,
                                                      ),
                                                      const Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    8.0),
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Container(
                                                              width: double
                                                                  .infinity,
                                                              height: 8.0,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            const Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                vertical: 2.0,
                                                              ),
                                                            ),
                                                            Container(
                                                              width: double
                                                                  .infinity,
                                                              height: 8.0,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            const Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          2.0),
                                                            ),
                                                            Container(
                                                              width: 40.0,
                                                              height: 8.0,
                                                              color:
                                                                  Colors.white,
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
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15.0),
                                                    child: ListView.builder(
                                                      itemCount:
                                                          snapshot.data.length,
                                                      itemBuilder:
                                                          (_, int index) {
                                                        return InkWell(
                                                          onTap: () {
                                                            Get.to(
                                                                  () => EditGoals(
                                                                id: snapshot
                                                                    .data[index]
                                                                ['id']
                                                                    .toString(),
                                                                amount: snapshot
                                                                    .data[index]
                                                                [
                                                                'amount']
                                                                    .toString(),

                                                                date: snapshot
                                                                    .data[
                                                                index]
                                                                ['date'],
                                                                description: snapshot
                                                                    .data[
                                                                index][
                                                                'description'],
                                                                status: snapshot
                                                                    .data[
                                                                index]
                                                                ['status'],
                                                                title: snapshot
                                                                    .data[
                                                                index]
                                                                ['title'],
                                                              ),
                                                              transition:
                                                              Transition
                                                                  .rightToLeft,
                                                            );
                                                          },
                                                          child: BillList(
                                                            width: width,
                                                            height: height,
                                                            billAmount: snapshot
                                                                .data[index]
                                                                    ['amount']
                                                                .toString(),
                                                            billName: snapshot
                                                                    .data[index]
                                                                ['title'],
                                                            billTime: snapshot
                                                                            .data[
                                                                        index]
                                                                    ['date'] ??
                                                                '',status: snapshot
                                                              .data[
                                                          index]
                                                          ['status'] ,
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  )
                                                : const Text('No data');
                                          }
                                      }
                                      return const CircularProgressIndicator();
                                    },
                                  ),
                                ),
                                Positioned(
                                  left: width * 0.45,
                                  top: widget.fromBottomNav
                                      ? height * 0.65
                                      : height * 0.73,
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(
                                        const AddGoals(),
                                        transition: Transition.rightToLeft,
                                      );
                                    },
                                    child: const CircleAvatar(
                                      radius: 25,
                                      backgroundColor: Colors.white,
                                      child: Icon(Icons.add),
                                    ),
                                  ),
                                )
                              ],
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

class BillList extends StatelessWidget {
   BillList({
    Key? key,
    required this.width,
    required this.height,
    required this.billAmount,
    required this.billName,
    required this.billTime,
    required this.status
  }) : super(key: key);
   final MyHomePageController? controller = Get.put(MyHomePageController());
  final double width;
  final double height;
  final String billName;
  final String billAmount;
  final String billTime;
  final int status;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //!Bill
                    Image.asset('assets/images/salary.png',height: 30,width: 30,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                    billName.length > 20 ? '${billName.substring(0, 12)}......' : billName,
                          style: const TextStyle(
                            color: AppColors.green,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: height * 0.01),
                        Text(
                          billTime,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        //!Amount
                        Text(
                          '${controller!.count.value}'+' $billAmount',
                          style: const TextStyle(
                            color: AppColors.yellow,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                        //!Pending button
                      ],
                    ),
                    Container(
                      height: height * 0.035,
                      width: width * 0.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: const Color(0xff0CA2BE),
                      ),
                      child:  Center(
                        child: Text(
                          status==0?'PENDING':status==1?'Completed':'Failed',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
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
        //!Horizontal Bar
        Container(
          height: 0.5,
          width: width,
          color: AppColors.horizontalbarColor,
        ),
      ],
    );
  }
}
