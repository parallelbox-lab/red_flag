import 'package:flutter/material.dart';

class ThemeManager extends ChangeNotifier {
 late ThemeData _themeData;
 ThemeManager(this._themeData);
 
 getTheme ()=> _themeData;

 setTheme({required ThemeData theme}){
  _themeData = theme;
  notifyListeners();
 }
}