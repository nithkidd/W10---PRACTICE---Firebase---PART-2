import '../../model/songs/song.dart';

class SongDto {
  static const String titleKey = 'title';
  static const String artistIdKey = 'artistId';
  static const String durationKey = 'duration'; // in ms
  static const String imageURLKey = 'imageUrl';
  static const String likesKey = 'likes';

  static Song fromJson(String id, Map<String, dynamic> json) {
    assert(json[titleKey] is String);
    assert(json[artistIdKey] is String);
    assert(json[durationKey] is int);
    assert(json[imageURLKey] is String);
    assert(json[likesKey] == null || json[likesKey] is int);
    

    return Song(
      id: id,
      title: json[titleKey],
      artistId: json[artistIdKey],
      duration: Duration(milliseconds: json[durationKey]),
      imageURL: Uri.parse(json[imageURLKey]), 
      likes: json[likesKey] ?? 0,
    );
  }

  /// Convert Song to JSON
  Map<String, dynamic> toJson(Song song) {
    return {
      titleKey: song.title,
      artistIdKey: song.artistId,
      durationKey: song.duration.inMilliseconds,
      imageURLKey: song.imageURL,
      likesKey: song.likes
    };
  }
}
