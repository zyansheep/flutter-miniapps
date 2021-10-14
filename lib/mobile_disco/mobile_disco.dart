import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class MobileDiscoPage extends StatefulWidget {
  MobileDiscoPage({Key? key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String? title;

  @override
  _MobileDiscoPageState createState() => _MobileDiscoPageState();
}

class _MobileDiscoPageState extends State<MobileDiscoPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MobileDiscoPage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Mobile Disco"),
      ),
      body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(0),
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
        crossAxisCount: 3,
        children: <Widget>[
          RandomColorBox(milliseconds: 1000),
          RandomColorBox(milliseconds: 2000),
          RandomColorBox(milliseconds: 500),
          RandomColorBox(milliseconds: 500),
          RandomColorBox(),
          RandomColorBox(milliseconds: 2000),
          RandomColorBox(),
          RandomColorBox(milliseconds: 100),
          RandomColorBox(milliseconds: 400),
        ],
      )),
      /* floatingActionButton: FloatingActionButton(
				onPressed: _incrementCounter,
				tooltip: 'Increment',
				child: Icon(Icons.add),
			),  */ // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class RandomColorBox extends StatefulWidget {
  const RandomColorBox({
    Key? key,
    this.milliseconds = 1000,
  }) : super(key: key);

  final int milliseconds;

  @override
  _RandomColorBoxState createState() => _RandomColorBoxState();
}

class _RandomColorBoxState extends State<RandomColorBox> {
  var color = Colors.black;
  bool _isRunning = true;

  void updateColor() {
    setState(() {
      color = Colors.primaries[Random().nextInt(Colors.primaries.length)];
    });
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(milliseconds: widget.milliseconds), (Timer t) {
      if (!_isRunning)
        t.cancel();
      else
        updateColor();
    });
  }

  @override
  void dispose() {
    _isRunning = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}
