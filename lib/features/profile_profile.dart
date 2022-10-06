import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.black,
        centerTitle: true,title: Text('profile')
        ,
      ),
      body:  Center(
        child: Container(
        

          width: 900,
          height: 500,
          
        
          
          // decoration: BoxDecoration(
            
          //     border: Border.all(
          //       color: Colors.black, //color of border
          //       width: 2, //width of border
          //     ),
          //     borderRadius: BorderRadius.circular(5)),
              child: Column(
                 children: [
                  SizedBox(height: 100,),
                  Container(
                    child: TextFormField(
                       decoration:  InputDecoration(
                       
                     labelText: 'ruth',
                        icon: Icon(Icons.person),
  ),
),                  width: 500,
                    height: 60,
                    decoration: BoxDecoration(border: Border.all(
                      color: Colors.white,
                      width: 2,
                    )),
                    
                  ),
                  SizedBox(height:10,),
                  Container(
                    child: TextFormField(
                       decoration:  InputDecoration(
                        
                        
                     labelText: 'Asmelash',
                        icon: Icon(Icons.person),
  ),
),                  width: 500,
                    height: 60,
                    decoration: BoxDecoration(border: Border.all(
                      color: Colors.white,
                      width: 2,
                    )),
                    
                  ),
                  SizedBox(height: 10,),
                  Container(
                    child: TextFormField(
                       decoration:  InputDecoration(
                        
                        
                     labelText: 'Female',
                        icon: Icon(Icons.people),
  ),
),                  width: 500,
                    height: 60,
                    decoration: BoxDecoration(border: Border.all(
                      color: Colors.white,
                      width: 2,
                    )),
                    
                  ),SizedBox(height: 10,),
                  Container(
                    child: TextFormField(
                       decoration:  InputDecoration(
                        
                        
                     labelText: 'DateOfBirth',
                        icon: Icon(Icons.timeline),
  ),
),                  width: 500,
                    height: 60,
                    decoration: BoxDecoration(border: Border.all(
                      color: Colors.white,
                      width: 2,
                    )),
                    
                  )
                ],
                
              ),
        ),
      ),
    );


  }
}
