import 'package:flutter/material.dart';
import 'package:spotify_clone/spotifyapi/getartists.dart';
import 'package:spotify_clone/tracklist.dart';
import 'spotifyapi/getalbum.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late Future<List<Album>?> futureAlbumList;
  late Future<List<Artist>?> futureArtistList;

  @override
  void initState() {
    super.initState();
    futureAlbumList = fetchAlbum();
    futureArtistList = fetchArtists();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          // Color.fromARGB(1,128,0,128),
          Colors.purple,
          Colors.black,
        ], begin: Alignment.topLeft, end: FractionalOffset(0.3, 0.3)),
      ),
      child: ListView(
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
                                    fontSize: 23.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Row(
                            children: const [
                              Icon(Icons.notifications_active_outlined),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.settings_backup_restore_outlined),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.settings),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        height: 165.0,
                        child: FutureBuilder<List<Album>?>(
                            future: futureAlbumList,
                            builder: (context, snapshot) {
                              List<Album> items = snapshot.data ?? [];
                              if (snapshot.hasData) {
                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: items.length,
                                  itemBuilder: (context, index) {
                                    Album item = items[index];
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Tracklist(
                                                  tracks: item.tracks,
                                                  album: item.name)),
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
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              return const Center(
                                  child: CircularProgressIndicator());
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
                          child: FutureBuilder<List<Artist>?>(
                              future: futureArtistList,
                              builder: (context, snapshot) {
                                List<Artist> items = snapshot.data ?? [];
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: items.length,
                                    itemBuilder: (context, index) {
                                      Artist item = items[index];
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
                                } else if (snapshot.hasError) {
                                  return Text('${snapshot.error}');
                                }
                                return const Center(
                                    child: CircularProgressIndicator());
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}