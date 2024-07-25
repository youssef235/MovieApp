import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies/api/api.dart';

import '../cubit/movie_cubit.dart';
import '../model/cast_model.dart';
import '../model/movie_model.dart';
import '../widgets/add_button.dart';
import '../widgets/cast_card.dart';
import '../widgets/movie_casting.dart';
import '../widgets/movie_rating.dart';
import '../widgets/movie_summary.dart';
import '../widgets/section_listview.dart';
import '../widgets/section_title.dart';
import 'home_screen.dart';

class MovieDetails extends StatelessWidget {
  final Movie movie;
  //final Cast cast;

  const MovieDetails({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daetalies'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => HomeScreen()));
          },
        ),
      ),
      body: Stack(
        children: [
          buildMovieBannerWidget(context),
          buildBackNavigationWidget(context),
          buildMovieInfoWidget(context),
          buildMovieDetailsWidget(context),
        ],
      ),
    );
  }

  Widget buildMovieBannerWidget(BuildContext context) {
    return Positioned(
      top: 0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius:
              const BorderRadius.only(bottomLeft: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.35),
              spreadRadius: 1,
              blurRadius: 40,
              offset: const Offset(0, 12), // changes position of shadow
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius:
              const BorderRadius.only(bottomLeft: Radius.circular(24)),
          child: Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(24)),
            ),
            child: Image.network(
              'https://image.tmdb.org/t/p/original/${movie.backDropPath}',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBackNavigationWidget(BuildContext context) {
    return Positioned(
      top: 12,
      left: 12,
      child: SafeArea(
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
          onPressed: () => Navigator.pop((context)),
        ),
      ),
    );
  }

  Widget buildMovieInfoWidget(BuildContext context) {
    return Positioned(
      right: 0,
      top: 260,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 40,
              offset: const Offset(0, 12),
            ),
          ],
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(48), topLeft: Radius.circular(48)),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(48), topLeft: Radius.circular(48)),
          child: Container(
            color: const Color(0xffFFFFFF),
            height: 80,
            width: MediaQuery.of(context).size.width - 24,
            padding: const EdgeInsets.all(6),
            child: MovieRating(movie: movie),
          ),
        ),
      ),
    );
  }

  Widget buildMovieDetailsWidget(BuildContext context) {
    return Positioned(
      top: 380,
      child: SizedBox(
        height: MediaQuery.of(context).size.height - 300,
        width: MediaQuery.of(context).size.width,
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            letterSpacing: 1.2,
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            '2019',
                            style: TextStyle(
                                color: Color(0xff9A9BB2),
                                fontSize: 10,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            'PG-13',
                            style: TextStyle(
                                color: Color(0xff9A9BB2),
                                fontSize: 10,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            '2h 32 min',
                            style: TextStyle(
                                color: Color(0xff9A9BB2),
                                fontSize: 10,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      )
                    ],
                  ),
                  const AddButton(),
                ],
              ),
              MovieSummary(summary: movie.overview),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: BlocProvider(
                    create: (context) => MovieCubit(),
                    child: BlocConsumer<MovieCubit, MovieState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          MovieCubit cubit = MovieCubit.get(context);

                          return StreamBuilder(
                            stream: cubit.stream,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                cubit.getCastMovies(movie.id.toString());
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasData) {
                                print(cubit.castList);

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SectionTitle(title: "Cast & Crew"),
                                    SectionListView(
                                      height: 175.0,
                                      itemCount: cubit.castList.length,
                                      itemBuilder: (context, index) => CastCard(
                                        cast: cubit.castList[index],
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return const Text("No data available");
                              }
                            },
                          );
                        })),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
