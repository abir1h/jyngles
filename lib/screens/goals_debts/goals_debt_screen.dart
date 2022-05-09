import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jyngles/screens/goals_debts/add_goals.dart';
import 'package:jyngles/screens/goals_debts/edit_debts.dart';
import 'package:jyngles/screens/goals_debts/edit_goal.dart';
import 'package:jyngles/widgets/drawer.dart';
import '../../utils/colors.dart';
import '../../widgets/chat_icon_button.dart';
import '../../widgets/notification_icon_button.dart';

class GoalsDebtsScreen extends StatefulWidget {
  const GoalsDebtsScreen({
    Key? key,
    required this.fromBottomNav,
  }) : super(key: key);
  final bool fromBottomNav;

  @override
  State<GoalsDebtsScreen> createState() => _GoalsDebtsScreenState();
}

class _GoalsDebtsScreenState extends State<GoalsDebtsScreen>
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
            backgroundColor: AppColors.lightBlue,
            elevation: 2,
            title: Text(
              'Goals/Debt'.toUpperCase(),
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
              ChatIconButton(width: width),
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
                                  child: ListView.builder(
                                    itemCount: bill.length,
                                    itemBuilder: (_, int index) {
                                      return SingleChildScrollView(
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.to(
                                              const EditDebts(),
                                              transition:
                                                  Transition.rightToLeft,
                                            );
                                          },
                                          child: BillList(
                                            width: width,
                                            height: height,
                                            billAmount: amount[index],
                                            billName: bill[index],
                                            billTime: date[index],
                                          ),
                                        ),
                                      );
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
                                  child: ListView.builder(
                                    itemCount: bill.length,
                                    itemBuilder: (_, int index) {
                                      return SingleChildScrollView(
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.to(
                                              const EditGoals(),
                                              transition:
                                                  Transition.rightToLeft,
                                            );
                                          },
                                          child: BillList(
                                            width: width,
                                            height: height,
                                            billAmount: amount[index],
                                            billName: bill[index],
                                            billTime: date[index],
                                          ),
                                        ),
                                      );
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
  const BillList({
    Key? key,
    required this.width,
    required this.height,
    required this.billAmount,
    required this.billName,
    required this.billTime,
  }) : super(key: key);

  final double width;
  final double height;
  final String billName;
  final String billAmount;
  final String billTime;

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
                    //!Bill
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          billName,
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
                          '\$ $billAmount',
                          style: const TextStyle(
                            color: AppColors.yellow,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                        //!Pending button
                        SizedBox(height: height * 0.01),
                        Container(
                          height: height * 0.035,
                          width: width * 0.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: const Color(0xff0CA2BE),
                          ),
                          child: const Center(
                            child: Text(
                              'PENDING',
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
