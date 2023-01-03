import 'package:hive_flutter/hive_flutter.dart';
 part 'list_model.g.dart';
@HiveType(typeId: 1)
class StudentModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String age;
  @HiveField(3)
  final String phone;
  @HiveField(4)
  final String email;
  @HiveField(5)
  final String image;

  StudentModel(
      {required this.name,
      required this.age,
      required this.phone,
      required this.email,
      required this.image,
      this.id});
}
