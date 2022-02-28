import 'package:flutter/material.dart';
import 'package:spotify_clone/spotifyapi/gettracks.dart';

class Tracklist extends StatefulWidget {
  final List tracks;
  final String album;

  const Tracklist({Key? key, required this.tracks, required this.album})
      : super(key: key);

  @override
  _TracklistState createState() => _TracklistState();
}

class _TracklistState extends State<Tracklist> {
  late Future<List<Tracks>?> futureTracksList;

  @override
  void initState() {
    super.initState();
    //print(widget.tracks);
    //fetchtracksforalbum(widget.tracks);
    futureTracksList = fetchtracks(widget.tracks);
  }

  @override
  Widget build(BuildContext context) {
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
          title: const Text('Tracks'),
        ),
        body: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(12),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  widget.album,
                  style: const TextStyle(
                      fontSize: 23.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Tracks>?>(
                  future: futureTracksList,
                  builder: (context, snapshot) {
                    List<Tracks> items = snapshot.data ?? [];
                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          Tracks item = items[index];
                          return ListTile(
                            contentPadding: EdgeInsets.all(5),
                            title: Text(item.name.toString()),
                            leading: Image.network(
                              item.url.toString(),
                              fit: BoxFit.fitHeight,
                            ),
                            subtitle: Text(item.artistname),
                            trailing: Icon(Icons.more_vert),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
