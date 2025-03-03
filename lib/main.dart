import 'package:flutter/material.dart';
import 'dbHelper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: userInfo(),
    );
  }
}

class userInfo extends StatefulWidget {
  const userInfo({super.key});

  @override
  State<userInfo> createState() => _userInfoState();
}

class _userInfoState extends State<userInfo> {
  late DatabaseHelper _dbHelper;
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dbHelper = DatabaseHelper();
    _dbHelper.init();
  }

  void _addUser() async {
    final name = _nameController.text;
    final age = int.tryParse(_ageController.text);

    if (name.isEmpty || age == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter valid name and age')),
      );
      return;
    }

    await _dbHelper.insert({
      'name': name,
      'age': age,
    });

    _nameController.clear();
    _ageController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('User added successfully')),
    );

    setState(() {}); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Age',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addUser,
              child: Text('Add User'),
            ),
          ],
        ),
      ),
    );
  }
}
