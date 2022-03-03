import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localization/src/localization_extension.dart';
import 'package:spotify_clone/Pages/profile.dart';
import 'package:spotify_clone/model/app_state.dart';
import 'package:spotify_clone/redux/actions.dart';

class Imagepicker extends StatefulWidget {
  const Imagepicker({Key? key}) : super(key: key);

  @override
  _ImagepickerState createState() => _ImagepickerState();
}

class _ImagepickerState extends State<Imagepicker> {
  List<XFile>? _imageFileList;

  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : <XFile>[value];
  }

  final ImagePicker _picker = ImagePicker();

  Future<void> _onImageButtonPressed(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
      );
      setState(() {
        _imageFile = pickedFile;
      });
    } catch (e) {
      print(e);
    }
  }

  Widget _previewImages() {
    if (_imageFileList != null) {
      // print("Here**********************************");
      // print(File(_imageFileList![0].path).toString());
      return SingleChildScrollView(
        child: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (context, state) {
            return Semantics(
                child: Column(
                  children: [
                    SizedBox(
                      width: 300,
                      child: ElevatedButton(
                          onPressed: () async {
                            StoreProvider.of<AppState>(context).dispatch(
                                update_image(
                                    _imageFileList![0].path.toString()));
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Profile()));
                          },
                          style:
                              ElevatedButton.styleFrom(primary: Colors.green),
                          child: Text('Done_Button'.i18n())),
                    ),
                    kIsWeb
                        ? Image.network(_imageFileList![0].path)
                        : Image.file(File(_imageFileList![0].path)),
                  ],
                ),
                label: 'image_picker_example_picked_images');
          },
        ),
      );
    } else {
      return Text(
        'Select_Pic_Text'.i18n(),
        textAlign: TextAlign.center,
      );
    }
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _imageFile = response.file;
        _imageFileList = response.files;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Title_Edit_Profilepic'.i18n()),
      ),
      body: Center(
        child: !kIsWeb && defaultTargetPlatform == TargetPlatform.android
            ? FutureBuilder<void>(
                future: retrieveLostData(),
                builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return const Text(
                        'Please Select a Image',
                        textAlign: TextAlign.center,
                      );
                    case ConnectionState.done:
                      return _previewImages();
                    default:
                      if (snapshot.hasError) {
                        return Text(
                          'Pick image/video error: ${snapshot.error}}',
                          textAlign: TextAlign.center,
                        );
                      } else {
                        return const Text(
                          'Please Select a Photo',
                          textAlign: TextAlign.center,
                        );
                      }
                  }
                },
              )
            : _previewImages(),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              _onImageButtonPressed(ImageSource.gallery);
            },
            heroTag: 'gallery',
            child: const Icon(Icons.photo),
          ),
          FloatingActionButton(
            onPressed: () {
              _onImageButtonPressed(ImageSource.camera);
            },
            heroTag: 'camera',
            child: const Icon(Icons.camera_alt),
          ),
        ],
      ),
    );
  }
}
