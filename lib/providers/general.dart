import 'package:flutter/cupertino.dart';

class General extends ChangeNotifier {
  int currentWeek = 1;

  Future<int> getCurrentweek() async {
    await Future.delayed(const Duration(seconds: 2));
    return currentWeek;
  }
}
