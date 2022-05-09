import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: AppColors.lightBlue,
            elevation: 0,
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
            title: const Text(
              'SM Shahriar Islam',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: width / 20),
                child: SvgPicture.asset(
                  'assets/icons/notification_on.svg',
                  color: Colors.black,
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: height * 0.01),
                //!Chat tile
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: height * 0.75,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ChatTile(width: width, height: height),
                            ChatTile(
                                width: width, height: height, isSender: false),
                            ChatTile(
                                width: width, height: height, isSender: false),
                            ChatTile(width: width, height: height),
                            ChatTile(width: width, height: height),
                            ChatTile(width: width, height: height),
                            ChatTile(
                                width: width, height: height, isSender: false),
                            ChatTile(
                                width: width, height: height, isSender: false),
                          ],
                        ),
                      ),
                    ),

                    //!Send Section
                    Container(
                      decoration: BoxDecoration(
                        // color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: width * 0.02),
                              child: const Icon(
                                Icons.image,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                            Container(
                              height: height * 0.07,
                              width: width * 0.65,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: height * 0.065,
                              width: width * 0.12,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.send,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChatTile extends StatelessWidget {
  const ChatTile({
    Key? key,
    required this.width,
    required this.height,
    this.isSender = true,
  }) : super(key: key);

  final double width;
  final double height;
  final bool isSender;

  @override
  Widget build(BuildContext context) {
    return isSender
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(
                    'assets/images/sender.jpeg',
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                    color: AppColors.chatTextSenderBg.withOpacity(.2),
                  ),
                  height: height * 0.07,
                  width: width * 0.52,
                  child: Column(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 1, top: 2),
                        child: Text(
                          'Lorem ipsum dolor sit amet, consectetur\ndipiscing elit. Ultricies sed hendrerit ac\nmollis sollicitudin viverra',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.all(3),
                          child: Text(
                            '12:19PM',
                            style: TextStyle(
                              color: AppColors.disabledTextColor,
                              fontSize: 8,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        :
        //! isSender = false
        Padding(
            padding: EdgeInsets.only(left: width * 0.34, top: 8, bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                      topLeft: Radius.circular(12),
                    ),
                    color: Color(0xff7E7E7E),
                  ),
                  height: height * 0.07,
                  width: width * 0.52,
                  child: Column(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 1, top: 2),
                        child: Text(
                          'Lorem ipsum dolor sit amet, consectetur\ndipiscing elit. Ultricies sed hendrerit ac\nmollis sollicitudin viverra',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.all(3),
                          child: Text(
                            '12:19PM',
                            style: TextStyle(
                              color: AppColors.disabledTextColor,
                              fontSize: 8,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(
                    'assets/images/profilepic.png',
                  ),
                ),
              ],
            ),
          );
  }
}
