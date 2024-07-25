import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/movie_cubit.dart';
import '../widgets/search_box_widget.dart';
import '../widgets/search_list.dart';
import 'home_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieCubit(),
      child: BlocConsumer<MovieCubit, MovieState>(
        listener: (context, state) {},
        builder: (context, state) {
          MovieCubit cubit = MovieCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('Search'),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => HomeScreen()));
                },
              ),
            ),
            body: Column(
              children: [
                Searchbox().buildSearchbox(context),
                Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, right: 8.0, top: 13.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    )),
                Expanded(
                    child: StreamBuilder(
                  stream: cubit.stream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      cubit.getPopularMovies();
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasData) {
                      return SearchListWidget().buildList(cubit.moviesList);
                    } else {
                      return const Text("No data available");
                    }
                  },
                ))
              ],
            ),
          );
        },
      ),
    );
  }
}
