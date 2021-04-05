import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';


class StatistikPage extends StatefulWidget{
  @override
  StatistikState createState() => StatistikState();
}

class StatistikState extends State<StatistikPage> {

  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  bool showAvg = false;

  List item = [];
  List filterItem = [];

  getItem() async {
    var url = "http://192.168.1.243/rest_flutter/index.php/item";
    final response = await http.get(url);
    return json.decode(response.body);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getItem().then((data){
      setState(() {
        filterItem = item = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.lightBlueAccent[100],
              Colors.white54,
              Colors.black12,
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          )
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 35.0,),),
            Container(
                padding: EdgeInsets.only(left: 30.0),
                alignment: Alignment.bottomLeft,
                child: GestureDetector(
                  onTap: (){
                    Scaffold.of(context).openDrawer();
                  },
                  child: Image.asset('images/menu_burger.png', width: 46.0,),
                )
            ),
            Padding(padding: EdgeInsets.only(top: 15.0),),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 35.0),
              child: Text("Dana Pensiun", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
            ),
            Padding(padding: EdgeInsets.only(top: 15.0),),
            Container(
              height: 250.0,
              padding: EdgeInsets.only(left: 35.0, right: 35.0),
              child: Stack(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 1.70,
                    child: Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(18),
                          ),
                          color: Colors.white38),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 18.0, left: 12.0, top: 24, bottom: 12),
                        child: LineChart(
                          showAvg ? avgData() : mainData(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 60,
                    height: 34,
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          showAvg = !showAvg;
                        });
                      },
                      child: Text(
                        'Avg',
                        style: TextStyle(
                            fontSize: 8, color: showAvg ? Colors.blueGrey : Colors.blueGrey),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 35.0, right: 35.0),
              height: MediaQuery.of(context).size.height * 0.09,
              child: filterItem.length > 0
              ? ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: filterItem.length,
                itemBuilder: (BuildContext context, int index){
                  return Container(
                    padding: EdgeInsets.only(right: 10),
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(15.0),
                              topRight: const Radius.circular(15.0),
                              bottomLeft: const Radius.circular(15.0),
                              bottomRight: const Radius.circular(15.0)
                          ),
                          gradient: LinearGradient(
                            colors: [
                              Colors.deepPurple[400],
                              Colors.deepPurpleAccent[100],
                              Colors.deepPurple[200],
                            ],
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                          )
                      ),
                      padding: EdgeInsets.only(right: 10.0),
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Padding(padding: EdgeInsets.only(top: 20),),
                            Container(
                              padding: EdgeInsets.only(left: 20.0),
                              alignment: Alignment.centerLeft,
                              child: Text(filterItem[index]['item_name'], style: TextStyle(fontSize: 12.0, color: Colors.white),),
                            ),
                            Padding(padding: EdgeInsets.only(top: 8),),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    padding: EdgeInsets.only(left: 20.0),
                                    alignment: Alignment.centerLeft,
                                    child: formatRupiah(filterItem[index]['price']),
                                  ),
                                ),
                                Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: EdgeInsets.only(right: 20.0),
                                      alignment: Alignment.centerRight,
                                      child: Text(filterItem[index]['stock'], style: TextStyle(fontSize: 15.0, color: Colors.white),),
                                    ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
              : Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 30.0),),
            Container(
              height: 600,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(50.0),
                      topRight: const Radius.circular(50.0)
                  )
              ),
              child: Container(
                padding: EdgeInsets.only(right: 40),
                child: Column(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 35.0),),
                    Container(
                      padding: EdgeInsets.only(left: 40.0, right: 40.0),
                      alignment: Alignment.centerLeft,
                      child: Text("Alokasi Portfolio", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                    ),
                    Padding(padding: EdgeInsets.only(top: 20.0),),
                    Row(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(left: 35.0),),
                        Expanded(
                          flex: 1,
                          child: Image.asset('images/iconssatu.png'),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text("Obigasi", style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(""),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(left: 35.0),),
                        Expanded(
                          flex: 1,
                          child: Text(""),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text("Nilai saat ini", style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Text("Rp. 13.448.000", style: TextStyle(fontWeight: FontWeight.bold),),
                          ),
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(top: 20.0),),
                    Row(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(left: 35.0),),
                        Expanded(
                          flex: 1,
                          child: Text(""),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text("Nilai saat ini", style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            padding: EdgeInsets.only(left: 20.0),
                            alignment: Alignment.centerRight,
                            child: LinearProgressIndicator(
                              backgroundColor: Colors.grey[300],
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
                              value: 0.47,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(top: 20.0),),
                    Row(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(left: 35.0),),
                        Expanded(
                          flex: 1,
                          child: Text(""),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text("Target", style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            padding: EdgeInsets.only(left: 20.0),
                            alignment: Alignment.centerRight,
                            child: LinearProgressIndicator(
                              backgroundColor: Colors.grey[300],
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.lightBlueAccent),
                              value: 0.78,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),

      ),
    );
  }

  mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.transparent,
            strokeWidth: 0,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.transparent,
            strokeWidth: 0,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle:
          const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 9),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return 'Jan';
              case 3:
                return 'Feb';
              case 5:
                return 'Mar';
              case 7:
                return 'Apr';
              case 9:
                return 'Mei';
              case 11:
                return 'Jun';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: false,
          textStyle: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '10k';
              case 3:
                return '30k';
              case 5:
                return '50k';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData:
      FlBorderData(show: false, border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
          ],
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: false,
            colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  avgData() {
    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.transparent,
            strokeWidth: 0,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.transparent,
            strokeWidth: 0,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle:
          const TextStyle(color: Color(0xff68737d), fontWeight: FontWeight.bold, fontSize: 9),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return 'Jan';
              case 3:
                return 'Feb';
              case 5:
                return 'Mar';
              case 7:
                return 'Apr';
              case 9:
                return 'Mei';
              case 11:
                return 'Jun';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: false,
          textStyle: const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '10k';
              case 3:
                return '30k';
              case 5:
                return '50k';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData:
      FlBorderData(show: false, border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
          isCurved: true,
          colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(0.2),
            ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(0.2),
          ],
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(show: false, colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(0.2).withOpacity(0.1),
            ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(0.2).withOpacity(0.1),
          ]),
        ),
      ],
    );
  }

  formatRupiah(pricenya) {
    final formatCurrency = NumberFormat.simpleCurrency(locale: 'id_ID');
    int _money = int.parse(pricenya);
    return Text("${formatCurrency.format(_money)}", style: TextStyle(fontSize: 15.0, color: Colors.white),);
  }
}
