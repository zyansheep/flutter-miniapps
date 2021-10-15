import 'dart:async';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:miniapps/tools/shake_widget.dart';

/// This is the stateful widget that the main application instantiates.
class AddThingsPage extends StatefulWidget {
  const AddThingsPage({Key? key}) : super(key: key);

  @override
  State<AddThingsPage> createState() => _AddThingsPageState();
}

/// This is the private State class that goes with AddThingsPage.
class _AddThingsPageState extends State<AddThingsPage> {
  late TextEditingController _controller;
  String? answer;
  bool isError = false;

  List<String> history = <String>[];

  // Auto scroll-up logic
  final ScrollController _scrollController = ScrollController();

  /* bool _needsScroll = false;
  _scrollToEnd() async {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
  } */

  final shakeKey = GlobalKey<ShakeWidgetState>();
  final textShakeKey = GlobalKey<ShakeWidgetState>();

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
    // Kinda hacky, delaying the scroll until after widget update
    Timer(
        Duration(milliseconds: 100),
        () => _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              curve: Curves.easeOut,
              duration: const Duration(milliseconds: 200),
            ));

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MobileDiscoPage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Add Things"),
      ),
      body: Column(
        children: [
          ShakeWidget(
            key: shakeKey,
            shakeCount: 2,
            shakeOffset: 3,
            shakeDuration: Duration(milliseconds: 200),
            child: TextField(
              autofocus: true,
              textInputAction:
                  TextInputAction.none, // Stay focused on text field
              controller: _controller,
              onChanged: (String expression) async {
                setState(() {
                  try {
                    Parser p = Parser();
                    Expression exp = p.parse(expression);
                    var eval =
                        exp.evaluate(EvaluationType.REAL, ContextModel());
                    answer = "${exp.toString()} = ${eval.toString()}";
                    isError = false;
                  } catch (e) {
                    answer = e.toString();
                    isError = true;
                  }
                });
              },
              onSubmitted: (String value) async {
                setState(() {
                  if (history.isNotEmpty && history.last == answer) {
                  } else if (answer != null && !isError) {
                    history.add(answer!);
                    //_needsScroll = true;
                  } else {
                    setState(() {
                      shakeKey.currentState?.shake();
                      textShakeKey.currentState?.shake();
                    });
                  }
                });
              },
            ),
          ),
          ShakeWidget(
            key: textShakeKey,
            shakeCount: 2,
            shakeOffset: 3,
            shakeDuration: Duration(milliseconds: 200),
            child: SelectableText(
              answer ?? "Invalid Expression",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: !isError ? Colors.black : Colors.red),
            ),
          ),
          Flexible(
            child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(8),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                reverse: true,
                itemCount: history.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child:
                        SelectableText(history[index]),
                  );
                }),
          )
        ],
      ),
    );
  }
}
