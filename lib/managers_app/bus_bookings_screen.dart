import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BusBookingsScreen extends StatelessWidget {
  final String busId;

  const BusBookingsScreen({Key? key, required this.busId}) : super(key: key);

  Future<List<dynamic>> _getBusBookings() async {
    final busSnapshot =
        await FirebaseFirestore.instance.collection('Buses').doc(busId).get();

    final busData = busSnapshot.data();
    final passengerNames = busData?['passengers'] ?? [];
    final passengerSeatNo = busData?['passengers'] ?? [];

    return passengerNames;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Passengers'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _getBusBookings(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.hasData) {
            final passengerNames = snapshot.data!;
            return ListView.builder(
              itemCount: passengerNames.length,
              itemBuilder: (context, index) {
                final passengerName = passengerNames[index] as String;
                return ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(passengerName),
                  trailing: Text(passengerName),
                );
              },
            );
          } else {
            return const Center(child: Text('No bookings available'));
          }
        },
      ),
    );
  }
}
