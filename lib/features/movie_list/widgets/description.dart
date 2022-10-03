import 'dart:developer';

import 'package:desktop_webview_window/desktop_webview_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import 'package:smart_tv/features/common/controller/intent_controllers.dart';
import 'package:smart_tv/features/movie_list/controller/movie_controller.dart';
import 'package:smart_tv/features/movie_list/utilits/text.dart';
import 'package:smart_tv/features/movie_list/widgets/video_palyer_page.dart';
import 'package:video_player/video_player.dart';

import '../../../config/intentFiles/button_intents.dart';

class Description extends StatefulWidget {
  final String name, description, bannerurl, posterurl, vote, lauchOn;

  const Description(
      {Key? key,
      required this.bannerurl,
      required this.description,
      required this.lauchOn,
      required this.name,
      required this.posterurl,
      required this.vote})
      : super(key: key);

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  // late VideoPlayerController _videoPlayerController;

  final IntentController _intentController = Get.find();

  final MoviesController moviesController = Get.find();

  MoviesController controller = Get.find();

  @override
  void initState() {
    super.initState();

    // _videoPlayerController = VideoPlayerController.network(
    //     "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4")
    //   ..initialize().then((_) => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    // _videoPlayerController.dispose();
    _intentController.desc = false;
  }

  _changeNodeFocus(BuildContext build, String direction) {
    if (direction == "Down") {
      _intentController.DownNavActions(context);
      setState(() {});
    } else if (direction == "Up") {
      _intentController.UpNavActions(context);
      setState(() {});
    } else if (direction == "Right") {
      _intentController.RightNavActions(context);
      setState(() {});
    } else if (direction == "Left") {
      _intentController.LeftNavActions(context);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
     double screanwidth = MediaQuery.of(context).size.width;
    if (moviesController.serverMessage.isNotEmpty) {
      return Container(
        child: const Text("Content Not Found"),
      );
    }
    return Scaffold(
       body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SafeArea(
                child: Container(
                  width: double.infinity,
                  height: 750,
                  // ignore: prefer_const_constructors
                  decoration: BoxDecoration(
                      // ignore: prefer_const_constructors
                      image: DecorationImage(
                          // ignore: prefer_const_constructors
                          image: NetworkImage(
                              'https://th.bing.com/th/id/OIP.NJzKliVjzYhnf3V4IruCcgHaK-?w=182&h=270&c=7&r=0&o=5&dpr=1.25&pid=1.7'),
                          fit: BoxFit.cover)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                               Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: ElevatedButton.icon(
                          style:ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                          minimumSize: Size(150, 40),
                          padding: EdgeInsets.all(10),
                          side: BorderSide(width: 2,color:Color.fromARGB(31, 55, 54, 54) )

                          ) ,
                          onPressed: (){
                            Navigator.push(
                              context,
                             MaterialPageRoute(builder: (context) => VideoApp()),
  );
                          }, 
                            icon:Icon(Icons.play_arrow,color:Colors.black ,), 
                          label:Text('Play',
                          style: TextStyle(color: Colors.white,fontSize: 15),) ),
                      ),
                  
                      SizedBox(
                        width: 40,
                      ),
                      ElevatedButton.icon(
                        style:ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(31, 167, 166, 166),
                        minimumSize: Size(150, 40),
                        padding: EdgeInsets.all(10),
                       side: BorderSide(width: 0.5,color:Colors.orange )
                         
                        ) ,
                        onPressed: (){}, 
                        icon:Icon(Icons.play_arrow,color:Color.fromARGB(255, 161, 159, 159),),
                        label:Text('Watch',
                        style: TextStyle(color: Colors.white,fontSize: 15),) )
                             ] ),
                    
                  
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text('The Night Tune',style: TextStyle(color: Colors.white,fontSize: 45,))
                               
                              ,
                  )],
                          ),
                  // child: Row(
                  //   children: [
                  //     TextButton(
                  //         onPressed: () {},
                  //         child: Text(
                  //           'watch',
                  //           style: TextStyle(color: Colors.black),
                  //         )),
                  //     SizedBox(
                  //       width: 40,
                  //     ),
                  //     TextButton(
                  //       onPressed: () {},
                  //       child: Text(
                  //         'paly',
                  //         style: TextStyle(color: Colors.white),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ),
              ),
               Container(
                    color: Colors.black,
                  
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     
                      children: [
                        Column(
                          children: [
                            SizedBox(height: 6,),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text('The Night tune',style: TextStyle(color: Colors.white,fontSize: 50),),
                            ),
                         
                            
                            
                                 Padding(
                                   padding: const EdgeInsets.all(15.0),
                                   child: Text('2021'+'  '+'|'+'  '+'Kabee'+'  '+'|'+'  '+'Tigrnina'+'  '+' |'+' 1hr 30 min'
                                    ,style: TextStyle(color: Colors.white),),
                                 ),
                                  SizedBox(height: 5,),
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Row(
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        // ignore: prefer_const_constructors
                                        Icon(Icons.star,color:Colors.yellow,size: 20,),
                                        // ignore: prefer_const_constructors
                                        SizedBox(width: 10,),
                                         Padding(
                                           padding: const EdgeInsets.all(8.0),
                                           child: Icon(Icons.star,color:Colors.yellow,size: 20,),
                                         ),
                                          SizedBox(width: 10,),
                                          Icon(Icons.star,color:Colors.yellow,size: 20,),
                                           SizedBox(width: 10,),
                                           Icon(Icons.star,color:Colors.yellow,size: 20,),
                                            SizedBox(width: 10,),
                                            Icon(Icons.star,color:Colors.yellow,size: 20,),
                                            SizedBox(width: 10,),
                                            Text('(5 Review)',style: TextStyle(color: Colors.white,fontSize: 15),)
                                      ], ), ) ],
                                  ),
 
                      
                        Column(
                          children: [
                            SizedBox(height: 20,),

                             Text('plot sumary',style: TextStyle(color: Colors.white,fontSize: 20),),
                             SizedBox(height: 15,),

                             Padding(
                               padding: const EdgeInsets.all(15.0),
                               child: Text('aboy e countered an accident at night\nwith his mother.as result\nhe become avictome of night phobia',
                               style: TextStyle(color:Colors.white,fontSize: 15),),
                             ),
                             SizedBox(height: 20,),
                          ]
                              
                             
                    
                      
                  ),
                  
                ],
              ),
         
                   ),
               Container(),
                  Container(
                    color: Colors.black,
                  
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     
                      children: [
                        Column(
                        
                          
                          children: [
                            SizedBox(height: 6,),
                            Text('cast & crew',style: TextStyle(color: Colors.white,fontSize: 20),),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.yellow,
                                        radius: 20,
                                        child: CircleAvatar(backgroundColor:Colors.black,)
                                        ),
                                        SizedBox(height: 10,),
                                        Text('Artist',style: TextStyle(color:Colors.white),),
                                          Text('Role',style: TextStyle(color:Colors.white),)
                                        
                                    ],
                                  ),
                                ),
                                 Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.yellow,
                                        radius: 20,
                                        child: CircleAvatar(backgroundColor:Colors.black,)
                                        ),
                                        SizedBox(height: 10,),
                                        Text('Artist',style: TextStyle(color:Colors.white),),
                                          Text('Role',style: TextStyle(color:Colors.white),)
                                        
                                    ],
                                  ),
                                ),
                                 Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.yellow,
                                        radius: 20,
                                        child: CircleAvatar(backgroundColor:Colors.black,)
                                        ),
                                        SizedBox(height: 10,),
                                        Text('Artist',style: TextStyle(color:Colors.white),),
                                        SizedBox(height: 6,),
                                           Text('Role',style: TextStyle(color:Colors.white),),
                                       
                                        
                                    ],
                                  ),
                                ),
                                 Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.yellow,
                                        radius: 20,
                                        child: CircleAvatar(backgroundColor:Colors.black,)
                                        ),
                                        SizedBox(height: 10,),
                                        Text('Artist',style: TextStyle(color:Colors.white),),
                                           Text('Role',style: TextStyle(color:Colors.white),)
                                        
                                    ],
                                  ),
                                ),
                                 Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.yellow,
                                        radius: 20,
                                        child: CircleAvatar(backgroundColor:Colors.black,)
                                        ),
                                        SizedBox(height: 10,),
                                        Text('Artist',style: TextStyle(color:Colors.white),),
                                          Text('Role',style: TextStyle(color:Colors.white),)
                                        
                                    ],
                                  ),
                                ),

                          
                              ],
                            ),
                            Row(

                            )
                           
                          ],
                        ),
                      
                        Column(
                          children: [
                            SizedBox(height: 6,),

                             Text('Traillers',style: TextStyle(color: Colors.white,fontSize: 20),),
                             SizedBox(height: 20,),
                            Row(
                              
                              children: [
                                Row(
                                  
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 10),
                                      child: Container(
                                        width: 150,
                                        height: 150,
                                         decoration: BoxDecoration(
                                      image: DecorationImage(
                               // ignore: prefer_const_constructors
                               image: NetworkImage(
                              'https://www.bing.com/th?id=OIP.BBXmlcEx1SvuGzY7gRXhEAHaJ3&w=150&h=200&c=8&rs=1&qlt=90&o=6&dpr=1.25&pid=3.1&rm=2'),
                                         )),
                                       
                                      ),
                                    ),
                                 
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container( 
                                        

                                         width: 150,
                                        height: 150,
                                         decoration: BoxDecoration(
                                      image: DecorationImage(
                               image: NetworkImage(
                              'https://www.bing.com/th?id=OIP.BBXmlcEx1SvuGzY7gRXhEAHaJ3&w=150&h=200&c=8&rs=1&qlt=90&o=6&dpr=1.25&pid=3.1&rm=2'),
                                         )),
                                       
                                       ),
                                    )
                                  ],
                                )
                          
                           ] )
                          ],
                          
                        )
                      ],
                    ),
                    
                      
                  ),
                 
                 
                  ]
              
           ) ,
          ),
          
        ),
      

      

      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   leading: GetPlatform.isDesktop || GetPlatform.isWeb
      //       ? IconButton(
      //           icon: const Icon(
      //             Icons.arrow_back,
      //           ),
      //           onPressed: () {
      //             Navigator.pop(context);
      //           },
      //         )
      //       : const SizedBox.shrink(),
      // ),
      // backgroundColor: Colors.black,
      // body: Shortcuts(
      //   shortcuts: {
      //     LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
      //     LogicalKeySet(LogicalKeyboardKey.arrowRight): RightbuttonIntent(),
      //     LogicalKeySet(LogicalKeyboardKey.arrowLeft): LeftbuttonIntent(),
      //     LogicalKeySet(LogicalKeyboardKey.arrowUp): UpbuttonIntent(),
      //     LogicalKeySet(LogicalKeyboardKey.arrowDown): DownbuttonIntent(),
      //   },
      //   child: Actions(
      //     actions: <Type, Action<Intent>>{
      //       DownbuttonIntent: CallbackAction<DownbuttonIntent>(
      //           onInvoke: (intent) => _changeNodeFocus(context, "Down")),
      //       UpbuttonIntent: CallbackAction<UpbuttonIntent>(
      //           onInvoke: (inteent) => _changeNodeFocus(context, "Up")),
      //       RightbuttonIntent: CallbackAction<RightbuttonIntent>(
      //           onInvoke: (intent) => _changeNodeFocus(context, "Right")),
      //       LeftbuttonIntent: CallbackAction<LeftbuttonIntent>(
      //           onInvoke: (intent) => _changeNodeFocus(context, "Left")),
      //     },
      //     child: ListView(
      //       controller: _intentController.descPageScrollController,
      //       children: [
      //         SizedBox(
      //             height: MediaQuery.of(context).size.height,
      //             child: Stack(
      //               children: [
      //                 // !_videoPlayerController.value.isInitialized
      //                 //     ? Positioned(
      //                 //         child: SizedBox(
      //                 //           height: 500,
      //                 //           width: MediaQuery.of(context).size.width,
      //                 //           child: Image.network(
      //                 //             widget.bannerurl,
      //                 //             fit: BoxFit.fill,
      //                 //           ),
      //                 //         ),
      //                 //       )
      //                 //     : AspectRatio(
      //                 //         aspectRatio:
      //                 //             _videoPlayerController.value.aspectRatio,
      //                 //         child: VideoPlayer(_videoPlayerController),
      //                 //       ),
      //                 Positioned(
      //                   right: 100,
      //                   bottom: MediaQuery.of(context).size.height * 0.3,
      //                   child: Focus(
      //                     focusNode: _intentController.descNodes![0],
      //                     child: IconButton(
      //                       icon: Icon(
      //                         // !_videoPlayerController.value.isPlaying
      //                         Icons.play_circle_fill_rounded,
      //                         // : Icons.pause_circle_filled_rounded,
      //                         color: _intentController.descNodes![0].hasFocus
      //                             ? Colors.amber
      //                             : Colors.white,
      //                         size: 100,
      //                       ),
      //                       onPressed: () async {
      //                         // _videoPlayerController.value.isPlaying
      //                         //     ? _videoPlayerController.pause()
      //                         //     : _videoPlayerController.play();
      //                         // log("Video is ${_videoPlayerController.value}");
      //                       },
      //                     ),
      //                   ),
      //                 ),
      //                 Positioned(
      //                   bottom: 5,
      //                   child: Focus(
      //                     focusNode: _intentController.descNodes![1],
      //                     child: ModifiedText(
      //                         text: '⭐Average Rating - ${widget.vote}',
      //                         color: _intentController.descNodes![1].hasFocus
      //                             ? Colors.amber
      //                             : Colors.white60,
      //                         size: 20),
      //                   ),
      //                 ),
      //               ],
      //             )),
      //         Focus(
      //           focusNode: _intentController.descNodes![2],
      //           child: Container(
      //             padding: const EdgeInsets.all(10),
      //             child: ModifiedText(
      //                 text: widget.name, color: Colors.white60, size: 15),
      //           ),
      //         ),
      //         Focus(
      //           focusNode: _intentController.descNodes![3],
      //           child: Container(
      //             padding: const EdgeInsets.only(left: 5),
      //             child: ModifiedText(
      //                 text: 'Releasing On - ${widget.lauchOn}',
      //                 color: Colors.white60,
      //                 size: 15),
      //           ),
      //         ),
      //         Focus(
      //           focusNode: _intentController.descNodes![4],
      //           child: Row(
      //             children: [
      //               Container(
      //                 margin: const EdgeInsets.all(5),
      //                 height: 200,
      //                 width: 100,
      //                 child: Image.network(widget.posterurl),
      //               ),
      //               Flexible(
      //                 child: SizedBox(
      //                   child: ModifiedText(
      //                       text: widget.description,
      //                       color: Colors.white60,
      //                       size: 15),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         )
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
