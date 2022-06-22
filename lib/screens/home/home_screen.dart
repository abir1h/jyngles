import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jyngles/screens/home/chart_screen.dart';
import 'package:jyngles/utils/appurl.dart';
import 'package:jyngles/utils/colors.dart';
import 'package:jyngles/widgets/controller.dart';
import 'package:jyngles/widgets/p_chart)beta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_tooltip/super_tooltip.dart';
import '../../widgets/chat_icon_button.dart';
import '../../widgets/drawer.dart';
import '../../widgets/notification_icon_button.dart';
import '../../widgets/pie_chart.dart';
import '../transactions/add_transactions.dart';
import 'package:http/http.dart'as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  var tooltip = SuperTooltip(
    popupDirection: TooltipDirection.up,
    top: 50.0,
    right: 5.0,
    left: 100.0,
    showCloseButton: ShowCloseButton.outside,
    hasShadow: false,
    content: new Material(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Text(
            "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, "
                "sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, "
                "sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. ",
            softWrap: true,
          ),
        )),
  );
bool getdata=false;
Future? myfuture;
  Future getpost() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"
    };

    var response = await http.get(Uri.parse(AppUrl.home),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      print('Get post collected' + response.body);
      var userData1 = jsonDecode(response.body)['data']['dataExpense'];
      var userData2 = jsonDecode(response.body)['data'];

      setState(() {
        getdata=true;
        wants=userData2['wantToPercentange'];
        need=userData2['needToPercentange'];
        sav=userData2['savingToPercentange'];
        n2=userData2['needToBe'];
        w1=userData2['wantToBe'];
        s2=userData2['savingToBe'];
        total_income=userData2['dataIncome'].toString();
        totalsaveings=userData2['dataSaving'].toString();
        totalexpense=userData2['dataExpense2'].toString();
      });
      return userData1;
    } else {
      print("post have no Data${response.body}");
    }
  }
  var n2,w1,s2;
  var total_income,totalsaveings,totalexpense;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myfuture=getpost();
  }  final MyHomePageController? controller = Get.put(MyHomePageController());

  var wants,need,sav;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _key,
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: GestureDetector(
        onTap: () {
          Get.to(() => const AddTransactions(
            tabbarIndex: 0,
          ));
        },
        child: SvgPicture.asset(
          'assets/icons/plus.svg',
        ),
      ),
      appBar: AppBar(
        title: const Text(
          'HOME',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor:  controller!.change_color.value,
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
          // ChatIconButton(width: width),
          NotificationIconButton(width: width),
        ],
      ),
      drawer: CustomDrawer(height: height, width: width),
      body: SingleChildScrollView(
        // physics: const NeverScrollableScrollPhysics(),
        child: getdata==true?Container(
          height: height/1,
          child: Column(
            children: [
              Container(
                  constraints: BoxConstraints(),
                  child: FutureBuilder(
                      future: myfuture,
                      builder: (_, AsyncSnapshot snapshot) {
                        print(snapshot.data);
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return  Column(
                              children: [
                                SizedBox(height: height/2,),
                                Center(child:CircularProgressIndicator()),
                              ],
                            );
                          default:
                            if (snapshot.hasError) {
                              Text('Error: ${snapshot.error}');
                            } else {
                              return snapshot.hasData
                                  ?
                            Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Container(
                                        height: (height * 0.5) - AppBar().preferredSize.height,
                                        width: width,
                                        color: AppColors.chatBackgroundColor,
                                        child: Column(
                                          children: [
                                            SizedBox(height: height * 0.03),
                                            //!Needs, Wants, Savings

                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height: height * 0.012,
                                                        width: width * 0.05,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(2),
                                                          color: AppColors.red,
                                                        ),
                                                      ),

                                                      const Text(
                                                        ' Needs (50%) ',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                        Expanded(
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height: height * 0.012,
                                                        width: width * 0.05,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(2),
                                                          color: AppColors.blue,
                                                        ),
                                                      ),

                                                      const Text(
                                                        ' Wants(30%) ',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height: height * 0.012,
                                                        width: width * 0.05,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(2),
                                                          color: AppColors.yellow2,
                                                        ),
                                                      ),

                                                      InkWell(
                                                        onTap: (){
                                                        },
                                                        child: const Text(
                                                          ' Savings(20%) ',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            // Container(
                                            //   height: 10,width: 10,
                                            //   color: Colors.green,
                                            // ),

                                            //!Pie Chart
                                            InkWell(

                                              onDoubleTap: () {
                                                Get.to(()=>
                                                   ChartScreen(),
                                                  transition: Transition.zoom,
                                                );
                                              },
                                              child:  Container(
                                                  child: pice_chart_home(needs: need.toString(), wants:  wants.toString(), savings: sav.toString())),
                                            ),
                                          ],
                                        ),
                                      ),

                                      //!Indicators
                                      Positioned(
                                        top: height * 0.1,
                                        left: width * 0.68,
                                        child: Column(
                                          children: [
                                            Container(
                                              height: height * 0.0255,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(7),
                                                color: AppColors.chatBackgroundColor,
                                                border: Border.all(color: AppColors.red),
                                              ),
                                              child:  Center(
                                                child: Text(
                                                 need.toStringAsFixed(1).toString()+'%',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Text(n2!=null?'${controller!.count.value}'+n2.toStringAsFixed(1).toString():'..',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)

                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        top: height * 0.3,
                                        left: width * 0.7,
                                        child: Column(
                                          children: [
                                            Container(
                                              height: height * 0.0255,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(7),
                                                color: AppColors.chatBackgroundColor,
                                                border: Border.all(color: AppColors.blue),
                                              ),
                                              child:  Center(
                                                child: Text(
                                                  wants.toStringAsFixed(1).toString()+'%',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Text(w1!=null?'${controller!.count.value}'+w1.toStringAsFixed(1).toString():'..',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        top: height * 0.3,
                                        left: width * 0.2,
                                        child: Column(
                                          children: [
                                            Container(
                                              height: height * 0.0255,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(7),
                                                color: AppColors.chatBackgroundColor,
                                                border: Border.all(color: AppColors.yellow2),
                                              ),
                                              child:  Center(
                                                child: Text(
                                                  sav.toStringAsFixed(1).toString()+'%',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Text(s2!=null?'${controller!.count.value}'+s2.toStringAsFixed(1).toString():'..',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)

                                          ],
                                        ),
                                      ),

                                      //!3 boxes within a container
                                      Positioned(
                                        top: height * 0.37,
                                        left: width * 0.05,
                                        child: Column(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                                              height: height * 0.13,
                                              width: width * 0.9,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(14),
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.withOpacity(0.5),
                                                    spreadRadius: 2,
                                                    blurRadius: 7,
                                                    offset:
                                                    const Offset(0, 0), // changes position of shadow
                                                  ),
                                                ],
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [

                                                    CustomContainer(
                                                      height: height,
                                                      width: width,
                                                      color: AppColors.green,
                                                      image: 'assets/icons/in.png',
                                                      text: '${controller!.count.value}'+total_income.toString()+'\nTotal Income',
                                                    ),
                                                    SizedBox(width: 5,),
                                                    CustomContainer(
                                                      height: height,
                                                      width: width,
                                                      color: AppColors.bottomNavColor,
                                                      image: 'assets/icons/out.png',
                                                      text: '${controller!.count.value}'+totalexpense.toString()+'\nTotal Expense',
                                                    ),                                                SizedBox(width: 5,),

                                                    CustomContainer(
                                                      height: height,
                                                      width: width,
                                                      color: AppColors.container2,
                                                      image: 'assets/icons/piggibank.png',
                                                      text: '${controller!.count.value}'+totalsaveings.toString()+'\nTotal Savings',
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: height * 0.08),
                                  //!Down portion
                                  Stack(
                                    children: [
                                      //?Worling well
                                      // Positioned(
                                      //   top: height * 0.18,
                                      //   child: GestureDetector(
                                      //     onTap: () {
                                      //       Get.to(() => const AddTransactions(
                                      //         tabbarIndex: 0,
                                      //       ));
                                      //     },
                                      //     child: SvgPicture.asset(
                                      //       'assets/icons/plus.svg',
                                      //     ),
                                      //   ),
                                      // ),

                                      //!Recent Transactions
                                      Padding(
                                        padding:
                                        EdgeInsets.only(left: width * 0.11, right: width * 0.11),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: const [
                                                Text(
                                                  'Recent Expenses',
                                                  style: TextStyle(
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),

                                            //!Shopping
                                            SizedBox(height: height * 0.02),

                                            SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    child: ListView.builder(
                                                      physics: NeverScrollableScrollPhysics(),
                                                        shrinkWrap: true,
                                                        itemCount: snapshot.data.length,

                                                        itemBuilder: (_,index){
                                                          return                                                 Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Image.network(AppUrl.picurl+ snapshot.data[index]['service']['image'],height: 40,width: 40,),

                                                                    SizedBox(width: width * 0.01),
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                      CrossAxisAlignment.start,
                                                                      children: [
                                                                         Text(
                                                                    snapshot.data[index]['title'].length > 20 ? '${ snapshot.data[index]['title'].substring(0, 12)}......' :  snapshot.data[index]['title'],
                                                                          style: TextStyle(
                                                                            fontSize: 18,
                                                                            fontWeight: FontWeight.w400,
                                                                          ),overflow: TextOverflow.ellipsis,

                                                                        ),
                                                                        SizedBox(height: height * 0.002),
                                                                         Text(
                                                                           snapshot.data[index]['date']
                                                                          ,
                                                                          style: TextStyle(
                                                                            fontSize: 12,
                                                                            fontWeight: FontWeight.w400,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                                 Row(
                                                                   children: [

                                                                     Obx(() => Text('${controller!.count.value}',
                                                                       style: TextStyle(fontSize:16),),),
                                                                     Text(
                                                               ' '+ snapshot.data[index]['amount'].toString(),
                                                                      style: TextStyle(
                                                                        fontSize: 18,
                                                                        fontWeight: FontWeight.w400,
                                                                      ),
                                                                ),
                                                                   ],
                                                                 )
                                                              ],
                                                            ),
                                                          )
                                                          ;
                                                        }),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )



                                ],
                              )




                                  : Column(
                                children: [
                                  SizedBox(height: height/3,),
                                  CircularProgressIndicator(),
                                  Center(child: Text('',style: TextStyle(fontWeight: FontWeight.bold),)),

                                ],
                              );
                            }
                        }
                        return CircularProgressIndicator();
                      })),

            ],
          ),
        ):Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [SizedBox(height: height/3,),Center(child: CircularProgressIndicator()),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Please Wait!'),
            )],
        ),
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    Key? key,
    required this.height,
    required this.width,
    required this.color,
    required this.image,
    required this.text,
  }) : super(key: key);

  final double height;
  final double width;
  final Color color;
  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.2,
      width: width * 0.25,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: width * 0.023, top: height * 0.015),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.005),
            Image.asset(image),
            SizedBox(height: height * 0.007),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
