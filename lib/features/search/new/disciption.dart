import 'package:flutter/material.dart';

class BuildBody extends StatefulWidget {
  @override
  _BuildBodyState createState() => _BuildBodyState();
}

class _BuildBodyState extends State<BuildBody> {
  @override
  Widget build(BuildContext context) {
    double screanwidth = MediaQuery.of(context).size.width;
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
                          onPressed: (){}, 
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
      

    );
  }
}
