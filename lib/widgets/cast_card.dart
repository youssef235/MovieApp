import 'package:flutter/material.dart';

import '../model/cast_model.dart';
import 'image_with_shimmer.dart';

class CastCard extends StatelessWidget {
  final Cast cast;
  const CastCard({
    required this.cast,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: 100.0,
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: ImageWithShimmer(
                imageUrl:
                    "https://image.tmdb.org/t/p/original/${cast.profile_path}",
                width: double.infinity,
                height: 130.0,
              ),
            ),
          ),
          Expanded(
            child: Text(
              cast.name,
              style: textTheme.bodyLarge,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
