import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePageController extends GetxController {
  var count = '\$'.obs;
  change(String currency){
    count=currency.obs;
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    get_Dafult_color();
  }
  get_Dafult_color()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? colors_ = prefs.getInt('color');
    colors_!=null?change_color=Color(colors_).obs:change_color=Color(0xffDBECFF).obs;
    Change_Color(change_color);
  }
  Change_Color(Color color){
    change_color=color.obs;

  }
  var change_color;

}