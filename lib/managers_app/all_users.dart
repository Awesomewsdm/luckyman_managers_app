import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? fullName;
  final String? phoneNumber;

  UserModel({this.fullName, this.phoneNumber});
}

class AllUsers extends StatefulWidget {
  const AllUsers({Key? key}) : super(key: key);

  @override
  _AllUsersState createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  final _db = FirebaseFirestore.instance;
  late Future<List<UserModel>> _userList;
  final TextEditingController _searchController = TextEditingController();
  List<UserModel> _filteredList = [];

  @override
  void initState() {
    super.initState();
    _userList = allUser();
  }

  Future<List<UserModel>> allUser() async {
    final snapshot = await _db.collection("Users").get();
    final userData = snapshot.docs.map((e) {
      final data = e.data();
      return UserModel(
        fullName: data["fullName"],
        phoneNumber: data["phoneNumber"],
      );
    }).toList();

    // Sort user data by full name in alphabetical order
    userData.sort((a, b) => (a.fullName ?? '').compareTo(b.fullName ?? ''));

    return userData;
  }

  void _filterUsers(String searchText) {
    _userList.then((userList) {
      List<UserModel> filteredList = userList
          .where((user) =>
              user.fullName!.toLowerCase().contains(searchText.toLowerCase()) ||
              user.phoneNumber!.contains(searchText))
          .toList();
      setState(() {
        _filteredList = filteredList;
      });
    });
  }

  void _performSearch() {
    _filterUsers(_searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Users'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: _filterUsers,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Search by name or phone number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _performSearch,
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<UserModel>>(
              future: _userList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final userList = _searchController.text.isNotEmpty
                      ? _filteredList
                      : snapshot.data!;
                  return ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      final user = userList[index];
                      return ListTile(
                        leading: const Icon(Icons.person),
                        title: Text(user.fullName ?? 'N/A'),
                        subtitle: Text(user.phoneNumber ?? 'N/A'),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
