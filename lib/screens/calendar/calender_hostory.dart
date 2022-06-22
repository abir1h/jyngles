import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:jyngles/screens/calendar/add_calendar.dart';
import 'package:jyngles/utils/appurl.dart';
import 'package:jyngles/widgets/controller.dart';
import 'package:jyngles/widgets/custom_bottom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/colors.dart';
import '../../widgets/chat_icon_button.dart';
import '../../widgets/drawer.dart';
import '../../widgets/notification_icon_button.dart';
import 'c4.dart';
import 'package:http/http.dart'as http;

import 'edit_calender.dart';
class calender_history extends StatefulWidget {
  const calender_history({Key? key}) : super(key: key);

  @override
  State<calender_history> createState() => _calender_historyState();
}

class _calender_historyState extends State<calender_history> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  String? filter_date;
  Future? slide;
  Future<List<dynamic>> emergency() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"
    };

    var response = await http.get(Uri.parse(AppUrl.calender_show),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      print('Get post collected' + response.body);
      var userData1 = jsonDecode(response.body)['data'];
      print(userData1);
      return userData1;
    } else {
      var userData1 = jsonDecode(response.body)['data'];
      print(userData1);
      return userData1;    }
  }
  StreamController? _streamController;
  Stream? _stream;
  TextEditingController _controller = TextEditingController();

  Timer? _debounce;
  var date;
  _search(String date_) async {
    print(date_);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    Map<String, String> requestHeaders = {'authorization': "Bearer $token"};

    String controller = date_;
    _streamController!.add("waiting");
    var response = await get(
        Uri.parse(AppUrl.calender_show_search + controller),
        headers: requestHeaders);
    print('search');
    print(json.decode(response.body));

    _streamController!.add(json.decode(response.body)['data']);
  }
  String? date_Time; DateTime selectedDate = DateTime.now();
  TimeOfDay currentTime = TimeOfDay.now();
  Future<void> selectDate(BuildContext context) async {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1930),
      lastDate: DateTime(2025),
    ).then(
          (date) {
        setState(
              () {
            selectedDate = date!;
            String formattedDate =
            DateFormat('yyyy-MM-dd').format(selectedDate);
            filter_date=formattedDate;
            if (_debounce?.isActive ?? false) _debounce!.cancel();
            _debounce = Timer(const Duration(milliseconds: 1000), () {
              _search(formattedDate);
            });
          },
        );
      },
    );
  }final MyHomePageController? controller = Get.put(MyHomePageController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _streamController = StreamController();
    _stream = _streamController!.stream;
    _search( DateFormat('yyyy-MM-dd').format(DateTime.now()));
    slide=emergency();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
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
      child: Scaffold(    floatingActionButtonLocation:
      FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          splashColor: AppColors.tabbarindicatorColor,
          onPressed: () {
            Get.to(
              const C4(),
              transition: Transition.rightToLeft,
            );
          },
          backgroundColor: Colors.white,
          child: const Icon(
            Icons.add,
            color: Color(0xff051532),
          ),
        ),
        key: _key,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: controller!.change_color.value,
          elevation: 2,
          title: Text(
            'calendar'.toUpperCase(),
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          leading:IconButton(onPressed: (){
            Get.to(()=>CustomBottomNavigationBar());
          },icon:Icon(Icons.arrow_back_outlined),color: Colors.black,),

          centerTitle: true,
          actions: [
            NotificationIconButton(width: width),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: (){
                  selectDate(context);

                },
                child: Container(
                  width: width,
                  height: height/25,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),child: Center(child: filter_date==null?Text( DateFormat('yyyy-MM-dd').format(DateTime.now()).toString()):Text( filter_date.toString())),
                ),
              ),

              Container(
                margin: const EdgeInsets.all(8.0),
                child: StreamBuilder(
                  stream: _stream,
                  builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return               Container(
                          constraints: BoxConstraints(),
                          child: FutureBuilder(
                              future: slide,
                              builder: (_, AsyncSnapshot snapshot) {
                                print(snapshot.data);
                                switch (snapshot.connectionState) {
                                  case ConnectionState.waiting:
                                    return SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context).size.height,
                                      child: Shimmer.fromColors(
                                        baseColor: Colors.grey.withOpacity(.3),
                                        highlightColor:  Colors.grey.withOpacity(.1),
                                        child: ListView.builder(
                                          physics: AlwaysScrollableScrollPhysics(),
                                          itemBuilder: (_, __) => Padding(
                                            padding: const EdgeInsets.only(bottom: 8.0),
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
                                                        padding: EdgeInsets.symmetric(
                                                            vertical: 2.0),
                                                      ),
                                                      Container(
                                                        width: double.infinity,
                                                        height: 8.0,
                                                        color: Colors.white,
                                                      ),
                                                      const Padding(
                                                        padding: EdgeInsets.symmetric(
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
                                          ? snapshot.data.length > 0
                                          ? Container(
                                        height: height / 1.2,
                                        child:ListView.builder(
                                            physics: NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: snapshot.data.length,

                                            itemBuilder: (_,index){
                                              return  Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Container(
                                                    width: width,
                                                    decoration: BoxDecoration(
                                                      color: Colors.transparent,
                                                      borderRadius: BorderRadius.circular(8),
                                                      // boxShadow: [
                                                      //   BoxShadow(
                                                      //     color: Colors.grey.withOpacity(0.2),
                                                      //     spreadRadius: 2,
                                                      //     blurRadius: 5,
                                                      //     offset: Offset(
                                                      //         0, 3), // changes position of shadow
                                                      //   ),],
                                                    ),
                                                    child:  Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Image.asset(
                                                          'assets/images/salary.png',height: 30,width: 30,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(snapshot.data[index]['title'],style: TextStyle(color: AppColors.textColor2),),
                                                            Text(snapshot.data[index]['date'],style: TextStyle(color: AppColors.textColor2),),
                                                            Text(snapshot.data[index]['time'],style: TextStyle(color: AppColors.textColor2),),
                                                          ],
                                                        ),
                                                        Text('${controller!.count.value}'+snapshot.data[index]['amount'].toString(),style: TextStyle(color: AppColors.container2),),
                                                        InkWell(
                                                            onTap: (){
                                                              Get.to(()=>calendar_edit(ammount: snapshot.data[index]['amount'].toString(),id: snapshot.data[index]['id'].toString(),

                                                                title: snapshot.data[index]['title'].toString(),date: snapshot.data[index]['date'],time_: snapshot.data[index]['time'],
                                                              ));
                                                            },
                                                            child: Text('Edit',style: TextStyle(color: AppColors.container2),)),
                                                      ],
                                                    )
                                                ),
                                              );
                                            }),
                                      )
                                          : Center(
                                          child: Column(
                                            children: [
                                              SizedBox(height: height * 0.1),
                                              Image.asset('assets/images/emoji.png'),
                                              SizedBox(height: height * 0.05),
                                              const Text(
                                                'You have not added yet!',
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
                                                    const C4(),
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
                                                      'ADD',
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
                                          ))
                                          : Text('No data');
                                    }
                                }
                                return CircularProgressIndicator();
                              }));

                    }

                    if (snapshot.data == "waiting") {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.withOpacity(.3),
                          highlightColor: Colors.grey.withOpacity(.1),
                          child: ListView.builder(
                            itemBuilder: (_, __) => Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: 48.0,
                                    height: 48.0,
                                    color: Colors.white,
                                  ),
                                  const Padding(
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 8.0),
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
                                          EdgeInsets.symmetric(vertical: 2.0),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 8.0,
                                          color: Colors.white,
                                        ),
                                        const Padding(
                                          padding:
                                          EdgeInsets.symmetric(vertical: 2.0),
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
                    }

                    return     snapshot.data.length>0?         Container(
                      height: height / 1.2,
                      child:ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,

                          itemBuilder: (_,index){
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width: width,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(8),
                                    // boxShadow: [
                                    //   BoxShadow(
                                    //     color: Colors.grey.withOpacity(0.2),
                                    //     spreadRadius: 2,
                                    //     blurRadius: 5,
                                    //     offset: Offset(
                                    //         0, 3), // changes position of shadow
                                    //   ),],
                                  ),
                                  child:  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        'assets/images/salary.png',height: 30,width: 30,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(snapshot.data[index]['title'],style: TextStyle(color: AppColors.textColor2),),
                                          Text(snapshot.data[index]['time'],style: TextStyle(color: AppColors.textColor2),),
                                        ],
                                      ),
                                      Text('${controller!.count.value}'+snapshot.data[index]['amount'].toString(),style: TextStyle(color: AppColors.container2),),
                                      InkWell(
                                          onTap: (){
                                            Get.to(()=>calendar_edit(ammount: snapshot.data[index]['amount'].toString(),id: snapshot.data[index]['id'].toString(),

                                              title: snapshot.data[index]['title'].toString(),date: snapshot.data[index]['date'],time_: snapshot.data[index]['time'],
                                            ));
                                          },
                                          child: Text('Edit',style: TextStyle(color: AppColors.container2),)),
                                    ],
                                  )
                              ),
                            );
                          }),
                    ):Center(
                        child: Column(
                          children: [
                            SizedBox(height: height * 0.1),
                            Image.asset('assets/images/emoji.png'),
                            SizedBox(height: height * 0.05),
                            const Text(
                              'You have not added yet!',
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
                                  const C4(),
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
                                    'ADD',
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
                        ));

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
