import 'package:flutter/material.dart';
import 'package:stutents_lists/db_function/screens/widget/add_page.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text('Contact'),
      ),
      body: SingleChildScrollView(
        child: AddStudentsWidgeyt(),
      ),
    );
  }
}