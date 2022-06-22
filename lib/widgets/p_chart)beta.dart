import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:super_tooltip/super_tooltip.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../utils/colors.dart';

class pice_chart_home extends StatefulWidget {
  final  String needs,wants,savings;
  final Color bgcolor;

  const pice_chart_home({
    Key? key,
    this.bgcolor = AppColors.chatBackgroundColor,required this.needs,required this.wants,required this.savings
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<pice_chart_home> {
  final tooltipController = JustTheController();

  int touchedIndex = -1;
  // var tooltip = SuperTooltip(popupDirection: TooltipDirection.left,
  //   top: 50.0,
  //   right: 5.0,
  //   left: 100.0,
  //   showCloseButton: ShowCloseButton.outside,
  //   hasShadow: false,
  //   content: new Material(
  //       child: Padding(
  //         padding: const EdgeInsets.all(0.0),
  //         child: Text(
  //           "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, "
  //               "sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, "
  //               "sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. ",
  //           softWrap: true,
  //         ),
  //       )),
  // );
  TooltipBehavior? _tooltipBehavior;
  @override
  void initState(){
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Tooltip(
        message: 'dfdafr',
        child: Card(
          elevation: 0,
          color: widget.bgcolor,
          child: AspectRatio(
            aspectRatio: 1,
            child: PieChart(
              PieChartData(

                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    tooltipBehavior: _tooltipBehavior;

                    Fluttertoast.showToast(
                      msg: "Double tap to see details",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black54,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                    setState(
                          () {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex =
                            pieTouchResponse.touchedSection!.touchedSectionIndex;

                      },
                    );
                  },
                ),
                borderData: FlBorderData(
                  show: false,
                ),


                sectionsSpace: 0,
                centerSpaceRadius: 40,
                sections: showingSections(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: AppColors.blue,
            value: double.parse(widget.wants.toString()),
            title: '',

            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );

        case 1:
          return PieChartSectionData(
            color: AppColors.yellow2,
            value: double.parse(widget.savings.toString()),
            title: '',
            radius: radius,
            // titleStyle: TextStyle(
            //   fontSize: fontSize,
            //   fontWeight: FontWeight.bold,
            //   color: const Color(0xffffffff),
            // ),
          );

        case 2:
          return PieChartSectionData(
            color: AppColors.red,
            value: double.parse(widget.needs.toString()),
            title: '',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          throw Error();
      }
    });
  }
}
