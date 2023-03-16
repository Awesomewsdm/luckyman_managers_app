import 'package:flutter/material.dart';
import 'package:luckyman_managers_app/Model/filter_widget.dart';

void main() async {
  runApp(const TestWidget());
}

class TestWidget extends StatefulWidget {
  const TestWidget({super.key});
  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Filter Data'),
      ),
      body: SafeArea(child: FilterWidget()),
    );
  }
}
