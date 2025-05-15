import 'package:flutter/widgets.dart';

class UIVM with ChangeNotifier{
  bool _isButtonListopen = false;
  bool get isButtonListopen => _isButtonListopen; 

  Map<String , String> routeName = {
    "Home" : "/home", 
    "Clander" : "/clander",
    "TaskList" : "/tasklest"
  };
  
  void toggleButtonList(){
    _isButtonListopen = !_isButtonListopen; // 切換清單顯示狀態
    notifyListeners();
  }
}