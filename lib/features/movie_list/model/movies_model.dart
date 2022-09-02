class MoviesModel {
  int id;
  String title;
  String imgUrl;
  MoviesModel(this.id, this.imgUrl, this.title);
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
  MoviesModel(1, imgUrl[0], "Movies1"),
  MoviesModel(2, imgUrl[1], "Movies2"),
  MoviesModel(3, imgUrl[2], "Movies3"),
  MoviesModel(4, imgUrl[3], "Movies4"),
  MoviesModel(5, imgUrl[4], "Movies5"),
  MoviesModel(6, imgUrl[5], "Movies6"),
  MoviesModel(7, imgUrl[6], "Movies7"),
  MoviesModel(8, imgUrl[7], "Movies8"),
  MoviesModel(9, imgUrl[8], "Movies9"),
];
