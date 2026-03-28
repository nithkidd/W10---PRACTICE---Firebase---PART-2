class Artist {
  final String id;
  final String name;
  final String genre;
  final Uri imageUrl;

  Artist({required this.name, required this.genre, required this.imageUrl, required this.id});

  @override
  String toString() {
    return 'Artist(id: $id, name: $name, genre:genre $genre, image: $imageUrl)';
  }
}
