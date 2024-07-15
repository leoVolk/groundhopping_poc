import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:learning_flutter/widgets/profile/tabs/profile_fullscreen_image.dart';

class ProfilePhotos extends StatelessWidget {
  const ProfilePhotos({super.key});

  @override
  Widget build(BuildContext context) {
    final images = [
      'https://tremark-fotografie.de/wp-content/uploads/2023/12/vfltsg_tremark-3.jpg',
      'https://tremark-fotografie.de/wp-content/uploads/2023/12/vfltsg_tremark-1-2.jpg',
      'https://tremark-fotografie.de/wp-content/uploads/2023/12/vfltsg_tremark-1-3.jpg',
      'https://tremark-fotografie.de/wp-content/uploads/2023/12/vfltsg_tremark-3.jpg',
      'https://tremark-fotografie.de/wp-content/uploads/2023/12/vfltsg_tremark-1-4.jpg',
      'https://tremark-fotografie.de/wp-content/uploads/2023/12/vfltsg_tremark-1-2.jpg',
      'https://tremark-fotografie.de/wp-content/uploads/2023/12/vfltsg_tremark-1-3.jpg',
      'https://tremark-fotografie.de/wp-content/uploads/2023/12/vfltsg_tremark-3.jpg',
      'https://tremark-fotografie.de/wp-content/uploads/2023/12/vfltsg_tremark-1-4.jpg',
      'https://tremark-fotografie.de/wp-content/uploads/2023/12/vfltsg_tremark-1-2.jpg',
      'https://tremark-fotografie.de/wp-content/uploads/2023/12/vfltsg_tremark-1-4.jpg',
      'https://tremark-fotografie.de/wp-content/uploads/2023/12/vfltsg_tremark-1-3.jpg',
      'https://tremark-fotografie.de/wp-content/uploads/2023/12/vfltsg_tremark-3.jpg',
      'https://tremark-fotografie.de/wp-content/uploads/2023/12/vfltsg_tremark-1-4.jpg',
      'https://tremark-fotografie.de/wp-content/uploads/2023/12/vfltsg_tremark-1-2.jpg',
      'https://tremark-fotografie.de/wp-content/uploads/2023/12/vfltsg_tremark-1-3.jpg',
    ];

    return GridView.custom(
      padding: EdgeInsets.all(4),
      gridDelegate: SliverQuiltedGridDelegate(
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        repeatPattern: QuiltedGridRepeatPattern.inverted,
        pattern: [
          QuiltedGridTile(2, 2),
          QuiltedGridTile(1, 1),
          QuiltedGridTile(1, 1),
          QuiltedGridTile(1, 2),
        ],
      ),
      childrenDelegate: SliverChildBuilderDelegate(
          (context, index) => GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ProfileFullscreenImage(
                              imgLink: images[index],
                              tag: 'image_$index',
                            ))),
                child: Hero(
                  tag: 'image_$index',
                  child: Image.network(
                    images[index],
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
          childCount: images.length),
    );
  }
}
