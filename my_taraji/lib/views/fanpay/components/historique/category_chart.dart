import '../../imports.dart';
import 'package:pie_chart/pie_chart.dart';

class DonutChartWithSections extends StatelessWidget {
  const DonutChartWithSections({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 350,
        height: 200,
        child: buildPieChart(),
      ),
    );
  }

  Widget buildPieChart() {
    final dataMap = <String, double>{
      "Don": 5,
      "Transfert": 3,
      "Paiement": 2,
      "Autres": 10,
    };

    final colorList = <Color>[
      const Color(0xff3784FB),
      const Color(0xff022964),
      const Color(0xffFBAE05),
      const Color(0xffDCE9FE),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: PieChart(
        dataMap: dataMap,
        chartType: ChartType.ring,
        baseChartColor: Colors.grey[50]!.withOpacity(0.15),
        colorList: colorList,
        chartValuesOptions: const ChartValuesOptions(
          showChartValuesInPercentage: false,
          showChartValueBackground: false,
          showChartValues: false,
        ),
        totalValue: 20,
        legendOptions: const LegendOptions(
          legendShape: BoxShape.rectangle,
          showLegendsInRow: false,
          legendPosition: LegendPosition.right,
          showLegends: true,
          legendTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
    // return AspectRatio(
    //   aspectRatio: 1,
    //   child: PieChart(
    //     swapAnimationDuration: const Duration(milliseconds: 2000),
    //     PieChartData(
    //       sectionsSpace: 0,
    //       centerSpaceRadius: 80,
    //       startDegreeOffset: -90,
    //       sections: [
    //         PieChartSectionData(
    //           showTitle: false,
    //           color: const Color(0xff3784FB),
    //           value: 40,
    //           radius: 20,
    //         ),
    //         PieChartSectionData(
    //           showTitle: false,
    //           color: const Color(0xff022964),
    //           value: 20,
    //           radius: 20,
    //         ),
    //         PieChartSectionData(
    //           showTitle: false,
    //           color: const Color(0xffFBAE05),
    //           value: 20,
    //           radius: 20,
    //         ),
    //         PieChartSectionData(
    //           showTitle: false,
    //           color: const Color(0xffDCE9FE),
    //           value: 20,
    //           radius: 20,
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
