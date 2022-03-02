class Artist {
  final String name;
  final String url;

  const Artist({
    required this.name,
    required this.url,
  });

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
        name: json['name'] as String, url: json['images'][0]['url'] as String);
  }
}
