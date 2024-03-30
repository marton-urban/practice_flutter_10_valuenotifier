// We could have made one ValueNotifier<CoreState> and it would have worked,
// because it's not like a list.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'page/color_page.dart';
import 'page/counter_page.dart';
import 'widget/button_widget.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String title = 'ValueNotifier';

  @override
  Widget build(BuildContext context) {
    final backgroundColor = ValueNotifier<Color>(Colors.green);
    return ListenableBuilder(
        listenable: backgroundColor,
        builder: (BuildContext context, Widget? child) => MaterialApp(
              debugShowCheckedModeBanner: false,
              title: title,
              theme: ThemeData(
                scaffoldBackgroundColor: backgroundColor.value,
                primaryColor: Colors.white,
              ),
              home: MainPage(backgroundColor),
            ));
  }
}

class MainPage extends StatelessWidget {
  const MainPage(this.backgroundColor, {super.key});

  final ValueNotifier<Color> backgroundColor;

  @override
  Widget build(BuildContext context) {
    final counter = ValueNotifier<int>(0);
    return Scaffold(
      appBar: AppBar(
        title: const Text(MyApp.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListenableBuilder(
                listenable: counter,
                builder: (BuildContext context, Widget? child) => Text(
                      '${counter.value}',
                      style: const TextStyle(fontSize: 100),
                    )),
            const SizedBox(height: 47),
            ButtonWidget(
              text: 'Change Color',
              onClicked: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => ColorPage(backgroundColor),
                ),
              ),
            ),
            const SizedBox(height: 24),
            ButtonWidget(
              text: 'Change Counter',
              onClicked: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => CounterPage(counter),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
