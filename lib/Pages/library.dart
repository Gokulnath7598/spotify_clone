import 'package:flutter/material.dart';
import 'package:localization/src/localization_extension.dart';
class Library extends StatelessWidget{
  const Library({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Center(child: Text('Nav_Library'.i18n()),);
  }
}