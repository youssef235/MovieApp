import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../api/api.dart';
import '../model/movie_model.dart';
import 'home_screen.dart';
import 'movie_detalis.dart';

class MovieDisplay extends StatefulWidget {
  MovieDisplay({super.key, required this.genre});
  String genre;

  @override
  State<MovieDisplay> createState() => _MovieDisplayState();
}

int current = 0;
late Future<List<Movie>> genreMovies;
late Future<List<Movie>> popularmovies;

class _MovieDisplayState extends State<MovieDisplay> {
  @override
  void initState() {
    //  genreMovies = APIservices().getgenre(widget.genre);
    popularmovies = Api().getPopularMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => HomeScreen()));
          },
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder(
            future: popularmovies,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final movies = snapshot.data! as List<Movie>;
              final movie = movies[current];

              return Stack(
                children: [
                  // For background image
                  Image.network(
                    'https://image.tmdb.org/t/p/original/${movie.posterPath}',
                    fit: BoxFit.fitHeight,
                  ),
                  Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.33,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                              Colors.grey.shade50.withOpacity(1),
                              Colors.grey.shade50.withOpacity(1),
                              Colors.grey.shade50.withOpacity(1),
                              Colors.grey.shade100.withOpacity(1),
                              Colors.grey.shade100.withOpacity(0.0),
                              Colors.grey.shade100.withOpacity(0.0),
                              Colors.grey.shade100.withOpacity(0.0),
                              Colors.grey.shade100.withOpacity(0.0),
                            ])),
                      )),

                  Positioned(
                    bottom: 5,
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: MediaQuery.of(context).size.width,
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 550,
                        viewportFraction: 0.7,
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) {
                          setState(
                            () {
                              current = index;
                            },
                          );
                        },
                      ),
                      items: movies.map(
                        (movie) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Padding(
                                padding: const EdgeInsets.all(8),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        MovieDetails(
                                                          movie: movie,
                                                        )));
                                            print(movie.title);
                                          },
                                          child: Container(
                                            height: 350,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.55,
                                            margin:
                                                const EdgeInsets.only(top: 20),
                                            clipBehavior: Clip.hardEdge,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Image.network(
                                                'https://image.tmdb.org/t/p/original/${movie.posterPath}'),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        // For movei title
                                        Text(
                                          movie.title,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        // for movei director
                                        Text(
                                          "releases : ${movie.release_date}",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black45,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        AnimatedOpacity(
                                          duration: const Duration(
                                              milliseconds: 1000),
                                          // text is shown 1000 milliseconds later after scroll
                                          opacity:
                                              current == movies.indexOf(movie)
                                                  ? 1.0
                                                  : 0.0,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 18),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                      size: 20,
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      movie.vote_average
                                                          .toString(),
                                                      style: const TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black45,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.access_time,
                                                      color: Colors.black45,
                                                      size: 20,
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      '2,15',
                                                      style: const TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black45,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.21,
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.play_circle,
                                                        color: Colors.black,
                                                        size: 20,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        "Watch",
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.black45,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
