import 'package:flutter/material.dart';
import 'package:frontend/global.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:frontend/scan.dart';
import 'package:frontend/services/firebase.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:async';

class home extends StatefulWidget {
  var status;
  home(this.temperature, this.status, {Key key}) : super(key: key);
  var temperature = "Scan";
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  Timer _timer;

  var x = 0.0;
  void showindicator() {
    const oneSec = const Duration(milliseconds: 25);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (x == 1.0) {
          timer.cancel();
        }
        setState(() {
          x = x + 0.01;
        });
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  _homeState() {
    showindicator();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(background),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Thunder Squad",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.w300),
              ),
              Text(
                " <⚡>",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const QRViewExample()),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      child: Neumorphic(
                        style: NeumorphicStyle(
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(100)),
                          depth: -17.0,
                          lightSource: LightSource.topLeft,
                          color: Color(background),
                        ),
                        child: Container(
                          height: 222,
                          width: 222,
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        // left: 12,
                        // top: 15,
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Neumorphic(
                              style: NeumorphicStyle(
                                intensity: 1,
                                boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(100)),
                                depth: 4.0,
                                lightSource: LightSource.topLeft,
                                color: Color(background),
                              ),
                              child: Stack(
                                children: [
                                  SizedBox(
                                    height: 190,
                                    width: 190,
                                    child: widget.temperature != "Scan"
                                        ? CircularProgressIndicator(
                                            value: x,
                                            color: widget.status == "Critical"
                                                ? Colors.red
                                                : Colors.green,
                                            strokeWidth: 18,
                                          )
                                        : SizedBox(),
                                  ),
                                  Positioned.fill(
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            widget.temperature == "Scan"
                                                ? Text(
                                                    widget.temperature,
                                                    style: TextStyle(
                                                        fontSize: 40,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w100),
                                                  )
                                                : Text(
                                                    widget.temperature + "°C",
                                                    style: TextStyle(
                                                        fontSize: 40,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w100),
                                                  ),
                                            widget.status == "Critical"
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "Critical",
                                                        style: TextStyle(
                                                            fontSize: 25,
                                                            color: Colors.red,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w300),
                                                      ),
                                                      Icon(
                                                        Icons.thermostat,
                                                        color: Colors.red,
                                                        size: 30.0,
                                                      ),
                                                    ],
                                                  )
                                                : widget.status == "Safe"
                                                    ? Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            "Safe",
                                                            style: TextStyle(
                                                                fontSize: 25,
                                                                color: Colors
                                                                    .green,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300),
                                                          ),
                                                          Icon(
                                                            Icons.thermostat,
                                                            color: Colors.green,
                                                            size: 30.0,
                                                          ),
                                                        ],
                                                      )
                                                    : SizedBox()
                                          ],
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Container(
                    child: Neumorphic(
                      style: NeumorphicStyle(
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(100)),
                        depth: 3.0,
                        lightSource: LightSource.topLeft,
                        color: Color(background),
                      ),
                      child: Container(
                        height: 70,
                        width: 70,
                        child: Icon(
                          Icons.add,
                          color: Colors.pink,
                          size: 40.0,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Set Temp.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: Column(
                  children: [
                    Container(
                      child: Neumorphic(
                        style: NeumorphicStyle(
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(100)),
                          depth: 3.0,
                          lightSource: LightSource.topLeft,
                          color: Color(background),
                        ),
                        child: Container(
                          height: 70,
                          width: 70,
                          child: Icon(
                            Icons.track_changes,
                            color: Colors.pink,
                            size: 40.0,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Track",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    child: Neumorphic(
                      style: NeumorphicStyle(
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(100)),
                        depth: 3.0,
                        lightSource: LightSource.topLeft,
                        color: Color(background),
                      ),
                      child: Container(
                        height: 70,
                        width: 70,
                        child: Icon(
                          Icons.info,
                          color: Colors.pink,
                          size: 40.0,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Info",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Neumorphic(
                  style: NeumorphicStyle(
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
                    depth: -6.0,
                    // lightSource: LightSource.topLeft,
                    color: Color(background),
                  ),
                  child: Container(
                    height: 120,
                    width: 290,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Vaccine Management      ",
                                style: TextStyle(fontSize: 17),
                              ),
                              Text(
                                "> ",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black45),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: Container(
                              height: 1,
                              width: double.infinity,
                              color: Colors.black26,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.credit_score_outlined,
                                color: Colors.green,
                                size: 30.0,
                              ),
                              Text(
                                "Arrived at Udaipur ",
                                style: TextStyle(fontSize: 13),
                              ),
                              Text(
                                "11:00 PM",
                                style: TextStyle(fontSize: 13),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(40),
                topLeft: Radius.circular(40),
              ),
            ),
            height: 87,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Neumorphic(
                      style: NeumorphicStyle(
                        intensity: 1,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(100)),
                        depth: -4.0,
                        lightSource: LightSource.topLeft,
                        color: Color(background),
                      ),
                      child: Container(
                        height: 65,
                        width: 65,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.email,
                              color: Colors.green,
                              size: 37.0,
                            ),
                            Text(
                              "Dash",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.warning_outlined,
                        color: Colors.black26,
                        size: 40.0,
                      ),
                      Text(
                        "Alerts",
                        style: TextStyle(color: Colors.black45),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.email,
                        color: Colors.black26,
                        size: 40.0,
                      ),
                      Text(
                        "Message",
                        style: TextStyle(color: Colors.black45),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.settings,
                        color: Colors.black26,
                        size: 40.0,
                      ),
                      Text(
                        "Settings",
                        style: TextStyle(color: Colors.black45),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
