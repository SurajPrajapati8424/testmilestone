// ignore_for_file: camel_case_types, must_be_immutable
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../icons/svgs.dart';

class FlChart extends StatelessWidget {
  const FlChart({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fl Chart'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // LINE
            SizedBox(height: 20.w),
            SizedBox(height: 200.w, child: const LineChartSample_1()),
            SizedBox(height: 20.w),
            SizedBox(height: 200.w, child: const LineChartSample_1_2()),
            SizedBox(height: 20.w),
            SizedBox(height: 200.w, child: const LineChartSample_1_3()),
            SizedBox(height: 20.w),
            const LineChartSample_2(),
            SizedBox(height: 20.w),
            LineChartSample_4(),
            SizedBox(height: 20.w),
            const LineChartSample_5(),
            SizedBox(height: 20.w),
            LineChartSample_6(),
            SizedBox(height: 20.w),
            // BAR,
            SizedBox(height: 20.w),
            SizedBox(
                height: 200.w, width: 200.w, child: const BarChartSample_3()),
            SizedBox(height: 20.w),
            // PIE
            const PieChartSample_1(),
            SizedBox(height: 20.w),
            const PieChartSample_2(),
            SizedBox(height: 20.w),
            const PieChartSample_3(),
            SizedBox(height: 20.w),
            SizedBox(height: 20.w),
          ],
        ),
      ),
    );
  }
}

// Line
class LineChartSample_1 extends StatelessWidget {
  const LineChartSample_1({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineTouchData: lineTouchData1,
        gridData: gridData1,
        titlesData: titlesData1,
        borderData: borderData1,
        lineBarsData: lineBarsData1,
        minX: 0,
        maxX: 14,
        maxY: 4,
        minY: 0,
      ),
    );
  }

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (touchedSpot) => Colors.grey.shade300,
        ),
      );
  FlGridData get gridData1 => const FlGridData(show: false);
  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(sideTitles: bottomTitles),
        rightTitles:
            const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        leftTitles: AxisTitles(sideTitles: leftTitles()),
      );
  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 40,
      );
  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '1m';
        break;
      case 2:
        text = '2m';
        break;
      case 3:
        text = '3m';
        break;
      case 4:
        text = '5m';
        break;
      case 5:
        text = '6m';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );
  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('SEPT', style: style);
        break;
      case 7:
        text = const Text('OCT', style: style);
        break;
      case 12:
        text = const Text('DEC', style: style);
        break;
      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  FlBorderData get borderData1 => FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: Colors.red, width: 4),
          left: BorderSide(color: Colors.red, width: 4),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      );
  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_1,
        lineChartBarData1_2,
        lineChartBarData1_3,
      ];
  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
        isCurved: true,
        color: Colors.green,
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 1),
          FlSpot(3, 1.5),
          FlSpot(5, 1.4),
          FlSpot(7, 3.4),
          FlSpot(10, 2),
          FlSpot(12, 2.2),
          FlSpot(13, 1.8),
        ],
      );

  LineChartBarData get lineChartBarData1_2 => LineChartBarData(
        isCurved: true,
        color: Colors.pinkAccent,
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(
          show: false,
          color: Colors.pink,
        ),
        spots: const [
          FlSpot(1, 1),
          FlSpot(3, 2.8),
          FlSpot(7, 1.2),
          FlSpot(10, 2.8),
          FlSpot(12, 2.6),
          FlSpot(13, 3.9),
        ],
      );

  LineChartBarData get lineChartBarData1_3 => LineChartBarData(
        isCurved: true,
        color: Colors.cyan,
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 2.8),
          FlSpot(3, 1.9),
          FlSpot(6, 3),
          FlSpot(10, 1.3),
          FlSpot(13, 2.5),
        ],
      );
}

class LineChartSample_1_2 extends StatelessWidget {
  const LineChartSample_1_2({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineTouchData: lineTouchData2,
        gridData: gridData2,
        borderData: borderData2,
        lineBarsData: lineBarsData2,
        minX: 0,
        maxX: 14,
        maxY: 4,
        minY: 0,
      ),
    );
  }

  LineTouchData get lineTouchData2 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (touchedSpot) => Colors.white,
          tooltipBorder: const BorderSide(color: Colors.black, width: 0.5),
        ),
      );
  FlGridData get gridData2 => const FlGridData(show: true);
  FlBorderData get borderData2 => FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: Colors.red, width: 4),
          left: BorderSide(color: Colors.red, width: 4),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      );
  List<LineChartBarData> get lineBarsData2 => [
        lineChartBarData1_1,
        lineChartBarData1_2,
        lineChartBarData1_3,
      ];
  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
        isCurved: false,
        color: Colors.green,
        barWidth: 3,
        isStrokeCapRound: false,
        dotData: const FlDotData(show: true),
        belowBarData: BarAreaData(show: true),
        spots: const [
          FlSpot(1, 1),
          FlSpot(3, 1.5),
          FlSpot(5, 1.4),
          FlSpot(7, 3.4),
          FlSpot(10, 2),
          FlSpot(12, 2.2),
          FlSpot(13, 1.8),
        ],
      );

  LineChartBarData get lineChartBarData1_2 => LineChartBarData(
        isCurved: false,
        color: Colors.pinkAccent,
        barWidth: 3,
        isStrokeCapRound: false,
        dotData: const FlDotData(show: true),
        belowBarData: BarAreaData(
          show: true,
          color: Colors.pink.withOpacity(.2),
        ),
        spots: const [
          FlSpot(1, 1),
          FlSpot(3, 2.8),
          FlSpot(7, 1.2),
          FlSpot(10, 2.8),
          FlSpot(12, 2.6),
          FlSpot(13, 3.9),
        ],
      );

  LineChartBarData get lineChartBarData1_3 => LineChartBarData(
        isCurved: false,
        color: Colors.cyan,
        barWidth: 3,
        isStrokeCapRound: false,
        dotData: const FlDotData(show: true),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 2.8),
          FlSpot(3, 1.9),
          FlSpot(6, 3),
          FlSpot(10, 1.3),
          FlSpot(13, 2.5),
        ],
      );
}

class LineChartSample_1_3 extends StatelessWidget {
  const LineChartSample_1_3({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineTouchData: lineTouchData3,
        gridData: gridData3,
        titlesData: titlesData3,
        borderData: borderData3,
        lineBarsData: lineBarsData3,
        minX: 0,
        maxX: 14,
        maxY: 6,
        minY: 0,
      ),
    );
  }

  LineTouchData get lineTouchData3 => const LineTouchData(
        handleBuiltInTouches: false,
        // touchTooltipData: LineTouchTooltipData(
        //   getTooltipColor: (touchedSpot) => Colors.white,
        //   tooltipBorder: const BorderSide(color: Colors.black, width: 0.5),
        // ),
      );
  FlGridData get gridData3 => const FlGridData(show: true);
  FlBorderData get borderData3 => FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: Colors.red, width: 4),
          left: BorderSide(color: Colors.red, width: 4),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      );
  FlTitlesData get titlesData3 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );
  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );
  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 40,
      );
  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('SEPT', style: style);
        break;
      case 7:
        text = const Text('OCT', style: style);
        break;
      case 12:
        text = const Text('DEC', style: style);
        break;
      default:
        text = const Text('');
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '1m';
        break;
      case 2:
        text = '2m';
        break;
      case 3:
        text = '3m';
        break;
      case 4:
        text = '4m';
        break;
      case 5:
        text = '5m';
        break;
      case 6:
        text = '6m';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  List<LineChartBarData> get lineBarsData3 => [
        lineChartBarData3_1,
        lineChartBarData3_2,
        lineChartBarData3_3,
      ];
  LineChartBarData get lineChartBarData3_1 => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: Colors.green,
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 1),
          FlSpot(3, 4),
          FlSpot(5, 1.8),
          FlSpot(7, 5),
          FlSpot(10, 2),
          FlSpot(12, 2.2),
          FlSpot(13, 1.8),
        ],
      );

  LineChartBarData get lineChartBarData3_2 => LineChartBarData(
        isCurved: true,
        color: Colors.pink,
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(
          show: true,
          color: Colors.pink.withOpacity(0.2),
        ),
        spots: const [
          FlSpot(1, 1),
          FlSpot(3, 2.8),
          FlSpot(7, 1.2),
          FlSpot(10, 2.8),
          FlSpot(12, 2.6),
          FlSpot(13, 3.9),
        ],
      );

  LineChartBarData get lineChartBarData3_3 => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: Colors.cyan,
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: true),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 3.8),
          FlSpot(3, 1.9),
          FlSpot(6, 5),
          FlSpot(10, 3.3),
          FlSpot(13, 4.5),
        ],
      );
}

class LineChartSample_2 extends StatefulWidget {
  const LineChartSample_2({super.key});

  @override
  State<LineChartSample_2> createState() => _LineChartSample_2State();
}

class _LineChartSample_2State extends State<LineChartSample_2> {
  List<Color> gradientColors = [
    Colors.cyan,
    Colors.blue,
  ];
  bool showAvg = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 18,
              left: 12,
              top: 24,
              bottom: 12,
            ),
            child: LineChart(
              showAvg ? avgData() : mainData(),
            ),
          ),
        ),
        SizedBox(
          width: 60,
          height: 34,
          child: TextButton(
            onPressed: () {
              setState(() {
                showAvg = !showAvg;
              });
            },
            child: Text(
              'avg',
              style: TextStyle(
                fontSize: 12,
                color: showAvg ? Colors.white.withOpacity(0.5) : Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('MAR', style: style);
        break;
      case 5:
        text = const Text('JUN', style: style);
        break;
      case 8:
        text = const Text('SEP', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '10K';
        break;
      case 3:
        text = '30k';
        break;
      case 5:
        text = '50k';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Colors.red,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Colors.red,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: const LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
            interval: 1,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
            ],
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class LineChartSample_4 extends StatelessWidget {
  LineChartSample_4({
    super.key,
    Color? mainLineColor,
    Color? belowLineColor,
    Color? aboveLineColor,
  })  : mainLineColor = mainLineColor ?? Colors.yellow,
        belowLineColor = belowLineColor ?? Colors.pink,
        aboveLineColor = aboveLineColor ?? Colors.purple.withOpacity(0.7);

  final Color mainLineColor;
  final Color belowLineColor;
  final Color aboveLineColor;

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Jan';
        break;
      case 1:
        text = 'Feb';
        break;
      case 2:
        text = 'Mar';
        break;
      case 3:
        text = 'Apr';
        break;
      case 4:
        text = 'May';
        break;
      case 5:
        text = 'Jun';
        break;
      case 6:
        text = 'Jul';
        break;
      case 7:
        text = 'Aug';
        break;
      case 8:
        text = 'Sep';
        break;
      case 9:
        text = 'Oct';
        break;
      case 10:
        text = 'Nov';
        break;
      case 11:
        text = 'Dec';
        break;
      default:
        return Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          color: mainLineColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontSize: 12,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text('\$ ${value + 0.5}', style: style),
    );
  }

  @override
  Widget build(BuildContext context) {
    const cutOffYValue = 5.0;

    return AspectRatio(
      aspectRatio: 2,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 12,
          right: 28,
          top: 22,
          bottom: 12,
        ),
        child: LineChart(
          LineChartData(
            lineTouchData: const LineTouchData(enabled: false),
            lineBarsData: [
              LineChartBarData(
                spots: const [
                  FlSpot(0, 4),
                  FlSpot(1, 3.5),
                  FlSpot(2, 4.5),
                  FlSpot(3, 1),
                  FlSpot(4, 4),
                  FlSpot(5, 6),
                  FlSpot(6, 6.5),
                  FlSpot(7, 6),
                  FlSpot(8, 4),
                  FlSpot(9, 6),
                  FlSpot(10, 6),
                  FlSpot(11, 7),
                ],
                isCurved: true,
                barWidth: 8,
                color: mainLineColor,
                belowBarData: BarAreaData(
                  show: true,
                  color: belowLineColor,
                  cutOffY: cutOffYValue,
                  applyCutOffY: true,
                ),
                aboveBarData: BarAreaData(
                  show: true,
                  color: aboveLineColor,
                  cutOffY: cutOffYValue,
                  applyCutOffY: true,
                ),
                dotData: const FlDotData(
                  show: false,
                ),
              ),
            ],
            minY: 0,
            titlesData: FlTitlesData(
              show: true,
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                axisNameWidget: Text(
                  '2019',
                  style: TextStyle(
                    fontSize: 10,
                    color: mainLineColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 18,
                  interval: 1,
                  getTitlesWidget: bottomTitleWidgets,
                ),
              ),
              leftTitles: AxisTitles(
                axisNameSize: 20,
                axisNameWidget: const Text(
                  'Value',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  reservedSize: 40,
                  getTitlesWidget: leftTitleWidgets,
                ),
              ),
            ),
            borderData: FlBorderData(
              show: true,
              border: Border.all(
                color: Colors.red,
              ),
            ),
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: 1,
              checkToShowHorizontalLine: (double value) {
                return value == 1 || value == 6 || value == 4 || value == 5;
              },
            ),
          ),
        ),
      ),
    );
  }
}

class LineChartSample_5 extends StatefulWidget {
  const LineChartSample_5({
    super.key,
    Color? gradientColor1,
    Color? gradientColor2,
    Color? gradientColor3,
    Color? indicatorStrokeColor,
  })  : gradientColor1 = gradientColor1 ?? Colors.blue,
        gradientColor2 = gradientColor2 ?? Colors.pink,
        gradientColor3 = gradientColor3 ?? Colors.red,
        indicatorStrokeColor = indicatorStrokeColor ?? Colors.black;

  final Color gradientColor1;
  final Color gradientColor2;
  final Color gradientColor3;
  final Color indicatorStrokeColor;

  @override
  State<LineChartSample_5> createState() => _LineChartSample_5State();
}

class _LineChartSample_5State extends State<LineChartSample_5> {
  List<int> showingTooltipOnSpots = [1, 3, 5];

  List<FlSpot> get allSpots => const [
        FlSpot(0, 1),
        FlSpot(1, 2),
        FlSpot(2, 1.5),
        FlSpot(3, 3),
        FlSpot(4, 3.5),
        FlSpot(5, 5),
        FlSpot(6, 8),
      ];

  Widget bottomTitleWidgets(double value, TitleMeta meta, double chartWidth) {
    final style = TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.pink,
      fontFamily: 'Digital',
      fontSize: 18 * chartWidth / 500,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '00:00';
        break;
      case 1:
        text = '04:00';
        break;
      case 2:
        text = '08:00';
        break;
      case 3:
        text = '12:00';
        break;
      case 4:
        text = '16:00';
        break;
      case 5:
        text = '20:00';
        break;
      case 6:
        text = '23:59';
        break;
      default:
        return Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lineBarsData = [
      LineChartBarData(
        showingIndicators: showingTooltipOnSpots,
        spots: allSpots,
        isCurved: true,
        barWidth: 4,
        shadow: const Shadow(
          blurRadius: 8,
        ),
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            colors: [
              widget.gradientColor1.withOpacity(0.4),
              widget.gradientColor2.withOpacity(0.4),
              widget.gradientColor3.withOpacity(0.4),
            ],
          ),
        ),
        dotData: const FlDotData(show: false),
        gradient: LinearGradient(
          colors: [
            widget.gradientColor1,
            widget.gradientColor2,
            widget.gradientColor3,
          ],
          stops: const [0.1, 0.4, 0.9],
        ),
      ),
    ];

    final tooltipsOnBar = lineBarsData[0];

    return AspectRatio(
      aspectRatio: 2.5,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 10,
        ),
        child: LayoutBuilder(builder: (context, constraints) {
          return LineChart(
            LineChartData(
              showingTooltipIndicators: showingTooltipOnSpots.map((index) {
                return ShowingTooltipIndicators([
                  LineBarSpot(
                    tooltipsOnBar,
                    lineBarsData.indexOf(tooltipsOnBar),
                    tooltipsOnBar.spots[index],
                  ),
                ]);
              }).toList(),
              lineTouchData: LineTouchData(
                enabled: true,
                handleBuiltInTouches: false,
                touchCallback:
                    (FlTouchEvent event, LineTouchResponse? response) {
                  if (response == null || response.lineBarSpots == null) {
                    return;
                  }
                  if (event is FlTapUpEvent) {
                    final spotIndex = response.lineBarSpots!.first.spotIndex;
                    setState(() {
                      if (showingTooltipOnSpots.contains(spotIndex)) {
                        showingTooltipOnSpots.remove(spotIndex);
                      } else {
                        showingTooltipOnSpots.add(spotIndex);
                      }
                    });
                  }
                },
                mouseCursorResolver:
                    (FlTouchEvent event, LineTouchResponse? response) {
                  if (response == null || response.lineBarSpots == null) {
                    return SystemMouseCursors.basic;
                  }
                  return SystemMouseCursors.click;
                },
                getTouchedSpotIndicator:
                    (LineChartBarData barData, List<int> spotIndexes) {
                  return spotIndexes.map((index) {
                    return TouchedSpotIndicatorData(
                      const FlLine(
                        color: Colors.pink,
                      ),
                      FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) =>
                            FlDotCirclePainter(
                          radius: 8,
                          color: lerpGradient(
                            barData.gradient!.colors,
                            barData.gradient!.stops!,
                            percent / 100,
                          ),
                          strokeWidth: 2,
                          strokeColor: widget.indicatorStrokeColor,
                        ),
                      ),
                    );
                  }).toList();
                },
                touchTooltipData: LineTouchTooltipData(
                  getTooltipColor: (touchedSpot) => Colors.pink,
                  tooltipRoundedRadius: 8,
                  getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
                    return lineBarsSpot.map((lineBarSpot) {
                      return LineTooltipItem(
                        lineBarSpot.y.toString(),
                        const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }).toList();
                  },
                ),
              ),
              lineBarsData: lineBarsData,
              minY: 0,
              titlesData: FlTitlesData(
                leftTitles: const AxisTitles(
                  axisNameWidget: Text('count'),
                  axisNameSize: 24,
                  sideTitles: SideTitles(
                    showTitles: false,
                    reservedSize: 0,
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,
                    getTitlesWidget: (value, meta) {
                      return bottomTitleWidgets(
                        value,
                        meta,
                        constraints.maxWidth,
                      );
                    },
                    reservedSize: 30,
                  ),
                ),
                rightTitles: const AxisTitles(
                  axisNameWidget: Text('count'),
                  sideTitles: SideTitles(
                    showTitles: false,
                    reservedSize: 0,
                  ),
                ),
                topTitles: const AxisTitles(
                  axisNameWidget: Text(
                    'Wall clock',
                    textAlign: TextAlign.left,
                  ),
                  axisNameSize: 24,
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 0,
                  ),
                ),
              ),
              gridData: const FlGridData(show: false),
              borderData: FlBorderData(
                show: true,
                border: Border.all(
                  color: Colors.black,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class LineChartSample_6 extends StatelessWidget {
  LineChartSample_6({
    super.key,
    Color? line1Color1,
    Color? line1Color2,
    Color? line2Color1,
    Color? line2Color2,
  })  : line1Color1 = line1Color1 ?? Colors.orange,
        line1Color2 = line1Color2 ?? Colors.deepOrange,
        line2Color1 = line2Color1 ?? Colors.lightBlue,
        line2Color2 = line2Color2 ?? Colors.blue {
    minSpotX = spots.first.x;
    maxSpotX = spots.first.x;
    minSpotY = spots.first.y;
    maxSpotY = spots.first.y;

    for (final spot in spots) {
      if (spot.x > maxSpotX) {
        maxSpotX = spot.x;
      }

      if (spot.x < minSpotX) {
        minSpotX = spot.x;
      }

      if (spot.y > maxSpotY) {
        maxSpotY = spot.y;
      }

      if (spot.y < minSpotY) {
        minSpotY = spot.y;
      }
    }
  }

  final Color line1Color1;
  final Color line1Color2;
  final Color line2Color1;
  final Color line2Color2;

  final spots = const [
    FlSpot(0, 1),
    FlSpot(2, 5),
    FlSpot(4, 3),
    FlSpot(6, 5),
  ];

  final spots2 = const [
    FlSpot(0, 3),
    FlSpot(2, 1),
    FlSpot(4, 2),
    FlSpot(6, 1),
  ];

  late double minSpotX;
  late double maxSpotX;
  late double minSpotY;
  late double maxSpotY;

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    final style = TextStyle(
      color: line1Color1,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    );

    final intValue = reverseY(value, minSpotY, maxSpotY).toInt();

    if (intValue == (maxSpotY + minSpotY)) {
      return Text('', style: style);
    }

    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: Text(
        intValue.toString(),
        style: style,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget rightTitleWidgets(double value, TitleMeta meta) {
    final style = TextStyle(
      color: line2Color2,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    );
    final intValue = reverseY(value, minSpotY, maxSpotY).toInt();

    if (intValue == (maxSpotY + minSpotY)) {
      return Text('', style: style);
    }

    return Text(intValue.toString(), style: style, textAlign: TextAlign.right);
  }

  Widget topTitleWidgets(double value, TitleMeta meta) {
    if (value % 1 != 0) {
      return Container();
    }
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(value.toInt().toString(), style: style),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 22, bottom: 20),
      child: AspectRatio(
        aspectRatio: 2,
        child: LineChart(
          LineChartData(
            lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
                tooltipRoundedRadius: 0,
                getTooltipColor: (spot) => Colors.white,
                getTooltipItems: (List<LineBarSpot> touchedSpots) {
                  return touchedSpots.map((LineBarSpot touchedSpot) {
                    return LineTooltipItem(
                      touchedSpot.y.toString(),
                      TextStyle(
                        color: touchedSpot.bar.gradient!.colors.first,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    );
                  }).toList();
                },
              ),
              getTouchedSpotIndicator: (
                _,
                indicators,
              ) {
                return indicators
                    .map((int index) => const TouchedSpotIndicatorData(
                          FlLine(color: Colors.transparent),
                          FlDotData(show: false),
                        ))
                    .toList();
              },
              touchSpotThreshold: 12,
              distanceCalculator:
                  (Offset touchPoint, Offset spotPixelCoordinates) =>
                      (touchPoint - spotPixelCoordinates).distance,
            ),
            lineBarsData: [
              LineChartBarData(
                gradient: LinearGradient(
                  colors: [
                    line1Color1,
                    line1Color2,
                  ],
                ),
                spots: reverseSpots(spots, minSpotY, maxSpotY),
                isCurved: true,
                isStrokeCapRound: true,
                barWidth: 10,
                belowBarData: BarAreaData(
                  show: false,
                ),
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) {
                    return FlDotCirclePainter(
                      radius: 12,
                      color: Color.lerp(
                        line1Color1,
                        line1Color2,
                        percent / 100,
                      )!,
                      strokeColor: Colors.white,
                      strokeWidth: 1,
                    );
                  },
                ),
              ),
              LineChartBarData(
                gradient: LinearGradient(
                  colors: [
                    line2Color1,
                    line2Color2,
                  ],
                ),
                spots: reverseSpots(spots2, minSpotY, maxSpotY),
                isCurved: true,
                isStrokeCapRound: true,
                barWidth: 10,
                belowBarData: BarAreaData(
                  show: false,
                ),
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) {
                    return FlDotCirclePainter(
                      radius: 12,
                      color: Color.lerp(
                        line2Color1,
                        line2Color2,
                        percent / 100,
                      )!,
                      strokeColor: Colors.white,
                      strokeWidth: 1,
                    );
                  },
                ),
              ),
            ],
            minY: 0,
            maxY: maxSpotY + minSpotY,
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: leftTitleWidgets,
                  reservedSize: 38,
                ),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: rightTitleWidgets,
                  reservedSize: 30,
                ),
              ),
              bottomTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 32,
                  getTitlesWidget: topTitleWidgets,
                ),
              ),
            ),
            gridData: FlGridData(
              show: true,
              drawVerticalLine: true,
              checkToShowHorizontalLine: (value) {
                final intValue = reverseY(value, minSpotY, maxSpotY).toInt();

                if (intValue == (maxSpotY + minSpotY).toInt()) {
                  return false;
                }

                return true;
              },
            ),
            borderData: FlBorderData(
              show: true,
              border: const Border(
                left: BorderSide(color: Colors.black),
                top: BorderSide(color: Colors.black),
                bottom: BorderSide(color: Colors.transparent),
                right: BorderSide(color: Colors.transparent),
              ),
            ),
          ),
        ),
      ),
    );
  }

  double reverseY(double y, double minX, double maxX) {
    return (maxX + minX) - y;
  }

  List<FlSpot> reverseSpots(List<FlSpot> inputSpots, double minY, double maxY) {
    return inputSpots.map((spot) {
      return spot.copyWith(y: (maxY + minY) - spot.y);
    }).toList();
  }
}

/// Lerps between a [LinearGradient] colors, based on [t]
Color lerpGradient(List<Color> colors, List<double> stops, double t) {
  if (colors.isEmpty) {
    throw ArgumentError('"colors" is empty.');
  } else if (colors.length == 1) {
    return colors[0];
  }

  if (stops.length != colors.length) {
    stops = [];

    /// provided gradientColorStops is invalid and we calculate it here
    colors.asMap().forEach((index, color) {
      final percent = 1.0 / (colors.length - 1);
      stops.add(percent * index);
    });
  }

  for (var s = 0; s < stops.length - 1; s++) {
    final leftStop = stops[s];
    final rightStop = stops[s + 1];
    final leftColor = colors[s];
    final rightColor = colors[s + 1];
    if (t <= leftStop) {
      return leftColor;
    } else if (t < rightStop) {
      final sectionT = (t - leftStop) / (rightStop - leftStop);
      return Color.lerp(leftColor, rightColor, sectionT)!;
    }
  }
  return colors.last;
}

// BarChart
class _BarChart extends StatelessWidget {
  const _BarChart();

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        gridData: const FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: 20,
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: Colors.cyan,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.blue,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Mn';
        break;
      case 1:
        text = 'Te';
        break;
      case 2:
        text = 'Wd';
        break;
      case 3:
        text = 'Tu';
        break;
      case 4:
        text = 'Fr';
        break;
      case 5:
        text = 'St';
        break;
      case 6:
        text = 'Sn';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  LinearGradient get _barsGradient => const LinearGradient(
        colors: [
          Colors.blue,
          Colors.cyan,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  List<BarChartGroupData> get barGroups => [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
              toY: 8,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              toY: 10,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
              toY: 14,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
              toY: 15,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(
              toY: 13,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 5,
          barRods: [
            BarChartRodData(
              toY: 10,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 6,
          barRods: [
            BarChartRodData(
              toY: 16,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
      ];
}

class BarChartSample_3 extends StatefulWidget {
  const BarChartSample_3({super.key});

  @override
  State<StatefulWidget> createState() => BarChartSample_3State();
}

class BarChartSample_3State extends State<BarChartSample_3> {
  @override
  Widget build(BuildContext context) {
    return const AspectRatio(
      aspectRatio: 1.6,
      child: _BarChart(),
    );
  }
}

// PieChart
class PieChartSample_1 extends StatefulWidget {
  const PieChartSample_1({super.key});

  @override
  State<StatefulWidget> createState() => PieChartSample_1State();
}

class PieChartSample_1State extends State {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 28,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Indicator(
                color: Colors.blue,
                text: 'One',
                isSquare: false,
                size: touchedIndex == 0 ? 18 : 16,
                textColor: touchedIndex == 0 ? Colors.black : Colors.red,
              ),
              Indicator(
                color: Colors.yellow,
                text: 'Two',
                isSquare: false,
                size: touchedIndex == 1 ? 18 : 16,
                textColor: touchedIndex == 1 ? Colors.black : Colors.red,
              ),
              Indicator(
                color: Colors.pink,
                text: 'Three',
                isSquare: false,
                size: touchedIndex == 2 ? 18 : 16,
                textColor: touchedIndex == 2 ? Colors.black : Colors.red,
              ),
              Indicator(
                color: Colors.green,
                text: 'Four',
                isSquare: false,
                size: touchedIndex == 3 ? 18 : 16,
                textColor: touchedIndex == 3 ? Colors.black : Colors.red,
              ),
            ],
          ),
          const SizedBox(
            height: 18,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  startDegreeOffset: 180,
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 1,
                  centerSpaceRadius: 0,
                  sections: showingSections(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(
      4,
      (i) {
        final isTouched = i == touchedIndex;
        const color0 = Colors.blue;
        const color1 = Colors.yellow;
        const color2 = Colors.pink;
        const color3 = Colors.green;

        switch (i) {
          case 0:
            return PieChartSectionData(
              color: color0,
              value: 25,
              title: '',
              radius: 80,
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? const BorderSide(color: Colors.white, width: 6)
                  : BorderSide(color: Colors.white.withOpacity(0)),
            );
          case 1:
            return PieChartSectionData(
              color: color1,
              value: 25,
              title: '',
              radius: 65,
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? const BorderSide(color: Colors.white, width: 6)
                  : BorderSide(color: Colors.white.withOpacity(0)),
            );
          case 2:
            return PieChartSectionData(
              color: color2,
              value: 25,
              title: '',
              radius: 60,
              titlePositionPercentageOffset: 0.6,
              borderSide: isTouched
                  ? const BorderSide(color: Colors.white, width: 6)
                  : BorderSide(color: Colors.white.withOpacity(0)),
            );
          case 3:
            return PieChartSectionData(
              color: color3,
              value: 25,
              title: '',
              radius: 70,
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? const BorderSide(color: Colors.white, width: 6)
                  : BorderSide(color: Colors.white.withOpacity(0)),
            );
          default:
            throw Error();
        }
      },
    );
  }
}

class PieChartSample_2 extends StatefulWidget {
  const PieChartSample_2({super.key});
  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Row(
        children: <Widget>[
          const SizedBox(height: 18),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: showingSections(),
                ),
              ),
            ),
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Indicator(
                color: Colors.blue,
                text: 'First',
                isSquare: true,
              ),
              SizedBox(
                height: 4,
              ),
              Indicator(
                color: Colors.yellow,
                text: 'Second',
                isSquare: true,
              ),
              SizedBox(
                height: 4,
              ),
              Indicator(
                color: Colors.deepPurple,
                text: 'Third',
                isSquare: true,
              ),
              SizedBox(
                height: 4,
              ),
              Indicator(
                color: Colors.green,
                text: 'Fourth',
                isSquare: true,
              ),
              SizedBox(height: 18),
            ],
          ),
          const SizedBox(width: 28),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.blue,
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.yellow,
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              // shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.deepPurple,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              // shadows: shadows,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.green,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              // shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}

class PieChartSample_3 extends StatefulWidget {
  const PieChartSample_3({super.key});
  @override
  State<StatefulWidget> createState() => PieChartSample_3State();
}

class PieChartSample_3State extends State {
  int touchedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: AspectRatio(
        aspectRatio: 1,
        child: PieChart(
          PieChartData(
            pieTouchData: PieTouchData(
              touchCallback: (FlTouchEvent event, pieTouchResponse) {
                setState(() {
                  if (!event.isInterestedForInteractions ||
                      pieTouchResponse == null ||
                      pieTouchResponse.touchedSection == null) {
                    touchedIndex = -1;
                    return;
                  }
                  touchedIndex =
                      pieTouchResponse.touchedSection!.touchedSectionIndex;
                });
              },
            ),
            borderData: FlBorderData(
              show: false,
            ),
            sectionsSpace: 0,
            centerSpaceRadius: 0,
            sections: showingSections(),
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 110.0 : 100.0;
      final widgetSize = isTouched ? 55.0 : 40.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.blue,
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgeWidget: _Badge(
              ophthalmology_svg,
              size: widgetSize,
              borderColor: Colors.black,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 1:
          return PieChartSectionData(
            color: Colors.yellow,
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgeWidget: _Badge(
              librarian_svg,
              size: widgetSize,
              borderColor: Colors.black,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 2:
          return PieChartSectionData(
            color: Colors.deepPurple,
            value: 16,
            title: '16%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgeWidget: _Badge(
              fitness_svg,
              size: widgetSize,
              borderColor: Colors.black,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 3:
          return PieChartSectionData(
            color: Colors.green,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgeWidget: _Badge(
              worker_svg,
              size: widgetSize,
              borderColor: Colors.black,
            ),
            badgePositionPercentageOffset: .98,
          );
        default:
          throw Exception('Oh no');
      }
    });
  }
}

class _Badge extends StatelessWidget {
  const _Badge(
    this.svgString, {
    required this.size,
    required this.borderColor,
  });
  final String svgString;
  final double size;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(
        child: SvgPicture.string(svgString),
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor,
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        )
      ],
    );
  }
}
