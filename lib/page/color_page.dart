import 'package:flutter/material.dart';
import '/main.dart';

class ColorPage extends StatelessWidget {
  const ColorPage(this.bgColorNotifier, {super.key});

  final ValueNotifier<Color> bgColorNotifier;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(MyApp.title),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 64),
          child: Center(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  buildColorButton(context, Colors.red),
                  buildColorButton(context, Colors.orange),
                  buildColorButton(context, Colors.greenAccent),
                  buildColorButton(context, Colors.indigo),
                ],
              ),
            ),
          ),
        ),
      );

  Widget buildColorButton(BuildContext context, Color color) => Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: color, elevation: 0),
          onPressed: () {
            bgColorNotifier.value = color;
            Navigator.pop(context);
          },
          child: Container(height: 100),
        ),
      );
}
