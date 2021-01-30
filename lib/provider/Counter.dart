import 'package:flutter/material.dart';

class Counter with ChangeNotifier {
  int _stateCode = 0;

  int get count => _stateCode;

  add() {
    _stateCode++;
    // NotificationListener(); //更新状态
    notifyListeners();
  }
}
