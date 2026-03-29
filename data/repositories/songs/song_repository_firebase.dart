import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../model/songs/song.dart';
import '../../dtos/song_dto.dart';
import 'song_repository.dart';
import '../../firebaseUri.dart';

class SongRepositoryFirebase extends SongRepository {
  List<Song>? _cachedSongs;

  @override
  Future<List<Song>> fetchSongs({bool forceFetch = false}) async {
    
    //cache check, return cache if exists
    if (!forceFetch && _cachedSongs != null) {
      return _cachedSongs!;
    }

    final http.Response response = await http.get(songsUri);

    if (response.statusCode == 200) {
      // 1 - Send the retrieved list of songs
      Map<String, dynamic> songJson = json.decode(response.body);
      List<Song> result = [];

      for (var iterable in songJson.entries) {
        String songId = iterable.key;
        Map<String, dynamic> values = iterable.value;
        result.add(SongDto.fromJson(songId, values));
      }

      _cachedSongs = result; // save to cache
      
      return result; // return song
    } else {
      // 2- Throw expcetion if any issue
      throw Exception('Failed to load posts');
    }
  }

  @override
  Future<Song?> fetchSongById(String id) async {}

  @override
  Future<void> likeSong(String songId) async {
    final Uri songUri = baseUri.replace(path: '/songs/$songId.json');

    try {
      // GET current song
      final http.Response getResponse = await http.get(songUri);

      if (getResponse.statusCode != 200) {
        throw Exception('Failed to fetch song');
      }

      final Map<String, dynamic> songData = jsonDecode(getResponse.body);

      final int currentLikes = songData['likes'] ?? 0;
      final int newLikes = currentLikes + 1;

      // PATCH updated likes
      final http.Response patchResponse = await http.patch(
        songUri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'likes': newLikes}),
      );

      if (patchResponse.statusCode != 200) {
        throw Exception('Failed to update likes');
      }

      // improved the likes function. 
      //loop through every song in the list and check cache.
      if (_cachedSongs != null) {
        _cachedSongs = _cachedSongs!.map((song) {
          if (song.id == songId) {
            return song.copyWith(likes: newLikes);  // same song but the likes updated
          }
          return song;
        }).toList();
      }
    } catch (e) {
      throw Exception('Error liking song: $e');
    }
  }
}
