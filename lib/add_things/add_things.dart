import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

/// This is the stateful widget that the main application instantiates.
class AddThingsPage extends StatefulWidget {
  const AddThingsPage({Key? key}) : super(key: key);

  @override
  State<AddThingsPage> createState() => _AddThingsPageState();
}

/// This is the private State class that goes with AddThingsPage.
class _AddThingsPageState extends State<AddThingsPage> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MobileDiscoPage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Mobile Disco"),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: _controller,
              onChanged: (String expression) async {
                setState(() {
                  /* Expression exp = Parser.parse(expression); */
                });
              },
              /* onSubmitted: (String value) async {
                /* await showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Thanks!'),
                      content: Text(
                          'You typed "$value", which has length ${value.characters.length}.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                ); */
              }, */
            ),
          ],
        ),
      ),
    );
  }
}
