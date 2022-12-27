
import 'package:flutter/cupertino.dart';

class ObsecureProvider extends ChangeNotifier {
  bool obsecure = true ;
  void changeObsecure (bool change) {
    obsecure = change ;
    notifyListeners() ;
  }
}