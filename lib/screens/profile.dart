import 'dart:math';

import 'package:flutter/material.dart';

class DotsIndicator extends AnimatedWidget {
  DotsIndicator({
    this.controller,
    this.itemCount,
    this.onPageSelected,
    this.color: Colors.white,
  }) : super(listenable: controller);

  /// The PageController that this DotsIndicator is representing.
  final PageController controller;

  /// The number of items managed by the PageController
  final int itemCount;

  /// Called when a dot is tapped
  final ValueChanged<int> onPageSelected;

  /// The color of the dots.
  ///
  /// Defaults to `Colors.white`.
  final Color color;

  // The base size of the dots
  static const double _kDotSize = 8.0;

  // The increase in the size of the selected dot
  static const double _kMaxZoom = 2.0;

  // The distance between the center of each dot
  static const double _kDotSpacing = 25.0;

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    double zoom = 1.0 + (_kMaxZoom - 1.0) * selectedness;
    return new Container(
      width: _kDotSpacing,
      child: new Center(
        child: new Material(
          color: color,
          type: MaterialType.circle,
          child: new Container(
            width: _kDotSize * zoom,
            height: _kDotSize * zoom,
            child: new InkWell(
              onTap: () => onPageSelected(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List<Widget>.generate(itemCount, _buildDot),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  ProfileState createState() => ProfileState();

}

class ProfileState extends State<ProfilePage> {

  final List<Widget> _pages = <Widget>[
    new ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: Container(
        padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 30.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(15.0),
                  topRight: const Radius.circular(15.0),
                  bottomLeft: const Radius.circular(15.0),
                  bottomRight: const Radius.circular(15.0)
              )
          ),
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 25.0),),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 20.0),
                child: Text("Uang Sekolah Anak", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Image.asset('images/iconsdua.png'),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Pasar Uang", style: TextStyle(fontWeight: FontWeight.bold)),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: EdgeInsets.only(right: 35.0),
                                  alignment: Alignment.centerRight,
                                  child: Text("34%", style: TextStyle(fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10.0, right: 35.0),
                            child: LinearProgressIndicator(
                              backgroundColor: Colors.grey,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
                              value: 0.34,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Image.asset('images/iconstiga.png'),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Original", style: TextStyle(fontWeight: FontWeight.bold)),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: EdgeInsets.only(right: 35.0),
                                  alignment: Alignment.centerRight,
                                  child: Text("92%", style: TextStyle(fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10.0, right: 35.0),
                            child: LinearProgressIndicator(
                              backgroundColor: Colors.grey,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                              value: 0.92,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom: 20.0),)

            ],
          ),
        ),
      ),
    ),
    new ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: Container(
        padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 30.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(15.0),
                  topRight: const Radius.circular(15.0),
                  bottomLeft: const Radius.circular(15.0),
                  bottomRight: const Radius.circular(15.0)
              )
          ),
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 25.0),),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 20.0),
                child: Text("Uang Kebutuhan Tiap Bulan", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Image.asset('images/iconsdua.png'),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Pasar Uang", style: TextStyle(fontWeight: FontWeight.bold)),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: EdgeInsets.only(right: 35.0),
                                  alignment: Alignment.centerRight,
                                  child: Text("34%", style: TextStyle(fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10.0, right: 35.0),
                            child: LinearProgressIndicator(
                              backgroundColor: Colors.grey,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                              value: 0.34,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Image.asset('images/iconstiga.png'),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Original", style: TextStyle(fontWeight: FontWeight.bold)),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: EdgeInsets.only(right: 35.0),
                                  alignment: Alignment.centerRight,
                                  child: Text("92%", style: TextStyle(fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10.0, right: 35.0),
                            child: LinearProgressIndicator(
                              backgroundColor: Colors.grey,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                              value: 0.92,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom: 20.0),)

            ],
          ),
        ),
      ),
    ),
    new ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: Container(
        padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 30.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(15.0),
                  topRight: const Radius.circular(15.0),
                  bottomLeft: const Radius.circular(15.0),
                  bottomRight: const Radius.circular(15.0)
              )
          ),
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 25.0),),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 20.0),
                child: Text("Uang Dana Pensiun", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Image.asset('images/iconsdua.png'),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Pasar Uang", style: TextStyle(fontWeight: FontWeight.bold)),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: EdgeInsets.only(right: 35.0),
                                  alignment: Alignment.centerRight,
                                  child: Text("34%", style: TextStyle(fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10.0, right: 35.0),
                            child: LinearProgressIndicator(
                              backgroundColor: Colors.grey,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.cyanAccent),
                              value: 0.34,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Image.asset('images/iconstiga.png'),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Original", style: TextStyle(fontWeight: FontWeight.bold)),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: EdgeInsets.only(right: 35.0),
                                  alignment: Alignment.centerRight,
                                  child: Text("92%", style: TextStyle(fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10.0, right: 35.0),
                            child: LinearProgressIndicator(
                              backgroundColor: Colors.grey,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent),
                              value: 0.92,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom: 20.0),)

            ],
          ),
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {

    final _controller = new PageController();
    const _kDuration = const Duration(milliseconds: 300);
    const _kCurve = Curves.ease;

    return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('http://192.168.1.243/rest_flutter/assets/image_banner/backgroun.png'),
            fit: BoxFit.cover
          ),
            gradient: LinearGradient(
              colors: [
                Colors.purpleAccent,
                Colors.deepPurpleAccent[100],
                Colors.white,
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
              child: Text("Portofolio", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
            ),
            Image.network('http://192.168.1.243/rest_flutter/assets/image_banner/portoimge.png', scale: 10,),
            Container(
              height: 600,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(30.0),
                  topRight: const Radius.circular(30.0)
                )
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: <Widget>[
                            Padding(padding: EdgeInsets.only(top: 35.0),),
                            Container(
                              padding: EdgeInsets.only(left: 35.0),
                              alignment: Alignment.centerLeft,
                              child: Text("Total Nilai", style: TextStyle(color: Colors.white)),
                            ),
                            Padding(padding: EdgeInsets.only(top: 5.0),),
                            Container(
                              padding: EdgeInsets.only(left: 35.0),
                              alignment: Alignment.centerLeft,
                              child: Text("Rp. 334.221.200", style: TextStyle(color: Colors.white, fontSize: 16.0)),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(top: 35.0, right: 35.0),
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.white24,
                                borderRadius: BorderRadius.only(
                                    topLeft: const Radius.circular(15.0),
                                    topRight: const Radius.circular(15.0),
                                    bottomLeft: const Radius.circular(15.0),
                                    bottomRight: const Radius.circular(15.0)
                                )
                            ),
                            child: Center(
                              child: Text("+3.43%"),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 20.0),),
                  Container(
                    height: 300,
                    child: Stack(
                      children: <Widget>[
                        PageView.builder(
                            physics: AlwaysScrollableScrollPhysics(),
                            controller: _controller,
                            itemBuilder: (BuildContext context, int index){
                              return _pages[index % _pages.length];
                            }
                        ),
                        Positioned(
                          bottom: -20.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            // color: Colors.grey[800].withOpacity(0.5),
                            padding: const EdgeInsets.all(20.0),
                            child: Center(
                              child: DotsIndicator(
                                controller: _controller,
                                itemCount: _pages.length,
                                onPageSelected: (int page){
                                  _controller.animateToPage(page, duration: _kDuration, curve: _kCurve);
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )


          ],
        ),
      ),
    );
  }
}