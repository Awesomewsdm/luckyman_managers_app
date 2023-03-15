import 'package:flutter/material.dart';

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
    return Container(
      color: Colors.green,
    );
  }
}
