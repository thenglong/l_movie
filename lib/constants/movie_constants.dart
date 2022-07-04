enum MovieType {
  popular("popular"),
  nowPlaying("now_playing"),
  topRated("top_rated"),
  upcoming("upcoming");

  const MovieType(this.value);
  final String value;
}
