import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../model/artists/artist.dart';
import '../../../theme/theme.dart';
import '../../../utils/async_value.dart';
import '../../../widgets/artist/artist_tile.dart';
import '../view_model/artist_view_model.dart';

class ArtistContent extends StatelessWidget {
  const ArtistContent({super.key});

  @override
  Widget build(BuildContext context) {
    ArtistViewModel mv = context.watch<ArtistViewModel>();

    AsyncValue<List<Artist>> asyncValue = mv.artistsValue;

    Widget content;
    switch (asyncValue.state) {
      case AsyncValueState.loading:
        content = Center(child: CircularProgressIndicator());
        break;
      case AsyncValueState.error:
        content = Center(
          child: Text(
            'error = ${asyncValue.error!}',
            style: TextStyle(color: Colors.red),
          ),
        );
        break;
      case AsyncValueState.success:
        List<Artist> artists = asyncValue.data!;
        content = RefreshIndicator(
          onRefresh: () async {
            await mv.refreshArtists();
          },
          child: ListView.builder(
            itemCount: artists.length,
            itemBuilder: (context, index) => ArtistTile(artist: artists[index]),
          ),
        );
        break;
    }
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Text("Artists", style: AppTextStyles.heading),
          // refresh icon
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              await mv.refreshArtists();
            },
          ),
          SizedBox(height: 50),

          Expanded(child: content),
        ],
      ),
    );
  }
}
