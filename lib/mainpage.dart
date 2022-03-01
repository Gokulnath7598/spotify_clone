// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:spotify/spotify.dart' as Sp;
//
// class Mainpage extends StatefulWidget {
//   const Mainpage({Key? key}) : super(key: key);
//
//   @override
//   _MainpageState createState() => _MainpageState();
// }
//
//
// class _MainpageState extends State<Mainpage> {
//   List<String> imageurl = [];
//   List txt = [];
//   _MainpageState(){
//     getTextFromFile().then((val) => setState(() {
//       imageurl = ['assets/image.jpg','assets/image.jpg','assets/image.jpg','assets/image.jpg'];
//       txt = val;
//     }));
//   }
//   Future<List> getTextFromFile() async {
//     final credentials = Sp.SpotifyApiCredentials('d0288961bbf9463a8f2c2ddf5d38880e', 'c2350a8ffb994f82b30d71634084dd02');
//     final spotify = Sp.SpotifyApi(credentials);
//     final artist = await spotify.artists.get('0OdUWJ0sBjDrqHygGUXeCF');
//     List<String?> s = [artist.name,artist.name,artist.name,artist.name];
//     //print(s);
//     return await s;
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(colors: [
//           // Color.fromARGB(1,128,0,128),
//           Colors.purple,
//           Colors.black,
//         ], begin: Alignment.topLeft, end: FractionalOffset(0.3, 0.3)),
//       ),
//       child: ListView(
//         children: [
//           SingleChildScrollView(
//             scrollDirection: Axis.vertical,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 const SizedBox(
//                   height: 14,
//                 ),
//                 SizedBox(
//                   height: 250.0,
//                   child: Column(
//                     children: <Widget>[
//                       Container(
//                         padding: const EdgeInsets.all(12),
//                         child: const Align(
//                           alignment: Alignment.topLeft,
//                           child: Text(
//                             'Recently played',
//                             style: TextStyle(
//                                 fontSize: 23.0, fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 12,
//                       ),
//                       SizedBox(
//                         height: 165.0,
//                         child: ListView.builder(
//                           itemCount: imageurl.length,
//                           scrollDirection: Axis.horizontal,
//                           itemBuilder: (BuildContext context, int index) {
//                             return Column(
//                               children: [
//                                 SizedBox(
//                                   height: 130.0,
//                                   width: 140.0,
//                                   child: Image.asset(
//                                     imageurl[index],
//                                     fit: BoxFit.fitHeight,
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   height: 6,
//                                 ),
//                                 Text(
//                                   txt[index],
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 10.0,
//                                   ),
//                                 )
//                               ],
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
//
