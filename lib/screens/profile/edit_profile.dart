import 'dart:convert';
import 'dart:io';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jyngles/screens/profile/profile_screen.dart';
import 'package:jyngles/utils/appurl.dart';
import 'package:jyngles/utils/colors.dart';
import 'package:jyngles/widgets/custom_bottom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({
    Key? key,
    required this.name,
    required this.email,
    required this.phone,
  }) : super(key: key);
  final String name;
  final String email;
  final String phone;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  var _image;
  ImagePicker picker = ImagePicker();

  Future takephoto_camera() async {
    XFile? image = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = File(image!.path);
    });
    //return image;
  }
  var val;
  Future takephoto_gallary() async {
    XFile? image = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = File(image!.path);
    });
    //return image;
  }
  Widget bottomSheetProfileEdit() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ignore: deprecated_member_use
              FlatButton.icon(
                icon: Icon(Icons.camera),
                label: Text("Camera"),
                onPressed: () {
                  takephoto_camera();
                  Navigator.pop(context);
                },
              ),
              // ignore: deprecated_member_use
              FlatButton.icon(
                  icon: Icon(Icons.image),
                  label: Text("Gallery"),
                  onPressed: () {
                    takephoto_gallary();
                    Navigator.pop(context);
                  }),
            ],
          ),
        ],
      ),
    );
  }
  saveprefs(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('username', name);

  }
  //!Edit Profile
  Future editProfile(
    String email,
    String phone,
    String username,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"
    };
    var request = await http.MultipartRequest(
      'POST',
      Uri.parse(AppUrl.editProfile),
    );
    request.fields.addAll({
      'email': email,
      'phone': phone,
      'username': username,
    });
    if (_image != null) {
      request.files.add(
          await http.MultipartFile.fromPath(
              'image', _image.path));
    }

    request.headers.addAll(requestHeaders);

    request.send().then((result) async {
      http.Response.fromStream(result).then((response) {
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);

          if (data['status_code'] == 200) {
            var data = jsonDecode(response.body)['data'];
            print(data);
            print('response.body ' + data.toString());

            Fluttertoast.showToast(
              msg:
                  "Profile Updated Successfully\nThe changes will take place on the next time you login",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.white,
              textColor: Colors.black,
              fontSize: 16.0,
            );saveprefs(data['username']);
            Get.offAll(
              () => const ProfileScreen(),
              transition: Transition.rightToLeft,
            );
          } else {
            print("post have no Data${response.body}");
            var data = jsonDecode(response.body);
            Fluttertoast.showToast(
              msg: data['message'],
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
          return response.body;
        }else{
          print(response.body);
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _phoneController.text=widget.phone;
    _emailController.text=widget.email;
    _nameController.text=widget.name;
  }
bool submit=false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.lightBlue,
        elevation: 2,
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: InkWell(
          onTap: () {
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25,),
            Center(
              child: Stack(
                children: [
                  CircularProfileAvatar(
                    'null',
                    child: _image != null
                        ? Image.file(
                      _image,
                      fit: BoxFit.cover,

                    ):Icon(Icons.person),
                    borderColor: Colors.blue,
                    borderWidth: 4,
                    elevation: 8,
                    radius: 50,
                  ),
                  Positioned(
                      top: 60,
                      left: 60,
                      child: CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: IconButton(
                              icon: Icon(
                                Icons.camera_alt,
                              ),
                              onPressed: () {

                                showModalBottomSheet(
                                    context: (context),
                                    builder: (builder) => bottomSheetProfileEdit());
                              })))
                ],
              ),
            ),

            SizedBox(height: height * 0.05),
            //!NAME
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Name',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.name,
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  Container(
                    width: width,
                    height: 1,
                    color: Colors.black,
                  )
                ],
              ),
            ),
            SizedBox(height: height * 0.03),
            //!EMAIL
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Email',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.email,
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  Container(
                    width: width,
                    height: 1,
                    color: Colors.black,
                  )
                ],
              ),
            ),
            //!PHONE
            SizedBox(height: height * 0.03),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Phone Number',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  TextField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.phone,
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  Container(
                    width: width,
                    height: 1,
                    color: Colors.black,
                  )
                ],
              ),
            ), //! Edit Button
            SizedBox(height: height * 0.03),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.buttonColorRed,
                      side: const BorderSide(
                        width: 0.5,
                        color: AppColors.buttonColorBlueBorder,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_nameController.text.isEmpty ||
                          _emailController.text.isEmpty ||
                          _phoneController.text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Please fill all the fields",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else {
                        editProfile(
                          _emailController.text,
                          _phoneController.text,
                          _nameController.text,
                        );
                      }
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.lightBlue,
                      side: const BorderSide(
                        width: 0.5,
                        color: AppColors.buttonColorBlueBorder,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
