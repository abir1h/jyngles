import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jyngles/screens/calendar/c4.dart';
import 'package:jyngles/screens/calendar/c5.dart';

import '../../utils/colors.dart';

class C2 extends StatefulWidget {
  const C2({Key? key}) : super(key: key);

  @override
  State<C2> createState() => _C2State();
}

class _C2State extends State<C2> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    List<String> bill = [
      'Electricity Bill',
      'Maid Bill',
      'Water Bill',
      'Internet Bill'
    ];
    List<String> time = ['06:00 pm', '07:00 pm', '08:00 pm', '09:00 pm'];
    List<String> amount = [
      '2000',
      '3000',
      '1000',
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
              '17 June 2022',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: height / 1,
                  child: ListView.builder(
                    itemCount: bill.length,
                    itemBuilder: (_, int index) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => const C5());
                        },
                        child: BillList(
                          width: width,
                          height: height,
                          billAmount: amount[index],
                          billName: bill[index],
                          billTime: time[index],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.to(() => const C4());
            },
            backgroundColor: Colors.white,
            child: const Icon(
              Icons.add,
              color: AppColors.chatBackgroundColor,
              size: 50,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
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
                          style:const TextStyle(
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
                      style:const TextStyle(
                        color: AppColors.yellow,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    //!Edit
                   const Text(
                      'Edit',
                      style: TextStyle(
                        color: AppColors.yellow,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
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
