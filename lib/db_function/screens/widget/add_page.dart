import 'dart:convert';
import 'dart:developer';
import 'dart:io';



import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:stutents_lists/db_function/functions/db_function.dart';
import 'package:stutents_lists/db_function/models/list_model.dart';
import 'package:stutents_lists/db_function/screens/list_home_page.dart';
import 'package:stutents_lists/provider/db_provider/image_provider.dart';

class AddStudentsWidgeyt extends StatelessWidget {
  AddStudentsWidgeyt({Key? key}) : super(key: key);
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Consumer<EditProvider>(
              builder: (context, value, child) => 
              GestureDetector(
                onTap: (() {
                  pickImage(context);
                }),
                child: value.image != null
                    ? CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(value.image),
                      )
                    : imageProfile(),
              ),
            ),
             SizedBox(
              height: height * 0.05,
            ),
            TextFormField(
              controller: _nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Fill your Name';
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.account_circle_outlined),
                border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue, width: 10),
                    borderRadius: BorderRadius.circular(16)),
                hintText: 'Name',
                filled: true,
                fillColor: const Color.fromARGB(255, 212, 208, 208),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Fill your age';
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.add_reaction),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                hintText: 'Age',
                filled: true,
                fillColor: const Color.fromARGB(255, 212, 208, 208),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'File your Phone Number';
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.phone),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                hintText: 'Phone',
                filled: true,
                fillColor: const Color.fromARGB(255, 212, 208, 208),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'File your Email Id';
                }
                if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                  return 'Please enter your valid email id';
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Colors.white)),
                hintText: 'Email',
                filled: true,
                fillColor: const Color.fromARGB(255, 212, 208, 208),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton.icon(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  onAddStudents(context);
                }
              },
              icon: const Icon(Icons.add),
              label: const Text('Add'),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.indigo)),
            ),
          ],
        ),
      ),
    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage:
                MemoryImage(const Base64Decoder().convert(imageToString)),
          ),
          const Positioned(
            bottom: 20,
            right: 20,
            child: Icon(
              Icons.edit,
              size: 20,
            ),
          )
        ],
      ),
    );
  }

   String imageToString = '';
   

  pickImage(context) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    } else {
      final imageTemporary = File(image.path).readAsBytesSync();
       imageToString = base64Encode(imageTemporary);
      Provider.of<EditProvider>(context, listen: false)
          .changeImage(imageToString);
    }
  }

  Future<void> onAddStudents(BuildContext ctx) async {
    final name = _nameController.text.trim();
    final age = _ageController.text.trim();
    final phone = _phoneController.text.trim();
    final email = _emailController.text.trim();

    if (name.isEmpty || age.isEmpty || phone.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
          content: Text('Please File The Form'),
        ),
      );
    } else {
      final student = StudentModel(
          name: name,
          age: age,
          phone: phone,
          email: email,
          image: imageToString ,
          );
        log(student.image.toString());
      addStudent(ctx, student);
      Navigator.of(ctx).pushReplacement(
          MaterialPageRoute(builder: (ctx) => const ListPage()));
    }
  }
}
