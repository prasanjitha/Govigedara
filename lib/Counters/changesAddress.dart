import 'package:flutter/foundation.dart';

class AddressChangers extends ChangeNotifier{
  int _counter=0;
  int get counter=>_counter;

  displayResult(int v)
  {
    _counter=v;
    notifyListeners();
  }
}