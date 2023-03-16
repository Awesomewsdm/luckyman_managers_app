
// 
// 
// 
// 
// StreamBuilder<QuerySnapshot>(
//                   stream: _usersStream,
//                   builder: (BuildContext context,
//                       AsyncSnapshot<QuerySnapshot> snapshot) {
//                     if (snapshot.hasError) {
//                       return const Center(child: Text('Something went wrong'));
//                     }
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const Center(child: Text("Loading..."));
//                     }
//                     seatCounter++;
//                     String seatNo = '$seatCounter';

//                     return ListView(
//                         children: snapshot.data!.docs
//                             .map((DocumentSnapshot document) {
//                               Map<String, dynamic> data =
//                                   document.data()! as Map<String, dynamic>;
//                               return ListTile(
//                                 leading: CircleAvatar(
//                                   backgroundColor: Colors.primaries[Random()
//                                       .nextInt(Colors.primaries.length)],
//                                   child: const Icon(Icons.person_2_outlined),
//                                 ),
//                                 title: Text(data['fullName']),
//                                 subtitle: Text(data['selectedSeatNo'] == null
//                                     ? "No seat booked yet"
//                                     : "Seat No: ${data['selectedSeatNo']}"),
//                                 trailing: const CircleAvatar(
//                                   backgroundColor: Colors.red,
//                                   child: Icon(Icons.close),
//                                 ),
//                               );
//                             })
//                             .toList()
//                             .cast());
//                   },
//                 ),


// StreamBuilder<QuerySnapshot>(
//                   stream: _usersStream,
//                   builder: (BuildContext context,
//                       AsyncSnapshot<QuerySnapshot> snapshot) {
//                     if (snapshot.hasError) {
//                       return const Center(child: Text('Something went wrong'));
//                     }
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const Center(child: Text("Loading..."));
//                     }
//                     seatCounter++;
//                     String seatNo = '$seatCounter';

//                     return ListView(
//                         children: snapshot.data!.docs
//                             .map((DocumentSnapshot document) {
//                               Map<String, dynamic> data =
//                                   document.data()! as Map<String, dynamic>;
//                               return ListTile(
//                                 leading: CircleAvatar(
//                                   backgroundColor: Colors.primaries[Random()
//                                       .nextInt(Colors.primaries.length)],
//                                   child: const Icon(Icons.person_2_outlined),
//                                 ),
//                                 title: Text(data['fullName']),
//                                 subtitle: Text(data['selectedSeatNo'] == null
//                                     ? "No seat booked yet"
//                                     : "Seat No: ${data['selectedSeatNo']}"),
//                                 trailing: const CircleAvatar(
//                                   backgroundColor: Colors.red,
//                                   child: Icon(Icons.close),
//                                 ),
//                               );
//                             })
//                             .toList()
//                             .cast());
//                   },
//                 ),

  // StreamBuilder<QuerySnapshot>(
  //                 stream: bookingStrem,
  //                 builder: (BuildContext context,
  //                     AsyncSnapshot<QuerySnapshot> snapshot) {
  //                   if (snapshot.hasError) {
  //                     return const Center(child: Text('Something went wrong'));
  //                   }
  //                   if (snapshot.connectionState == ConnectionState.waiting) {
  //                     return const Center(child: Text("Loading..."));
  //                   }

  //                   return ListView.builder(
  //                       itemCount: snapshot.data!.docs.length,
  //                       itemBuilder: (BuildContext context, int index) {
  //                         var userName = snapshot.data!.docs[index]["selectedDestination"];
  //                         var userSelectedSeatNo = snapshot.data!.docs[index];

  //                         return ListTile(
  //                           leading: CircleAvatar(
  //                             backgroundColor: Colors.primaries[
  //                                 Random().nextInt(Colors.primaries.length)],
  //                             child: Text("${index + 1}"),
  //                           ),
  //                           title: Text(userName),
  //                           subtitle: FutureBuilder(
  //                             future: getBookingMenuItems(),
  //                             builder: (BuildContext context,
  //                                 AsyncSnapshot<dynamic> snapshot) {
  //                               if (snapshot.connectionState ==
  //                                   ConnectionState.done) {
  //                                 if (snapshot.hasData) {
  //                                   return Text(snapshot
  //                                               .data["selectedSeatNo"] ==
  //                                           null
  //                                       ? "No seat booked"
  //                                       : 'Seat No: ${snapshot.data["selectedSeatNo"]}');
  //                                 } else {
  //                                   return const Text("No data available");
  //                                 }
  //                               } else {
  //                                 return const Text(
  //                                     "Loading seat information...");
  //                               }
  //                             },
  //                           ),
  //                           trailing: RoundCheckBox(
  //                             uncheckedColor: Colors.red,
  //                             uncheckedWidget: const Icon(Icons.close),
  //                             onTap: (selected) {},
  //                           ),
  //                         );
  //                       });
  //                 },
  //               ),