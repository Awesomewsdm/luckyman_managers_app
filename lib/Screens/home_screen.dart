import 'package:flutter/material.dart';
import 'package:luckyman_managers_app/Model/filter_widget.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});
  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Filter Data'),
        // actions: [IconButton(onPressed: () => const SimplifiedBookingData(), icon: const Icon(Icons.description_rounded))],
      ),
      body: FilterWidget(),
    );
  }
}
