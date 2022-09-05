class MoviesModel {
  int id;
  String title;
  String imgUrl;
  MoviesModel(
    this.id,
    this.imgUrl,
    this.title,
  );
}

List<String> imgUrl = [
  "assets/images/movie1.jpg",
  "assets/images/movie2.jpg",
  "assets/images/movie3.jpg",
  "assets/images/movie4.jpg",
  "assets/images/movie5.jpg",
  "assets/images/movie6.jpg",
  "assets/images/movie7.jpg",
  "assets/images/movie8.jpg",
  "assets/images/movie9.jpg"
];
List<MoviesModel> movieList = [
  MoviesModel(1, imgUrl[0], "wall-e"),
  MoviesModel(2, imgUrl[1], "Alien"),
  MoviesModel(3, imgUrl[2], "Deadpool"),
  MoviesModel(4, imgUrl[3], "Free guy"),
  MoviesModel(5, imgUrl[4], "Korean movie"),
  MoviesModel(6, imgUrl[5], "Cool"),
  MoviesModel(7, imgUrl[6], "Another Korean Movie"),
  MoviesModel(8, imgUrl[7], "Home alone"),
  MoviesModel(9, imgUrl[8], "Anime"),
];
