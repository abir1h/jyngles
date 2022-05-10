import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jyngles/screens/transactions/add_transactions.dart';
import 'package:jyngles/screens/transactions/edit_transaction.dart';
import 'package:jyngles/widgets/custom_bottom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/appurl.dart';
import '../../utils/colors.dart';
import 'package:http/http.dart' as http;

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({Key? key}) : super(key: key);

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  //!Api starts
  Future<List<dynamic>>? getincome;
  Future<List<dynamic>> getIncome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"
    };

    var response =
        await http.get(Uri.parse(AppUrl.showIncome), headers: requestHeaders);
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

  Future<List<dynamic>>? getexpense;
  Future<List<dynamic>> getExpense() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"
    };

    var response =
        await http.get(Uri.parse(AppUrl.showExpence), headers: requestHeaders);
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
    _tabController = TabController(vsync: this, length: 2);
    getincome = getIncome();
    getexpense = getExpense();
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
          // backgroundColor: Colors.transparent,
          // floatingActionButtonLocation:
          //     FloatingActionButtonLocation.centerDocked,
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     Get.to(
          //       const AddTransactions(tabbarIndex: 1), //TODO
          //       transition: Transition.rightToLeft,
          //     );
          //   },
          //   backgroundColor: Colors.white,
          //   child: const Icon(
          //     Icons.add,
          //     color: Color(0xff051532),
          //   ),
          // ),
          appBar: AppBar(
            backgroundColor: AppColors.lightBlue,
            elevation: 2,
            title: Text(
              'transactions history'.toUpperCase(),
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
            centerTitle: true,
            leading: GestureDetector(
              onTap: () {
                Get.offAll(
                  () => const CustomBottomNavigationBar(),
                  transition: Transition.leftToRight,
                );
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),
          body: Column(
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
                    //!income
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

                    //!Expenses
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
                height: height * 0.796,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    //!Income page
                    Scaffold(
                      backgroundColor: Colors.transparent,
                      floatingActionButtonLocation:
                          FloatingActionButtonLocation.centerDocked,
                      floatingActionButton: FloatingActionButton(
                        onPressed: () {
                          Get.to(
                            const AddTransactions(tabbarIndex: 0),
                            transition: Transition.rightToLeft,
                          );
                        },
                        backgroundColor: Colors.white,
                        child: const Icon(
                          Icons.add,
                          color: Color(0xff051532),
                        ),
                      ),
                      body: Container(
                        constraints: const BoxConstraints(),
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
                        height: height,
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
                                      ? Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: ListView.builder(
                                            itemCount: snapshot.data.length,
                                            itemBuilder: (_, int index) {
                                              return BillList(
                                                width: width,
                                                height: height,
                                                isIncome: true,
                                                billAmount: snapshot.data[index]
                                                        ['amount']
                                                    .toString(),
                                                billName: snapshot.data[index]
                                                    ['title'],
                                                billTime: snapshot.data[index]
                                                    ['date'],
                                                billDesc: snapshot.data[index]
                                                    ['description'],
                                                id: snapshot.data[index]['id']
                                                    .toString(),
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
                    ),

                    //!Expense page
                    Scaffold(
                      backgroundColor: Colors.transparent,
                      floatingActionButtonLocation:
                          FloatingActionButtonLocation.centerDocked,
                      floatingActionButton: FloatingActionButton(
                        onPressed: () {
                          Get.to(
                            const AddTransactions(tabbarIndex: 1), //TODO
                            transition: Transition.rightToLeft,
                          );
                        },
                        backgroundColor: Colors.white,
                        child: const Icon(
                          Icons.add,
                          color: Color(0xff051532),
                        ),
                      ),
                      body: Container(
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
                        constraints: const BoxConstraints(),
                        child: FutureBuilder(
                          future: getexpense,
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
                                              itemBuilder: (_, int index) {
                                                return BillList(
                                                  width: width,
                                                  height: height,
                                                  isIncome: false,
                                                  billAmount: snapshot
                                                      .data[index]['amount']
                                                      .toString(),
                                                  billName: snapshot.data[index]
                                                      ['title'],
                                                  billTime: snapshot.data[index]
                                                      ['date'],
                                                  billDesc: snapshot.data[index]
                                                      ['description'],
                                                  id: snapshot.data[index]['id']
                                                      .toString(),
                                                );
                                              },
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
                    ),

                    // SizedBox(
                    //   height: height / 1,
                    //   child: ListView.builder(
                    //     itemCount: bill.length,
                    //     itemBuilder: (_, int index) {
                    //       return BillList(
                    //         width: width,
                    //         height: height,
                    //         billAmount: amount[index],
                    //         billName: bill[index],
                    //         billTime: date[index],
                    //       );
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BillList extends StatelessWidget {
  const BillList({
    Key? key,
    required this.width,
    required this.height,
    required this.billAmount,
    required this.billName,
    required this.billTime,
    required this.isIncome,
    required this.billDesc,
    required this.id,
  }) : super(key: key);

  final double width;
  final double height;
  final String billName;
  final String billAmount;
  final String billTime;
  final bool isIncome;
  final String billDesc;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: width / 15),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: width / 15,
                  top: height * 0.025,
                  bottom: height * 0.025,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //!Check book icon
                    Image.asset('assets/icons/check1.png'),

                    //!Bill
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          billName,
                          style: const TextStyle(
                            color: AppColors.green,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: height * 0.007),
                        Text(
                          billTime,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),

                    //!Amount

                    Text(
                      '\$ $billAmount',
                      style: const TextStyle(
                        color: AppColors.yellow,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    //!View
                    GestureDetector(
                      onTap: () {
                        Get.to(
                          EditTransaction(
                            //?ERROR HERE
                            isIncome: isIncome ? true : false,
                            amount: billAmount,
                            category: billName,
                            desc: billDesc,
                            id: id,
                          ),
                          transition: Transition.rightToLeft,
                        );
                      },
                      child: const Text(
                        'View',
                        style: TextStyle(
                          color: AppColors.yellow,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
