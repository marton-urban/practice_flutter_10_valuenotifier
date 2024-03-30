import 'package:flutter/material.dart';
import '/widget/button_widget.dart';

class CounterPage extends StatefulWidget {
  const CounterPage(this.counter, {super.key});

  final ValueNotifier<int> counter;

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 48),
              child: buildTextField(onSubmitted: setStringCounter),
            ),
            const SizedBox(height: 24),
            ButtonWidget(
              text: 'Update Counter',
              onClicked: () => setStringCounter(controller.text),
            ),
            const SizedBox(height: 64),
            ButtonWidget(
              text: 'Increment Counter',
              onClicked: increment,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField({
    required ValueChanged<String> onSubmitted,
  }) =>
      TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        keyboardType: TextInputType.number,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          hintText: 'Counter',
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.white),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.white),
          ),
          hintStyle: const TextStyle(color: Colors.white70),
        ),
      );

  void increment() {
    widget.counter.value++;

    Navigator.pop(context);
  }

  void setStringCounter(String value) {
    final newCounter = int.tryParse(value);
    widget.counter.value = newCounter!;

    Navigator.pop(context);
  }
}
