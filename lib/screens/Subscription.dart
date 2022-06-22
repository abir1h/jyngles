import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:jyngles/utils/appurl.dart';
import 'package:jyngles/utils/colors.dart';
import 'package:http/http.dart'as http;
import 'package:jyngles/widgets/controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class subscription extends StatefulWidget {
  @override
  _subscriptionState createState() => _subscriptionState();
}

class _subscriptionState extends State<subscription> {
  final MyHomePageController? controller = Get.put(MyHomePageController());
  Future? pacakage;
  Future showpackage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"
    };

    var response =
    await http.get(Uri.parse(AppUrl.package), headers: requestHeaders);
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
    pacakage=showpackage();
  }
  @override
  Widget build(BuildContext context) { final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: controller!.change_color.value,
        title: const Text(
          'Package Subscription',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            // _key.currentState!.openDrawer();
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
        child: Column(
          children: [
            Container(
                constraints: BoxConstraints(),
                child: FutureBuilder(
                    future: pacakage,
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
                                ?                                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 25,),
                                  Center(child: Icon(Icons.account_balance,color: Colors.greenAccent,size: 60,)),
                                  Text("Let's Get Lit with advance features",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
                                  SizedBox(height: 15,),
                                  Text("Upgrade to enjoy infinite",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 14),),
                                  Text("functionaries and give us a hand",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 14),),
                                  Text("to create exciting app features for",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 14),),

                                  Text("you",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 14),),
                                  SizedBox(height: 30,),

                                  Text('${controller!.count.value}'+' '+snapshot.data[0]['price'].toString()+" "+snapshot.data[0]['title'],style: TextStyle(color: Colors.black,fontSize: 24),),
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child:  Html(data:  snapshot.data[0]['description'],shrinkWrap: true,

                                          style: {
                                            "body": Style(

                                            ),
                                          },
                                        ),
                                      )),
                                  InkWell(
                                    onTap: ()async{
                                      await makePayment();

                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.greenAccent,
                                          borderRadius: BorderRadius.circular(10)
                                      ),child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Subscribe Now!!!",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                    ),
                                    ),
                                  )


                                ],
                              ),
                            )






                          : Column(
                              children: [
                                SizedBox(height: height/3,),
                                CircularProgressIndicator(),
                                Center(child: Text('Checking Network Connectivity!1',style: TextStyle(fontWeight: FontWeight.bold),)),

                              ],
                            );
                          }
                      }
                      return CircularProgressIndicator();
                    })),

          ],
        ),
      ),

    ));
  }Map<String, dynamic>? paymentIntentData;

  Future<void> makePayment() async {
    try {

      paymentIntentData =
      await createPaymentIntent('5', 'USD'); //json.decode(response.body);
      // print('Response body==>${response.body.toString()}');
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntentData!['client_secret'],
              applePay: true,
              googlePay: true,
              testEnv: true,
              style: ThemeMode.dark,
              merchantCountryCode: 'US',
              merchantDisplayName: 'LIT')).then((value){
      });


      ///now finally display payment sheeet
      // withdraw();
      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {

    try {
      await Stripe.instance.presentPaymentSheet(
          parameters: PresentPaymentSheetParameters(
            clientSecret: paymentIntentData!['client_secret'],

            confirmPayment: true,
          )).then((newValue){


        print('payment intent'+paymentIntentData!['id'].toString());
        print('payment intent'+paymentIntentData!['client_secret'].toString());
        print('payment intent'+paymentIntentData!['amount'].toString());
        print('payment intent'+paymentIntentData.toString());
        //orderPlaceApi(paymentIntentData!['id'].toString());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("paid successfully")));
        // withdraw();
        paymentIntentData = null;

      }).onError((error, stackTrace){
        print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$error")));

      });


    } on StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
            content: Text("Cancelled "),
          ));
    } catch (e) {
      print('$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
            'Bearer sk_test_51L0i1BSChOU0ArmZqIyTrtA5Jo2Q3H9lzKqtFYaPDbXb1dmQTqTQJzv1jPIMrM7W0lnu2cFJ9qWyupROgeC975L000PrtCz3jz',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100 ;
    return a.toString();
  }
}
