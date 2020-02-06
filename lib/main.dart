import 'dart:async';

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timer App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{
  int hour = 0;
  int min = 0;
  int sec = 0;
  int timeForTimer;
  bool started = true;
  bool stopped = false;
  bool cancelTimer = false;
  final dur = const Duration(seconds: 1);
  String timeToDisplay = "";
  void start(){
    setState(() {
      started = false;
      stopped = true;
    });
     timeForTimer = ((hour * 3600) + (min * 60) + sec);
       Timer.periodic(dur, (Timer t){
         setState(() {
           if(timeForTimer < 1 || cancelTimer){
             t.cancel();
             Navigator.pushReplacement(context, MaterialPageRoute(
               builder: (context) => MyHomePage()
             ));
           }else{
             timeForTimer --;
             int secs = timeForTimer;
             int hours = (secs / 3600).floor();

             secs %= 3600;
             int minutes = (secs / 60).floor() ;
             secs %= 60;
             int seconds = secs;
             timeToDisplay = "$hours : $minutes : $seconds";
           }
         });
       });
  }
  void stop(){
    stopped = false;
    started = true;
    cancelTimer = true;
    timeToDisplay = "";
  }
  Widget timer(){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10.0
                      ),
                      child: Text(
                          "HH",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700
                       ),
                      ),
                    ),
                    NumberPicker.integer(
                        initialValue: hour,
                        minValue: 0,
                        maxValue: 23,
                        listViewWidth: 60,
                        onChanged: (val) {
                          setState(() {
                            hour = val;
                          });
                        }
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0
                      ),
                      child: Text(
                        "MM",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700
                        ),
                      ),
                    ),
                    NumberPicker.integer(
                        initialValue: min,
                        minValue: 0,
                        maxValue: 59,
                        listViewWidth: 60,
                        onChanged: (val) {
                          setState(() {
                            min = val;
                          });
                        }
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0
                      ),
                      child: Text(
                        "SS",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700
                        ),
                      ),
                    ),
                    NumberPicker.integer(
                        initialValue: sec,
                        minValue: 0,
                        maxValue: 59,
                        listViewWidth: 60,
                        onChanged: (val) {
                          setState(() {
                            sec = val;
                          });
                        }
                    )
                  ],
                )
              ],
            )
          ),
          Expanded(
            flex: 1,
            child: Text(
                "$timeToDisplay",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w800,
                fontSize: 40.0
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  onPressed: started ? start : null,
                  color: Colors.green,
                  child: Text(
                      "Start",
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white
                  ),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 20.0
                  ),
                ),
                RaisedButton(
                  onPressed: stopped ? stop : null,
                  color: Colors.orange,
                  child: Text(
                    "Stop",
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.white
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 20.0
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
                'Watch',
            style: TextStyle(
              fontSize: 25.0
            ),
            ),
            centerTitle: true,
            bottom: TabBar(
              tabs: [
                Tab(child: Text(
                    "Timer"),
                ),
                Tab(child: Text(
                    "Stop Watch"),
                ),
              ],
              labelStyle: TextStyle(
                fontSize: 18.0,
              ),
              labelPadding: EdgeInsets.all(5.0),
              unselectedLabelColor: Colors.white38,
            ),
          ),
          body: TabBarView(
            children: [
              timer(),
              Text(
                  "Stop Watch"
              ),
            ],
          ),
        ),
      );
  }
}
