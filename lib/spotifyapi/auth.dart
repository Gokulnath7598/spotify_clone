import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

auth() async {
  final prefs = await SharedPreferences.getInstance();
  var token;
  String id = 'd0288961bbf9463a8f2c2ddf5d38880e';
  String secret = 'c2350a8ffb994f82b30d71634084dd02';
  Codec<String, String> stringToBase64 = utf8.fuse(base64);
  String encoded = stringToBase64.encode(id + ':' + secret);
  final Map<String, String> body = {"grant_type": "client_credentials"};
  const String url = "https://accounts.spotify.com/api/token";
  Map<String, String> headers = {
    "Authorization": "Basic " + encoded,
    "Content-Type": "application/x-www-form-urlencoded",
  };
  final http.Response response = await http.post(
    Uri.parse(url),
    headers: headers,
    body: body,
    encoding: Encoding.getByName("utf-8"),
  );
  var parsedJson = json.decode(response.body);
  token = parsedJson['access_token'];
  //print(token);
  await prefs.setString('token', token);
}
