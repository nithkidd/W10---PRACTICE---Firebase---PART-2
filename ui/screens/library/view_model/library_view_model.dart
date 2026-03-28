import 'package:advanced_flutter/W9-PRACTICE-FIREBASE-REST-API/data/repositories/artists/artist_repository.dart';
import 'package:advanced_flutter/W9-PRACTICE-FIREBASE-REST-API/model/artists/artist.dart';
import 'package:flutter/material.dart';
import '../../../../data/repositories/songs/song_repository.dart';
import '../../../states/player_state.dart';
import '../../../../model/songs/song.dart';
import '../../../utils/async_value.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final ArtistRepository artistRepository;
  final PlayerState playerState;

  AsyncValue<List<Song>> songsValue = AsyncValue.loading();
  final Map<String, Artist> _artistById = {};
  LibraryViewModel({
    required this.songRepository,
    required this.playerState,
    required this.artistRepository,
  }) {
    playerState.addListener(notifyListeners);

    // init
    _init();
  }

  @override
  void dispose() {
    playerState.removeListener(notifyListeners);
    super.dispose();
  }

  void _init() async {
    fetchSong();
  }

  Artist? getArtistFromSong(Song song) {
    return _artistById[song.artistId];
  }

  void fetchSong() async {
    // 1- Loading state
    songsValue = AsyncValue.loading();
    notifyListeners();

    try {
      // 2- Fetch is successfull
      List<Song> songs = await songRepository.fetchSongs();

      List<Artist> artists = await artistRepository.fetchArtists();

      for (final artist in artists) {
        _artistById[artist.id] = artist;
      }

      songsValue = AsyncValue.success(songs);
    } catch (e) {
      // 3- Fetch is unsucessfull
      songsValue = AsyncValue.error(e);
    }
    notifyListeners();
  }

    String getArtistName(Song song) {
    return _artistById[song.artistId]!.name;
  }

  String getArtistGenre(Song song) {
    return _artistById[song.artistId]!.genre;
  }

  bool isSongPlaying(Song song) => playerState.currentSong == song;

  void start(Song song) => playerState.start(song);
  void stop(Song song) => playerState.stop();
}
