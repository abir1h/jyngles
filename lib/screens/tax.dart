import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:jyngles/utils/appurl.dart';
import 'package:jyngles/utils/colors.dart';
import 'package:http/http.dart' as http;
import 'package:jyngles/widgets/controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class tax_zone extends StatefulWidget {
  @override
  _tax_zoneState createState() => _tax_zoneState();
}

class _tax_zoneState extends State<tax_zone> {
  final MyHomePageController? controller = Get.put(MyHomePageController());

  Future withdraw(String percentage) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"
    };
    var request = await http.MultipartRequest(
      'POST',
      Uri.parse(AppUrl.taxt_post),
    );
    request.fields.addAll({

'tax':percentage

    });


    request.headers.addAll(requestHeaders);

    request.send().then((result) async {
      http.Response.fromStream(result).then((response) {
        if (response.statusCode == 200) {


          setState(() {
            edit = false;
            myfuture=getpost();

          });
          Fluttertoast.showToast(
              msg: "Tax information updated Succesfully",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);


        }
        else {
          setState(() {
            edit = false;
          });
          print("Fail! ");
          print(response.body.toString());
          print(response.statusCode.toString());
          Fluttertoast.showToast(
              msg: "Error Occured",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          return response.body;
        }
      });
    });
  }
bool getdata=false;
  Future getpost() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"
    };

    var response = await http.get(Uri.parse(AppUrl.tax_show),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      print('Get post collected' + response.body);
      var userData1 = jsonDecode(response.body)['data'];

setState(() {
  getdata=true;
});
      return userData1;
    } else {
      print("post have no Data${response.body}");
    }
  }
  final _formKey = GlobalKey<FormState>();

  Future? myfuture;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myfuture=getpost();
  }
  TextEditingController tax_percent=TextEditingController();
  bool edit=false;
  @override
  Widget build(BuildContext context) {    final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.arrow_back),color: Colors.black,onPressed: (){Navigator.pop(context);},),

          backgroundColor: controller!.change_color.value,
          elevation: 2,
          title: Text(
            'Tax Information'.toUpperCase(),
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          // leading: GestureDetector(
          //   onTap: () {
          //     // _key.currentState!.openDrawer();
          //   },
          //   child: const Icon(
          //     Icons.sort,
          //     color: Colors.black,
          //   ),
          // ),
          centerTitle: true,

        ),
        body: SingleChildScrollView(
          child:   getdata==true?
            edit==false?Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
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
                               snapshot.data.length>0? Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text('Your Tax percentage ',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 22),)
                                    ),                                        Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(snapshot.data[0]['tax'].toString() + '%',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
                                    ),

                                    SizedBox(height: 10,),



                                  ],
                                ):Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
                                 children: [

                                   Padding(
                                       padding: const EdgeInsets.all(16.0),
                                       child: Text('Your Tax percentage ',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 22),)
                                   ),                                        Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: Text('Not updated Yet',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                                   ),

                                   SizedBox(height: 10,),



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
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){
                    setState(() {
                      edit=true;
                    });
                  },
                  child: Container(
                    width: width/3,

                    decoration: BoxDecoration(color: AppColors.sidebarColor1,borderRadius: BorderRadius.circular(8),),
                    child: Center(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Edit',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                    ),),
                  ),
                ),
              )

            ],
          ):
            Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: tax_percent,
                  inputFormatters: [
                                      new  FilteringTextInputFormatter.deny(RegExp("%")),
                                    ],
                  keyboardType: TextInputType.number,
                  validator: (v)=>v!.isEmpty?"Field is empty":null,
                  decoration:InputDecoration(
                    prefixIcon: Icon(Icons.money_off,color: AppColors.sidebarColor1,),
                    hintText: "Enter tax percentage ",
                    border: OutlineInputBorder()


                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){
if(_formKey.currentState!.validate()){
  withdraw(tax_percent.text);
}
                  },
                  child: Container(

                    decoration: BoxDecoration(color: AppColors.sidebarColor1,borderRadius: BorderRadius.circular(8),),
                    child: Center(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Submit',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                    ),),
                  ),
                ),
              )

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

      ),
    );
  }
}
