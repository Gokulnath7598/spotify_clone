import 'package:flutter/material.dart';
import 'package:localization/src/localization_extension.dart';
class Premium extends StatelessWidget{
  const Premium({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Center(child: Text('Nav_Premium'.i18n()),);
  }
}