import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../model/artists/artist.dart';
import '../../dtos/artist_dto.dart';
import 'artist_repository.dart';


class ArtistRepositoryFirebase extends ArtistRepository {
    final Uri artistsUri = Uri.https(
    'my-firebase-link.asia-southeast1.firebasedatabase.app',
    '/artists.json',
  );

  @override
  Future<List<Artist>> fetchArtists() async {
    final http.Response response = await http.get(artistsUri);

    if (response.statusCode == 200) {
      // 1 - Send the retrieved list of songs
      Map<String, dynamic> artistJson = json.decode(response.body);
      List<Artist> result = [];

      for (var iterable in artistJson.entries) {
        String artistId = iterable.key;
        Map<String, dynamic> values = iterable.value;
        result.add(ArtistDto.fromJson(artistId, values));
      }
      return result;
    } else {
      // 2- Throw expcetion if any issue
      throw Exception('Failed to load artists');
    }
  }
}