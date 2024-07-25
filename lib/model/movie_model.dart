class Movie {
  final int id;
  final String title;
  final String backDropPath;
  final String overview;
  final String posterPath;
  final double vote_average;
  final int vote_count;
  final String release_date;

  Movie(
      {required this.id,
      required this.title,
      required this.backDropPath,
      required this.overview,
      required this.posterPath,
      required this.vote_average,
      required this.vote_count,
      required this.release_date});

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
        id: map['id'],
        title: map['title'],
        backDropPath: map['backdrop_path'],
        overview: map['overview'],
        posterPath: map['poster_path'],
        vote_average: map['vote_average'],
        vote_count: map['vote_count'],
        release_date: map['release_date']);
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'backDropPath': backDropPath,
      'overview': overview,
      'posterPath': posterPath
    };
  }
}
