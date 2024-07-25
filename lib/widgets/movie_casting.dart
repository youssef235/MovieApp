import 'package:flutter/material.dart';
import 'package:my_movies/widgets/section_tile.dart';

import '../model/cast_model.dart';
import 'cast_card.dart';

class MovieCasting extends StatelessWidget {
  final List<Cast> casting;
  const MovieCasting({Key? key, required this.casting}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      height: 200,
      width: double.infinity,
      child: Column(
        children: [
          const SectionTitle(title: 'Cast & Crew'),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              for (var cast in casting)
                CastCard(
                  cast: cast,
                  //  character: cast.character!,
                )
            ],
          ),
        ],
      ),
    );
  }
}
