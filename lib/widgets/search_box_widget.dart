import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/movie_cubit.dart';

class Searchbox {
  Widget buildSearchbox(
    BuildContext context,
  ) {
    return BlocProvider(
      create: (context) => MovieCubit(),
      child: BlocConsumer<MovieCubit, MovieState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          MovieCubit cubit = MovieCubit.get(context);
          return Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 13.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 226, 226, 226),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  onSubmitted: (value) => cubit.runFilter(value),
                  decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search)),
                ),
              ));
        },
      ),
    );
  }
}
