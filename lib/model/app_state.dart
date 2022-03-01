import 'package:flutter/material.dart';

class AppState{
  late String name;
  late String mail;
  AppState({required this.name,required this.mail});
  AppState.fromAppState(AppState another)
  {
    name = another.name;
    mail = another.mail;
  }
  String get viewname => name;
  String get viewmail => mail;
}