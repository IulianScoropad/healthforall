import 'package:healthforall/controllers.dart';
import '../../constants.dart';
import 'package:healthforall/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ProfileScreen extends StatefulWidget {
  DatabaseReference dbRef = FirebaseDatabase.instance.ref();

   ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
   late String _name ;
  late  String _email ;
   late String _phoneNumber;
  late  String _address ;
   late  String _region ;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final databaseReference = FirebaseDatabase.instance.ref();
      DatabaseEvent event = await databaseReference.child('Pacienti/$globalUserId').once();
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        Map<String, dynamic> userData = Map<String, dynamic>.from(snapshot.value as Map<dynamic, dynamic>);
        setState(() {
          _name = userData['username'];
          _email = userData['mail'];
          _phoneNumber = userData['phone'];
          _address = userData['adress'];
          _region = userData['region'];
          _isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SettingsScreen(),
              ),
            ),
            icon: const Icon(
              Icons.settings,
              color: primaryColor,
            ),
          ),
        ],
      ),
      body:  _isLoading
          ? const Center(child: CircularProgressIndicator())
          :SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.all(Radius.circular(defaultPadding / 2)),
              child: Image.asset(
                "assets/images/user.png",
                height: 120,
                width: 120,
              ),
            ),
            const SizedBox(height: defaultPadding),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    initialValue: _name,
                      readOnly: true,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: defaultPadding),
                    child: TextFormField(
                      initialValue: _email,
                        readOnly: true,
                    ),
                  ),
                  TextFormField(
                    initialValue: _phoneNumber,
                      readOnly: true,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: defaultPadding),
                    child: TextFormField(
                      initialValue: _address,
                    ),
                  ),
                  TextFormField(
                    initialValue: _region,
                    readOnly: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

