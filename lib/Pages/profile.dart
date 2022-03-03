import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:localization/src/localization_extension.dart';
import 'package:spotify_clone/Pages/image_picker.dart';
import 'package:spotify_clone/redux/actions.dart';
import 'package:spotify_clone/Pages/settings.dart';

import '../model/app_state.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController namecontroller = TextEditingController();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        body: SingleChildScrollView(
          child: StoreConnector<AppState, AppState>(
            converter: (store) => store.state,
            builder: (context, state) {
              return Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        iconSize: 20.0,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Settings()),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.more_vert),
                        iconSize: 20.0,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  state.image.toString() == 'assets/im.jpg'
                      ? CircleAvatar(
                          backgroundImage: AssetImage(state.image.toString()),
                          radius: 100,
                        )
                      : CircleAvatar(
                          backgroundImage:
                              FileImage(File(state.image.toString())),
                          radius: 100,
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Imagepicker()),
                        );
                      },
                      child: Text('Edit_ProfilePic_Button'.i18n())),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      state.mail.toString(),
                      style:
                          const TextStyle(fontSize: 20.0, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      state.name.toString(),
                      style: const TextStyle(
                          fontSize: 23.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: namecontroller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        alignLabelWithHint: true,
                        hintText: 'Profile_edit_hint'.i18n(),
                        hintStyle: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => {
                        FocusScope.of(context).requestFocus(FocusNode()),
                        StoreProvider.of<AppState>(context).dispatch(
                            update_name(namecontroller.text.toString()))
                      },
                      child: Text('Edit_Button'.i18n()),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
