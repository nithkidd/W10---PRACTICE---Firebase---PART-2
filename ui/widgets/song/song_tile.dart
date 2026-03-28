import 'package:flutter/material.dart';

import '../../../model/songs/song.dart';
import '../../screens/library/view_model/library_view_model.dart';

class SongTile extends StatelessWidget {
  const SongTile({
    super.key,
    required this.song,
    required this.isPlaying,
    required this.onTap,
    required this.viewModel,
  });

  final LibraryViewModel viewModel;
  final Song song;
  final bool isPlaying;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          onTap: onTap,
          title: Text(song.title),
          subtitle: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('${song.duration.inMinutes} min'),
              SizedBox(width: 16),
              Text('${song.likes} likes  '),
            ],
          ),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(song.imageURL.toString()),
          ),
          trailing: IconButton(
            onPressed: () async {
              try {
                await viewModel.likeSong(song.id);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Failed to like song')),
                );
              }
            },
            icon: Icon(Icons.favorite),
          ),
        ),
      ),
    );
  }
}
