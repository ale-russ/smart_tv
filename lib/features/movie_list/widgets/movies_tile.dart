import 'package:flutter/material.dart';
import 'package:smart_tv/features/movie_list/utilits/text.dart';
import 'package:smart_tv/features/movie_list/widgets/description.dart';

final String url = "https://image.tmdb.org/t/p/w500";

class MoviesTile extends StatelessWidget {
  MoviesTile({
    Key? key,
    required this.title,
    this.movie,
  }) : super(key: key);

  final String title;
  final List? movie;

  Color textColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ModifiedText(
          text: title,
          size: 18,
          color: textColor,
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            itemCount: movie!.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => Description(
                            bannerurl: "$url${movie![index]['backdrop_path']}",
                            description: movie![index]['overview'],
                            lauchOn: movie![index]['release_date'],
                            name: movie![index]['title'],
                            posterurl: "$url${movie![index]['backdrop_path']}",
                            vote: movie![index]['vote_average'].toString(),
                          )),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  width: 250,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 250,
                        height: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.3)),
                          image: DecorationImage(
                            image: NetworkImage(
                              "$url${movie![index]['poster_path']}",
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SizedBox(
                        child: ModifiedText(
                          text: movie![index]['title'] ?? 'Loading',
                          color: Colors.white,
                          size: 13,
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}

class ComingSoon extends StatelessWidget {
  ComingSoon({Key? key, this.movie}) : super(key: key);

  final List? movie;

  int? count;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < 650) {
      count = 2;
    } else if (MediaQuery.of(context).size.width > 1100) {
      count = 4;
    } else {
      count = 3;
    }
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: count!,
            childAspectRatio: 4 / 3,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemCount: movie!.length,
          itemBuilder: (context, index) {
            return SizedBox(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => Description(
                            bannerurl: "$url${movie![index]['backdrop_path']}",
                            description: movie![index]['overview'],
                            lauchOn: movie![index]['release_date'],
                            name: movie![index]['title'],
                            posterurl: "$url${movie![index]['backdrop_path']}",
                            vote: movie![index]['vote_average'].toString(),
                          )),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * 0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.3)),
                          image: DecorationImage(
                            image: NetworkImage(
                              "$url${movie![index]['poster_path']}",
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SizedBox(
                        child: ModifiedText(
                          text: movie![index]['title'] ?? 'Loading',
                          color: Colors.white,
                          size: 13,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
