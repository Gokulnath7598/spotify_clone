import 'package:flutter/material.dart';

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
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    iconSize: 20.0,
                    onPressed: () {
                      Navigator.pop(context);
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
                    ListTile(
                      leading: Image.asset('assets/image.jpg'),
                      title: Text('Gocool'),
                      subtitle: Text('View Profile'),
                      trailing: const Icon(Icons.arrow_forward_ios),
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
