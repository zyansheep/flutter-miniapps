import 'package:flutter/material.dart';
import 'package:mobile_disco/mobile_disco/mobile_disco.dart';

import 'add_things/add_things.dart';

void main() {
	runApp(MyApp());
}

class MyApp extends StatelessWidget {
	// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => HomePage(),
        '/mobile_disco': (context) => MobileDiscoPage(),
        '/add_things': (context) => AddThingsPage(),
      },
      /* home: MobileDiscoPage(title: 'Flutter Demo Home Page'), */
    );
  }
}


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Geeks for Geeks'),
        backgroundColor: Colors.green,
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          ElevatedButton(
            child: Text('Mobile Disco'),
            onPressed: () {
              Navigator.pushNamed(context, '/mobile_disco');
            },
          ),
          ElevatedButton(
            child: Text('Add Things'),
            onPressed: () {
              Navigator.pushNamed(context, '/add_things');
            },
          ),
        ],
      )),
    );
  }
}
