import 'package:flutter/cupertino.dart';

class EditProvider with ChangeNotifier {
  String image = 'assets/image/person.jpg';
  void changeImage(String? images) {
    image = images;
    notifyListeners();
  }
}