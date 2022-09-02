import 'package:flutter/material.dart';
//import 'package:mezmur/customcontainer.dart';
//import 'package:mezmur/screen/albumScreen.dart';

import '../../config/configeration.dart';
//import '../config/configeration.dart';
//import '../models/balat_model.dart';
import '../customcontainer.dart';
//import '../features/customcontainer.dart';
import '../models/movies_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(251, 236, 236, 1),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(40)),
                      child: SizedBox(
                        width: SizeConfig.defaultSize! * 4,
                        // width: 80,
                        //width: MediaQuery.of(context).size.width * 0.18,
                        //height: 80,
                        // height: MediaQuery.of(context).size.height * 0.18,
                        /*child: Image.asset(
                          'icon.jpg',
                        ),*/
                      ),
                    ),
                    const Text(
                      'kabbee+',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(164, 11, 11, 11),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'New movies',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(164, 12, 12, 12),
                ),
              ),
              HorizontallyScrollableContainer("New Movies"),
              /*const SizedBox(height: 8),
              const Text(
                'ናይ በዓላት መዛሙር',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(165, 117, 24, 1),
                ),
              ),
              HorizontallyScrollableContainer("ናይ በዓላት"),
              const SizedBox(height: 8),
              const Text(
                'ናይ ዝተፈላለዩ መዝሙር',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(165, 117, 24, 1),
                ),
              ),
              HorizontallyScrollableContainer("ናይ ዝተፈላለዩ"),*/
            ],
          ),
        ),
      ),
    );
  }
}
