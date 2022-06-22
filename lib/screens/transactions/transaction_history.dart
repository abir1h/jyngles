import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jyngles/screens/edit_income_expense/edit_expance.dart';
import 'package:jyngles/screens/edit_income_expense/edit_income.dart';
import 'package:jyngles/screens/transactions/add_transaction2.dart';
import 'package:jyngles/utils/appurl.dart';
import 'package:jyngles/widgets/controller.dart';
import 'package:jyngles/widgets/custom_bottom_navigation.dart';
import 'package:jyngles/widgets/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/colors.dart';
import '../../widgets/chat_icon_button.dart';
import '../../widgets/notification_icon_button.dart';
import 'add_transactions.dart';
import 'package:http/http.dart'as http;

import 'edit_transaction.dart';
class TransactionHistory extends StatefulWidget {
  final int selected_index;
  const TransactionHistory({Key? key,required this.selected_index}) : super(key: key);

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
    _tabController = TabController(vsync: this, length: 2,initialIndex: widget.selected_index);
    getincome = getIncome();
    getexpense = getExpense();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  final MyHomePageController? controller = Get.put(MyHomePageController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: ()async{
        Get.to(()=>CustomBottomNavigationBar());
        return true;
      },
      child: SafeArea(
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
                  height: height * 0.790,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      //!Income page
                      Scaffold(
                        backgroundColor: Colors.transparent,
                        floatingActionButtonLocation:
                        FloatingActionButtonLocation.centerFloat,
                        floatingActionButton: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FloatingActionButton(                        splashColor: AppColors.tabbarindicatorColor,

                            onPressed: () {
                              Get.to(()=>
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
                                            cat_id:  snapshot.data[index]['category_id']
                                                .toString(),
                                            catagory_name:snapshot.data[index]['service']['name'],tax:snapshot.data[index]['tax_amount'] ,image:snapshot.data[index]['service']['image']
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
                        FloatingActionButtonLocation.centerFloat,
                        floatingActionButton: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FloatingActionButton(                        splashColor: AppColors.tabbarindicatorColor,

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
                                            return BillList2(
                                              width: width,
                                              height: height,
                                              billAmount: snapshot.data[index]
                                              ['amount']
                                                  .toString(),
                                              billName: snapshot.data[index]['service']['name'].toString(),
                                              billTime: snapshot.data[index]
                                              ['date'],
                                              billDesc: snapshot.data[index]
                                              ['description'],
                                              id: snapshot.data[index]['id']
                                                  .toString(),
                                              cat_id:  snapshot.data[index]['category_id']
                                                  .toString(),
                                              catagory_name:snapshot.data[index]['service']['name'],type:snapshot.data[index]['type'] ,image:snapshot.data[index]['service']['image']
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
      ),
    );
  }
}
class BillList extends StatefulWidget {
  const BillList({
    Key? key,
    required this.width,
    required this.height,
    required this.billAmount,
    required this.billName,
    required this.billTime,
    required this.billDesc,
    required this.cat_id,
    required this.tax,
    required this.id,
    required this.catagory_name,
    required this.image,
  }) : super(key: key);

  final double width;
  final double height;
  final String billName;
  final String billAmount;
  final String billTime;
  final String billDesc;
  final String id;
  final String cat_id;
  final String tax;
  final String catagory_name;
  final String image;

  @override
  State<BillList> createState() => _BillListState();
}

class _BillListState extends State<BillList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: widget.height * 0.025,
                  bottom: widget.height * 0.025,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //!Check book icon
                    Image.network(AppUrl.picurl+widget.image,height: 30,width: 30,),

                    //!Bill
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
    widget.billName.length > 20 ? '${widget.billName.substring(0, 12)}......' : widget.billName,
                          style: const TextStyle(
                            color: AppColors.green,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: widget.height * 0.007),
                        Text(
                          widget.billTime,
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
                      '\$ ${widget.billAmount}',
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
                          edit_inc(
                            //?ERROR HERE
                            date: widget.billTime ,

                            catagory_id:widget.cat_id ,
                            amount: widget.billAmount,
                            category: widget.billName,
                            desc: widget.billDesc,
                            id: widget.id,tax: widget.tax,
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
          width: widget.width,
          color: AppColors.horizontalbarColor,
        ),
      ],
    );
  }
}
class BillList2 extends StatefulWidget {
  const BillList2({
    Key? key,
    required this.width,
    required this.height,
    required this.billAmount,
    required this.billName,
    required this.billTime,
    required this.billDesc,
    required this.cat_id,
    required this.type,
    required this.id,
    required this.catagory_name,    required this.image,

  }) : super(key: key);

  final double width;
  final double height;
  final String billName;
  final String billAmount;
  final String billTime;
  final String billDesc;
  final String id;
  final String cat_id;
  final String type;
  final String catagory_name;
  final String image;

  @override
  State<BillList2> createState() => _BillList2State();
}

class _BillList2State extends State<BillList2> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: widget.width / 15),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: widget.width / 15,
                  top: widget.height * 0.025,
                  bottom: widget.height * 0.025,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //!Check book icon
                    Image.network(AppUrl.picurl+widget.image,height: 30,width: 30,),

                    //!Bill
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
    widget.billName.length> 20 ? '${widget.billName.substring(0, 12)}......' : widget.billName,
                          style: const TextStyle(
                            color: AppColors.green,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: widget.height * 0.007),
                        Text(
                          widget.billTime,
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
                      '\$ ${widget.billAmount}',
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
                          exit_exp(
                            //?ERROR HERE
                            date: widget.billTime ,

                            catagory_id:widget.cat_id ,
                            amount: widget.billAmount,
                            category: widget.catagory_name,
                            desc: widget.billDesc,
                            id: widget.id,tax: widget.type,
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
          width: widget.width,
          color: AppColors.horizontalbarColor,
        ),
      ],
    );
  }
}

