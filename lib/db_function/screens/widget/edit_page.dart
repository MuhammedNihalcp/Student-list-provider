import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stutents_lists/db_function/functions/db_function.dart';
import 'package:stutents_lists/db_function/models/list_model.dart';
import 'package:stutents_lists/db_function/screens/list_home_page.dart';

class EditScreen extends StatefulWidget {
  EditScreen(
      {Key? key,
      required this.name,
      required this.age,
      required this.phone,
      required this.email,
      required this.data,
      required this.image,
      })
      : super(key: key);

  final String name;
  final String age;
  final String phone;
  final String email;
  final String image;
  int data;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late TextEditingController nameController;

  late TextEditingController ageController;

  late TextEditingController phoneController;

  late TextEditingController emailController;

  final _formkey = GlobalKey<FormState>();
  final ImagePicker picker = ImagePicker();
  String imageToString = 'assets/image/person.jpg';

  @override
  void initState() {
    nameController = TextEditingController(text: widget.name);
    ageController = TextEditingController(text: widget.age);
    phoneController = TextEditingController(text: widget.phone);
    emailController = TextEditingController(text: widget.email);
    imageToString = widget.image;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Stack(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 46,
                        top: 120,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          imagepicker();
                        },
                        child: const Icon(Icons.add_a_photo),
                      ),
                    ),
                  ],
                ),
                const Text('Edit Photo'),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Fill your Name';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    hintText: 'Name',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Fill your Age';
                    } else if (value.length > 2) {
                      return 'Impossible value';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    hintText: 'Age',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Fill your Mobile Number';
                    } else if (value.length != 10) {
                      return 'Number must be 10 digits';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    hintText: 'Mobile Number',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Fill your Email';
                    }
                    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                      return 'Please enter a valid emil address';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    hintText: 'Email Id',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      save(context);
                    }
                  },
                  icon: const Icon(Icons.save_alt_outlined),
                  label: const Text('Save'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void imagepicker() async {
    showDialog(
      context: context,
      builder: (ctx) {
        return Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            width: 200,
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  // onTap: () {
                  //   getImage(ImageSource.camera);
                  //   Navigator.pop(ctx);
                  // },
                  child: const Icon(Icons.camera_alt_sharp),
                ),
                GestureDetector(
                  // onTap: () {
                  //   getImage(ImageSource.gallery);
                  //   Navigator.pop(ctx);
                  // },
                  child: const Icon(Icons.image_search),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  // void getImage(ImageSource source) async {
  //   final image = await ImagePicker().pickImage(source: source);
  //   if (image == null) {
  //     return;
  //   } else {
  //     final imagepath = File(image.path);
  //     setState(() {
  //       widget.image = imagepath.path;
  //     });
  //   }
  // }

  void save(ctx) async {
    ScaffoldMessenger.of(ctx).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
        content: Text('Saving'),
      ),
    );
    await Future.delayed(
      const Duration(seconds: 2),
    );

    final studentModel = StudentModel(
      name: nameController.text,
      age: ageController.text,
      phone: phoneController.text,
      email: emailController.text,
      image: imageToString,
    );

    updateStudent(ctx,widget.data, studentModel);
    if (!mounted) {
      return;
    }
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const ListPage(),
      ),
      (route) => false,
    );
  }
}
