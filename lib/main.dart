// We could have made one ValueNotifier<CoreState> and it would have worked,
// because it's not like a list.
// instead of  home: MainPage(bgColorNotifier), we added it to child parameter,
// so MainPage doesn't actually get rebuilt every time the bgColor changes
// maybe this and practice_flutter_10_inheritedmodel are the best of all versions,
// because only the changed widget is rebuilt

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
    final bgColorNotifier = ValueNotifier<Color>(Colors.green);
    return ValueListenableBuilder(
      valueListenable: bgColorNotifier,
      builder: (BuildContext context, Color bgColor, Widget? child) =>
          MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
          scaffoldBackgroundColor: bgColor,
          primaryColor: Colors.white,
        ),
        home: child,
      ),
      child: MainPage(bgColorNotifier),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage(this.bgColorNotifier, {super.key});

  final ValueNotifier<Color> bgColorNotifier;

  @override
  Widget build(BuildContext context) {
    final counterNotififer = ValueNotifier<int>(0);
    return Scaffold(
      appBar: AppBar(
        title: const Text(MyApp.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ValueListenableBuilder(
                valueListenable: counterNotififer,
                builder: (BuildContext context, int counter, Widget? child) =>
                    Text(
                      '$counter',
                      style: const TextStyle(fontSize: 100),
                    )),
            const SizedBox(height: 47),
            ButtonWidget(
              text: 'Change Color',
              onClicked: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => ColorPage(bgColorNotifier),
                ),
              ),
            ),
            const SizedBox(height: 24),
            ButtonWidget(
              text: 'Change Counter',
              onClicked: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      CounterPage(counterNotififer),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
