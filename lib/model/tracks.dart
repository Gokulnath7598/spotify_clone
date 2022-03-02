class Track {
  final String name;
  final String url;
  final String artistname;

  const Track({
    required this.name,
    required this.url,
    required this.artistname,
  });

  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
      name: json['name'] as String,
      url: json['album']['images'][0]['url'] as String,
      artistname: json['album']['artists'][0]['name'] as String,
    );
  }
}