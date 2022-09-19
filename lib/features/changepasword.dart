import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.black,
        centerTitle: true,title: Text('')
        ,
      ),
      body:  Center(
        child: Container(
          width: 900,
          height: 500,
          
              child: Column(
                 children: [
                  SizedBox(height: 100,),
                  Container(
                    child: TextFormField(
                       decoration:  InputDecoration(
                       
                     labelText: 'Enter old Password',
                        icon: Icon(Icons.lock),
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
                        
                        
                     labelText: 'Enter new password',
                        icon: Icon(Icons.lock),
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
                        
                        
                     labelText: 'Confirm Password',
                        icon: Icon(Icons.lock),
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
                         labelText: 'Change',
                        
  ),
),                  width: 200,
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
