import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FilterDataFromDB {
  final String selectedDestination;
  final String selectedBusClass;
  final String selectedBusType;
  final String selectedDepartureTime;
  final String selectedDepartureDate;
  final String selectedPickupPoint;

  FilterDataFromDB(
      this.selectedDestination,
      this.selectedBusClass,
      this.selectedBusType,
      this.selectedDepartureTime,
      this.selectedDepartureDate,
      this.selectedPickupPoint);

  doAsyncWork() async {
    print('Calling initializeApp()');
    await Firebase.initializeApp();
    try {
      print('Querying collection group B');
      QuerySnapshot qSnap = await FirebaseFirestore.instance
          .collectionGroup("Booking Info")
          .where("selectedDestination", isEqualTo: selectedDestination)
          .where("selectedBusClass", isEqualTo: selectedBusClass)
          .where("selectedBusType", isEqualTo: selectedBusType)
          .where("selectedDepartureTime", isEqualTo: selectedDepartureTime)
          .where("selectedDepartureDate", isEqualTo: selectedDepartureDate)
          .where("selectedPickupPoint", isEqualTo: selectedPickupPoint)
          .get();
      for (var element in qSnap.docs) {
        print('Collection group element: ${element.data().toString()}');
      }
    } catch (e) {
      print(e);
    }
    print('Complete!');
  }
}
