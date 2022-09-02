// ignore_for_file: camel_case_types, use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
//import 'package:mezmur/screen/albumScreen.dart';

import '../config/configeration.dart';
import 'models/movies_model.dart';
import 'screen/albumScreen.dart';
//import '../models/movies_model.dart';
//import '../screen/albumScreen.dart';

class HorizontallyScrollableContainer extends StatefulWidget {
  String nameofmahber;

  HorizontallyScrollableContainer(this.nameofmahber);

  @override
  State<HorizontallyScrollableContainer> createState() {
    return _HorizontallyScrollableContainerState();
  }
}

class _HorizontallyScrollableContainerState
    extends State<HorizontallyScrollableContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.defaultSize,
      height: SizeConfig.defaultSize! * 12,
      //height: 230,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: Movies.length,
          itemBuilder: (BuildContext contex, int index) {
            //return Text(qumsnatat[index].qumsname.toString());
            ContainerCard cards = Movies[index];
            return GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AlbumScreen(cards: cards),
                ),
              ),
              child: Container(
                margin: const EdgeInsets.all(6),
                width: 145,
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0.0, 2.0),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: Hero(
                        tag: cards.imageUrl.toString(),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image(
                            height: 270,
                            width: 174,
                            image: AssetImage(cards.imageUrl.toString()),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 8.0,
                      bottom: 10.0,
                      child: Text(
                        cards.cardTitle.toString(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
