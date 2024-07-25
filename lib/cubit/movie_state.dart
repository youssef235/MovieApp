part of 'movie_cubit.dart';

abstract class MovieState {
  const MovieState();
}

class MovieCubitInitial extends MovieState {
  const MovieCubitInitial();
}

class MovieCubitSearch extends MovieState {
  const MovieCubitSearch();
}

class MovieCubitgetList extends MovieState {
  const MovieCubitgetList();
}

class MovieCubitgetCastList extends MovieState {
  const MovieCubitgetCastList();
}
