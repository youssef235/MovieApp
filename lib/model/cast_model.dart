class Cast {
  final String name;
  final String profile_path;

  Cast({
    required this.name,
    required this.profile_path,
  });

  factory Cast.fromMap(Map<String, dynamic> map) {
    return Cast(
      name: map['name'],
      profile_path: map['profile_path'] ??
          'https://image.tmdb.org/t/p/original/r0A7hZsM1zuavTr0jN7bwmBcliR.jpg',
    );
  }
}
