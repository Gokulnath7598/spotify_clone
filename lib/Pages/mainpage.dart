import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:spotify_clone/Pages/settings.dart';
import 'package:spotify_clone/model/album.dart';
import 'package:spotify_clone/model/artist.dart';
import 'package:spotify_clone/spotifyapi/getartists.dart';
import 'package:spotify_clone/spotifyapi/gettracks.dart';
import 'package:spotify_clone/Pages/tracklist.dart';
import '../model/app_state.dart';
import '../spotifyapi/getalbum.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 14,
              ),
              SizedBox(
                height: 250.0,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          child: const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Albums',
                              style: TextStyle(
                                  fontSize: 23.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                  Icons.notifications_active_outlined),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                  Icons.settings_backup_restore_outlined),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Settings()),
                                  );
                                },
                                icon: const Icon(Icons.settings)),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      height: 165.0,
                      child: StoreConnector<AppState, AppState>(
                          converter: (store) => store.state,
                          builder: (context, state) {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.albumlist.length,
                              itemBuilder: (context, index) {
                                Album item = state.albumlist[index];
                                return StoreConnector<AppState, Function>(
                                  converter: (store) =>
                                      () => store.dispatch(gettracks(item.tracks)),
                                  builder: (context, callback) {
                                    return InkWell(
                                      onTap: () async {
                                        await callback();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => TrackList(
                                                tracks: item.tracks,
                                                album: item.name,
                                              )
                                            // (context) => Tracklist(
                                            // tracks: item.tracks,
                                            // album: item.name)
                                          ),
                                        );
                                      },
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 130.0,
                                            width: 140.0,
                                            child: Image.network(
                                              item.url.toString(),
                                              fit: BoxFit.fitHeight,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          Text(
                                            item.name.toString(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 10.0,
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          }),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 250.0,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(12),
                      child: const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Artists',
                          style: TextStyle(
                              fontSize: 23.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    InkWell(
                      child: SizedBox(
                        height: 165.0,
                        child: StoreConnector<AppState, AppState>(
                            converter: (store) => store.state,
                            builder: (context, state) {
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: state.artistlist.length,
                                itemBuilder: (context, index) {
                                  Artist item = state.artistlist[index];
                                  return Column(
                                    children: [
                                      SizedBox(
                                        height: 130.0,
                                        width: 140.0,
                                        child: Image.network(
                                          item.url.toString(),
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        item.name.toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10.0,
                                        ),
                                      )
                                    ],
                                  );
                                },
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: StoreConnector<AppState, Function>(
                  converter: (store) => () => store.dispatch(getalbum()),
                  builder: (context, callback1) {
                    return StoreConnector<AppState, Function>(
                      converter: (store) => () => store.dispatch(getartist()),
                      builder: (context, callback) {
                        return ElevatedButton(
                          onPressed: () async {
                            callback();
                            await callback1();
                          },
                          child: const Text('Load Data'),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
      //),
    );
  }
}
// class MainPage extends StatefulWidget {
//   const MainPage({Key? key}) : super(key: key);
//
//   @override
//   _MainPageState createState() => _MainPageState();
// }
//
// class _MainPageState extends State<MainPage> {
//   late Future<List<Album>?> futureAlbumList;
//   late Future<List<Artist>?> futureArtistList;
//
//   @override
//   void initState() {
//     super.initState();
//     futureAlbumList = fetchAlbum();
//     futureArtistList = fetchArtists();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children: [
//         SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               const SizedBox(
//                 height: 14,
//               ),
//               SizedBox(
//                 height: 250.0,
//                 child: Column(
//                   children: <Widget>[
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.all(12),
//                           child: const Align(
//                             alignment: Alignment.topLeft,
//                             child: Text(
//                               'Albums',
//                               style: TextStyle(
//                                   fontSize: 23.0, fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                         ),
//                         Row(
//                           children: [
//                             StoreConnector<AppState, Function>(
//                               converter: (store) =>
//                                   () => store.dispatch(getalbum()),
//                               builder: (context, callback) {
//                                 return IconButton(
//                                   onPressed: () {
//                                     callback();
//                                   },
//                                   icon: const Icon(
//                                       Icons.notifications_active_outlined),
//                                 );
//                               },
//                             ),
//                             StoreConnector<AppState, Function>(
//                               converter: (store) =>
//                                   () => store.dispatch(getartist()),
//                               builder: (context, callback) {
//                                 return IconButton(
//                                   onPressed: () {
//                                     callback();
//                                   },
//                                   icon: const Icon(
//                                       Icons.settings_backup_restore_outlined),
//                                 );
//                               },
//                             ),
//                             const SizedBox(
//                               width: 10,
//                             ),
//                             IconButton(
//                                 onPressed: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => const Settings()),
//                                   );
//                                 },
//                                 icon: const Icon(Icons.settings)),
//                             const SizedBox(
//                               width: 0,
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 12,
//                     ),
//                     SizedBox(
//                       height: 165.0,
//                       child: StoreConnector<AppState, AppState>(
//                           converter: (store) => store.state,
//                           builder: (context, state) {
//                             return ListView.builder(
//                               scrollDirection: Axis.horizontal,
//                               itemCount: state.albumlist.length,
//                               itemBuilder: (context, index) {
//                                 Album item = state.albumlist[index];
//                                 return StoreConnector<AppState, Function>(
//                                   converter: (store) =>
//                                       () => store.dispatch(getval(item.tracks)),
//                                   builder: (context, callback) {
//                                     return InkWell(
//                                       onTap: () async {
//                                         await callback();
//                                         Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (context) => TrackL(
//                                                     tracks: item.tracks,
//                                                     album: item.name,
//                                                   )
//                                               // (context) => Tracklist(
//                                               // tracks: item.tracks,
//                                               // album: item.name)
//                                               ),
//                                         );
//                                       },
//                                       child: Column(
//                                         children: [
//                                           SizedBox(
//                                             height: 130.0,
//                                             width: 140.0,
//                                             child: Image.network(
//                                               item.url.toString(),
//                                               fit: BoxFit.fitHeight,
//                                             ),
//                                           ),
//                                           const SizedBox(
//                                             height: 6,
//                                           ),
//                                           Text(
//                                             item.name.toString(),
//                                             style: const TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 10.0,
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     );
//                                   },
//                                 );
//                               },
//                             );
//                           }),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 250.0,
//                 child: Column(
//                   children: <Widget>[
//                     Container(
//                       padding: const EdgeInsets.all(12),
//                       child: const Align(
//                         alignment: Alignment.topLeft,
//                         child: Text(
//                           'Artists',
//                           style: TextStyle(
//                               fontSize: 23.0, fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 12,
//                     ),
//                     InkWell(
//                       child: SizedBox(
//                         height: 165.0,
//                         child: StoreConnector<AppState, AppState>(
//                             converter: (store) => store.state,
//                             builder: (context, state) {
//                               return ListView.builder(
//                                 scrollDirection: Axis.horizontal,
//                                 itemCount: state.artistlist.length,
//                                 itemBuilder: (context, index) {
//                                   Artist item = state.artistlist[index];
//                                   return Column(
//                                     children: [
//                                       SizedBox(
//                                         height: 130.0,
//                                         width: 140.0,
//                                         child: Image.network(
//                                           item.url.toString(),
//                                           fit: BoxFit.fitHeight,
//                                         ),
//                                       ),
//                                       const SizedBox(
//                                         height: 6,
//                                       ),
//                                       Text(
//                                         item.name.toString(),
//                                         style: const TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 10.0,
//                                         ),
//                                       )
//                                     ],
//                                   );
//                                 },
//                               );
//                             }),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//       //),
//     );
//   }
// }
