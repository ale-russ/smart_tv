class ContainerCard {
  String? imageUrl;
  String? cardTitle;
  String? category;
  List<Album> albums;

  ContainerCard({this.imageUrl, this.cardTitle, required this.albums});
}

int index = 0;
List<ContainerCard> Movies = [
  ContainerCard(
      imageUrl: "assets/images/movie4.jpg",
      cardTitle: 'wall-e',
      albums: albums),
  ContainerCard(
    imageUrl: "assets/images/movie5.jpg",
    cardTitle: 'Alien',
    albums: albums,
  ),
  ContainerCard(
      imageUrl: "assets/images/movie6.jpg",
      cardTitle: 'Deadpool',
      albums: albums),
  ContainerCard(
      imageUrl: 'assets/images/movie7.jpg',
      cardTitle: 'Free guy',
      albums: albums),
  ContainerCard(
      imageUrl: "assets/images/movie8.jpg",
      cardTitle: 'Comedy',
      albums: albums),
];

class Album {
  String? imagUrl;
  String? moviename;

  Album({
    this.imagUrl,
    this.moviename,
  });
}

List<Album> albums = [
  Album(
    imagUrl: "assets/images/movie4.jpg",
    moviename: "action movies",
  ),
  Album(
    imagUrl: "assets/images/movie6.jpg",
    moviename: "honor movies",
  ),
];
