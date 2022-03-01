import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:spotify_clone/main.dart';
import 'package:spotify_clone/profile.dart';

import 'model/app_state.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  iconSize: 20.0,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  },
                ),
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 100),
                    child: Text(
                      'Settings',
                      style: TextStyle(
                          fontSize: 23.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Profile()),
                      );
                    },
                    child: StoreConnector<AppState, AppState>(
                        converter: (store) => store.state,
                        builder: (context, state) {
                          return ListTile(
                            leading: const CircleAvatar(
                              backgroundImage: AssetImage('assets/im.jpg'),
                            ),
                            title: Text(
                              state.name.toString(),
                            ),
                            subtitle: Text('View Profile'),
                            trailing: const Icon(Icons.arrow_forward_ios),
                          );
                        }),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
