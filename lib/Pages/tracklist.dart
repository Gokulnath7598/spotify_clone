import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:localization/src/localization_extension.dart';
import 'package:spotify_clone/model/tracks.dart';
import 'package:spotify_clone/spotifyapi/gettracks.dart';

import '../model/app_state.dart';

class TrackList extends StatelessWidget {
  final List<dynamic> tracks;
  final String album;

  const TrackList({Key? key, required this.tracks, required this.album})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String album = this.album;
    List<dynamic> tracks = this.tracks;
    return StoreConnector<AppState, VoidCallback>(
      converter: (store) => () => store.dispatch(gettracks(tracks)),
      builder: (context, callback) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark(),
          home: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                iconSize: 20.0,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              centerTitle: true,
              title: Text('Title_Tracks'.i18n()),
            ),
            body: Column(
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(12),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      album,
                      style: const TextStyle(
                          fontSize: 23.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  child:
                      // ListView.builder(
                      //             shrinkWrap: true,
                      //             scrollDirection: Axis.vertical,
                      //             itemCount: items.length,
                      //             itemBuilder: (context, index) {
                      //               Tracks item = items[index];
                      //               return
                      StoreConnector<AppState, AppState>(
                          converter: (store) => store.state,
                          builder: (context, state) {
                            return ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: state.tracklist.length,
                              itemBuilder: (context, index) {
                                Track item = state.tracklist[index];
                                return ListTile(
                                  contentPadding: const EdgeInsets.all(5),
                                  title: Text(item.name.toString()),
                                  leading: Image.network(
                                    item.url.toString(),
                                    fit: BoxFit.fitHeight,
                                  ),
                                  subtitle: Text(item.artistname),
                                  trailing: const Icon(Icons.more_vert),
                                );
                              },
                            );
                          }),
                  //   },
                  // ),
                ),
              ],
            ),
            // floatingActionButton:
            // StoreConnector<AppState, VoidCallback>(
            //   converter: (store) => () => store.dispatch(getval(tracks)),
            //   builder: (context, callback) {
            //     return FloatingActionButton(
            //       onPressed: callback,
            //       child: const Icon(Icons.cloud_download),
            //     );
            //   },
            // ),
          ),
        );
      },
    );
  }
}
