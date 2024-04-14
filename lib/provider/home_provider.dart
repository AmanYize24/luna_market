import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier{
  String _imgUrl = '';
  get profileImg => _imgUrl;
  void setImgUrl(){
    _imgUrl = '';
  }
 }