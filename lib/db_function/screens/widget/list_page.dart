import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stutents_lists/db_function/functions/db_function.dart';
import 'package:stutents_lists/db_function/models/list_model.dart';
import 'package:stutents_lists/db_function/screens/widget/edit_page.dart';
import 'package:stutents_lists/provider/db_provider/db_provider.dart';

class ListStudentWidget extends StatelessWidget {
  const ListStudentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DataBaseProvider>(builder: ((context, value, child) {
      return value.studentList.isEmpty
          ? const Center(
              child: Text(
                'No students List Found',
                style: TextStyle(fontSize: 20),
              ),
            )
          : ListView.separated(
              itemBuilder: (ctx, index) {
                final data = value.studentList[index];
                return ListTile(
                    title: Text('Name: ${data.name}'),
                    subtitle: Text('Email: ${data.email}'),
                    leading: 
                    // const Icon(Icons.person),
                    CircleAvatar(
                        backgroundImage: MemoryImage(
                            const Base64Decoder().convert(data.image)),
                        radius: 30),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(ctx).push(MaterialPageRoute(
                                  builder: (ctx) => EditScreen(
                                      name: data.name,
                                      age: data.age,
                                      phone: data.phone,
                                      email: data.email,
                                      image: data.image,
                                      data: index)));
                            },
                            icon: const Icon(Icons.edit)),
                        IconButton(
                          onPressed: () {
                            deleteStudent(context, index);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ));
              },
              separatorBuilder: (ctx, index) {
                return const Divider();
              },
              itemCount: value.studentList.length,
            );
    }));
  }
}
