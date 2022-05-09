import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

class PieChartSample2 extends StatefulWidget {
  final Color bgcolor;

  const PieChartSample2({
    Key? key,
    this.bgcolor = AppColors.chatBackgroundColor,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<PieChartSample2> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Card(
        elevation: 0,
        color: widget.bgcolor,
        child: AspectRatio(
          aspectRatio: 1,
          child: PieChart(
            PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
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
            value: 23,
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
            value: 20,
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
            value: 50,
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
