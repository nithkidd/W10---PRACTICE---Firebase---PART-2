import '../../../model/artists/artist.dart';

abstract class ArtistRepository {
  Future<List<Artist>> fetchArtists();
}
