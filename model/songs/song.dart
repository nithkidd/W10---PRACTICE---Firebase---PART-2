class Song {
  final String id;
  final String title;
  final String artistId;
  final Duration duration;
  final Uri imageURL;
  final int likes;

  Song({
    required this.id,
    required this.title,
    required this.artistId,
    required this.duration,
    required this.imageURL,
    required this.likes,
  });


  //need to recreate object
  Song copyWith({
    String? id,
    String? title,
    String? artistId,
    Duration? duration,
    Uri? imageURL,
    int? likes,
  }) {
    return Song(
      id: id ?? this.id,
      title: title ?? this.title,
      imageURL: imageURL ?? this.imageURL,
      likes: likes ?? this.likes,
      artistId: artistId ?? this.artistId,
      duration: duration ?? this.duration,
    );
  }

  @override
  String toString() {
    return 'Song(title: $title, artist:Id $artistId, duration: $duration, image: $imageURL, likes: $likes)';
  }
}
