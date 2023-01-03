import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:stutents_lists/provider/db_provider/db_provider.dart';

import '../models/list_model.dart';

// ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

void addStudent(context, StudentModel value) async {
  var dir = await getApplicationDocumentsDirectory();
  Hive.initFlutter(dir.path);
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  await studentDB.add(value);

  await getAllStudent(context);
}

Future<void> getAllStudent(BuildContext context) async {
  var dir = await getApplicationDocumentsDirectory();
  Hive.initFlutter(dir.path);
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  Provider.of<DataBaseProvider>(context, listen: false)
      .addAllStudent(data: studentDB.values);
}

Future<void> updateStudent(context, int id, StudentModel value) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  studentDB.putAt(id, value);
  await getAllStudent(context);
}

Future<void> deleteStudent(context, int index) async {
  var dir = await getApplicationDocumentsDirectory();
  Hive.initFlutter(dir.path);
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  await studentDB.deleteAt(index);
  await getAllStudent(context);
}
