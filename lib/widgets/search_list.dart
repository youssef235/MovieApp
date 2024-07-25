import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/movie_model.dart';

class SearchListWidget {
  ValueNotifier<bool> myBool = ValueNotifier<bool>(false);
  List<Movie> favoriteArticles = [];

/*   ScrollController scrollController = ScrollController(
    initialScrollOffset: 1,
    keepScrollOffset: true,
  ); */
  Widget buildList(List<Movie> articles) {
    return ScrollablePositionedList.builder(
      itemCount: articles.length,
      //   initialScrollIndex: 1,
      itemBuilder: (context, index) {
        final Articles = articles[index];
        return InkWell(
          /*     onTap: () {
            launchUrl(Uri.parse(Articles.backDropPath!));
          }, */
          child: Container(
            color: Colors.black,
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            height: 100,
            width: double.maxFinite,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10), // Image border
                  child: SizedBox.fromSize(
                    size: Size.fromRadius(25), // Image radius
                    child: Image.network(
                      "https://image.tmdb.org/t/p/original/${Articles.backDropPath}",
                      fit: BoxFit.cover,
                      height: 200,
                      width: 200,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(flex: 3, child: Text(Articles.title)),
              ],
            ),
          ),
        );
      },
    );
  }
}
