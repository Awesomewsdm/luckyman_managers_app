import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddDetailsScreen extends StatefulWidget {
  const AddDetailsScreen({super.key});

  @override
  State<AddDetailsScreen> createState() => _AddDetailsScreenState();
}

class _AddDetailsScreenState extends State<AddDetailsScreen> {
  final TextEditingController destinationController = TextEditingController();
  final TextEditingController busTypeController = TextEditingController();
  final TextEditingController originController = TextEditingController();
  final TextEditingController busClassController = TextEditingController();
  final TextEditingController departureTimeController = TextEditingController();
  final TextEditingController departureDateController = TextEditingController();
  final TextEditingController agentController = TextEditingController();
  final TextEditingController pickupPointController = TextEditingController();

  List<String> destinations = [];
  List<String> busTypes = [];
  List<String> origins = [];
  List<String> busClasses = [];
  List<String> departureTimes = [];
  List<String> departureDates = [];
  List<String> agents = [];
  List<String> pickupPoints = [];

  void addDetailsToFirestore(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference detailsCollection =
        firestore.collection("Booking Data").doc("booking-menu-items");

    // List<Map<String, dynamic>> detailsList = [];

    Map<String, dynamic> bookingData = {
      'Destinations': destinations,
      'Bus Types': busTypes,
      'Origin': origins,
      'Bus Classes': busClasses,
      'Departure Times': departureTimes,
      'Departure Dates': departureDates,
      'Agents': agents,
      'Pickup Points': pickupPoints,
    };

    // detailsList.add(details);

    detailsCollection.set(bookingData, SetOptions(merge: true)).then((value) {
      // Successful addition to Firestore
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Details added successfully'),
        ),
      );
      // Clear the text fields and lists
      destinationController.clear();
      busTypeController.clear();
      originController.clear();
      busClassController.clear();
      departureTimeController.clear();
      departureDateController.clear();
      agentController.clear();
      pickupPointController.clear();
      setState(() {
        destinations.clear();
        busTypes.clear();
        origins.clear();
        busClasses.clear();
        departureTimes.clear();
        departureDates.clear();
        agents.clear();
        pickupPoints.clear();
      });
    }).catchError((error) {
      // Error occurred while adding to Firestore
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add details')),
      );
    });
  }

  void addValueToList(String value, List<String> list) {
    if (value.isNotEmpty) {
      setState(() {
        list.add(value.trim());
      });
    }
  }

  Widget buildInputTextField(TextEditingController controller, String label,
      IconData icon, List<String> list) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 45,
                ),
                const Expanded(
                    child: Divider(
                  thickness: 5,
                )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(label),
                ),
                const Expanded(
                    child: Divider(
                  thickness: 5,
                )),
              ],
            ),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                icon: Icon(icon),
                labelText: label,
              ),
              onSubmitted: (value) {
                addValueToList(value, list);
                controller.clear();
              },
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: List.generate(
            list.length,
            (index) => Chip(
              label: Text(list[index]),
              deleteIcon: const Icon(Icons.cancel),
              onDeleted: () {
                setState(() {
                  list.removeAt(index);
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Bus Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildInputTextField(
                destinationController,
                'Destinations',
                Icons.telegram,
                destinations,
              ),
              const SizedBox(height: 16.0),
              buildInputTextField(
                busTypeController,
                'Bus Types',
                Icons.umbrella,
                busTypes,
              ),
              const SizedBox(height: 16.0),
              buildInputTextField(
                originController,
                'Origins',
                Icons.location_pin,
                origins,
              ),
              const SizedBox(height: 16.0),
              buildInputTextField(
                busClassController,
                'Bus Classes',
                Icons.bus_alert,
                busClasses,
              ),
              const SizedBox(height: 16.0),
              buildInputTextField(
                departureTimeController,
                'Departure Times',
                Icons.alarm,
                departureTimes,
              ),
              const SizedBox(height: 16.0),
              buildInputTextField(
                departureDateController,
                'Departure Dates',
                Icons.calendar_view_day,
                departureDates,
              ),
              const SizedBox(height: 16.0),
              buildInputTextField(
                agentController,
                'Agents',
                Icons.person,
                agents,
              ),
              const SizedBox(height: 16.0),
              buildInputTextField(
                pickupPointController,
                'Pickup Points',
                Icons.home,
                pickupPoints,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () => addDetailsToFirestore(context),
                child: const Text('Add Details'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void navigateToAddDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddDetailsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => navigateToAddDetails(context),
          child: const Text('Add Details'),
        ),
      ),
    );
  }
}
