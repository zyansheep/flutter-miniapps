import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AutoSurveyPage extends StatelessWidget {
  final DateFormat dateFormat = DateFormat("MM/dd/yyyy");

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        body: Center(
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      child: Container(
        width: 720,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(8) + EdgeInsets.symmetric(vertical: 64),
          child: Column(
            children: [
              FittedBox(
                  child: Text("SURVEY COMPLETE",
                      style: TextStyle(
                          fontSize: 60,
                          color: const Color.fromARGB(255, 22, 35, 132),
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w100)),
                  fit: BoxFit.contain),
              Divider(),
              FittedBox(
                child: Text(
                  dateFormat.format(DateTime.now()),
                  style: TextStyle(
                      fontSize: 60,
                      color: Color.fromARGB(255, 64, 64, 64),
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w400),
                ),
                fit: BoxFit.contain,
              ),
              Image.asset(
                "assets/auto-survey/animated-checkmark.gif",
                fit: BoxFit.contain,
                width: double.infinity,
              ),
              FittedBox(
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: 'Return to ',
                        style: TextStyle(fontSize: 30, fontFamily: 'Lato')),
                    TextSpan(
                        text: "testalerts.com",
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 91, 0),
                            fontSize: 30,
                            fontFamily: 'Lato')),
                    TextSpan(
                        text: ' .',
                        style: TextStyle(fontSize: 30, fontFamily: 'Lato')),
                  ])),
                  fit: BoxFit.contain)
            ],
          ),
        ),
      ),
    ));
  }
}
