import 'package:flutter/material.dart';
import 'package:localization/src/localization_extension.dart';
class SSearch extends StatelessWidget {
  const SSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Nav_Search'.i18n()),);
  }
}

