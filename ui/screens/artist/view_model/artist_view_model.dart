import 'package:flutter/material.dart';
import '../../../../data/repositories/artists/artist_repository.dart';
import '../../../../model/artists/artist.dart';
import '../../../states/player_state.dart';
import '../../../utils/async_value.dart';

class ArtistViewModel extends ChangeNotifier {
  final ArtistRepository artistRepository;
  final PlayerState playerState;

  AsyncValue<List<Artist>> artistsValue = AsyncValue.loading();

  ArtistViewModel({required this.artistRepository, required this.playerState}) {
    playerState.addListener(notifyListeners);

    //init
    _init();
  }

    @override
  void dispose() {
    playerState.removeListener(notifyListeners);
    super.dispose();
  }

    void _init() async {
    fetchArtists();
  }

  void fetchArtists() async {
    // 1- Loading state
    artistsValue = AsyncValue.loading();
    notifyListeners();

    try {
      // 2- Fetch is successfull
      List<Artist> artists = await artistRepository.fetchArtists();
      artistsValue = AsyncValue.success(artists);
    } catch (e) {
      // 3- Fetch is unsucessfull
      artistsValue = AsyncValue.error(e);
    }
    notifyListeners();
  }
}
