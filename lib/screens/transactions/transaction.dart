import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jyngles/screens/transactions/add_transaction2.dart';
import 'package:jyngles/widgets/drawer.dart';

import '../../utils/colors.dart';
import '../../widgets/chat_icon_button.dart';
import '../../widgets/notification_icon_button.dart';

class Transactions extends StatefulWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
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
          key: _key,
          drawer: CustomDrawer(height: height, width: width),
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: AppColors.lightBlue,
            elevation: 2,
            title: const Text(
              'TRANSACTIONS',
              style: TextStyle(
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
              ChatIconButton(width: width),
              NotificationIconButton(width: width),
            ],
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
                      //!Income Page
                      Column(
                        children: [
                          SizedBox(height: height * 0.1),
                          Image.asset('assets/images/emoji.png'),
                          SizedBox(height: height * 0.05),
                          const Text(
                            'There is no transactions to show , please add your\ntransactions.',
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
                                const AddTransactions2(),
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
                                  'Add Income',
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

                      //!Expanse page
                      Column(
                        children: [
                          SizedBox(height: height * 0.1),
                          Image.asset('assets/images/emoji.png'),
                          SizedBox(height: height * 0.05),
                          const Text(
                            'There is no transactions to show , please add your\ntransactions.',
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
                                const AddTransactions2(),
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
                                  'Add Expence',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
