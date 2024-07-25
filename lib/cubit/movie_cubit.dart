import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../api/api.dart';
import '../api/constants.dart';
import '../model/cast_model.dart';
import '../model/movie_model.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  //Api apIservices = Api();
  List<Movie> _moviesList = [];
  List<Movie> get moviesList => _moviesList;
  List<Cast> _castList = [];
  List<Cast> get castList => _castList;

  MovieCubit() : super(MovieCubitInitial());

  static MovieCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  Future<List<Movie>> getPopularMovies() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=$apiKey'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];

      _moviesList = data.map((movie) => Movie.fromMap(movie)).toList();
      emit(const MovieCubitSearch());
      return moviesList;
    } else {
      throw Exception('Failed to load popular movies');
    }
  }

  Future<List<Cast>> getCastMovies(String movieId) async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/${movieId}/credits?api_key=${apiKey}'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['cast'];

      _castList = data.map((cast) => Cast.fromMap(cast)).toList();
      emit(const MovieCubitgetCastList());
      return castList;
    } else {
      throw Exception('Failed to load popular movies');
    }
  }

  Future<List<Movie>> runFilter(String enteredKeyword) async {
    getPopularMovies();
    if (enteredKeyword.isEmpty) {
      _moviesList = await getPopularMovies();
    } else {
      _moviesList = moviesList
          .where((item) =>
              item.title.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      emit(const MovieCubitSearch());
      return moviesList;

      // print(articlesList);
    }
    emit(const MovieCubitSearch());
    return moviesList;
  }
}
