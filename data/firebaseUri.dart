final Uri baseUri = Uri.https(
  'my-firebase-link.firebasedatabase.app',
);

final Uri songsUri = baseUri.replace(path: '/songs.json');
final Uri artistsUri = baseUri.replace(path: '/artists.json');