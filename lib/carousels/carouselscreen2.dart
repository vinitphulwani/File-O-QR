// ignore_for_file: use_key_in_widget_constructors, unnecessary_import, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:checkme/clipper.dart'as c;
import 'package:checkme/carousels/carouselscreen3.dart';

import 'package:page_transition/page_transition.dart';

class CarouselScreen2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CarouselScreen2State();
}

class CarouselScreen2State extends State<CarouselScreen2> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        
        children: [
         
          ClipPath(
            clipper: c.CurvedBottomClipper(),
            child:  Container(
            
            height: size.height * 0.55,
            decoration: BoxDecoration(
            
              
          //      borderRadius: BorderRadius.horizontal(
          // bottom: Radius.elliptical(
          //     MediaQuery.of(context).size.width, 100.0)),
   
            ),
            child:Image.asset("assets/images/carousel2image.jpg",fit: BoxFit.cover,width: double.infinity,)
      
          ),
          ),
          Align(alignment: Alignment.topLeft,child:  
                Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
            child:
            FractionallySizedBox(
                  widthFactor:
                      0.7, // Adjust as needed to control the width of the text box
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child:  Text("In-App Chat",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
                  ),
                )
               ),
          
          ),
          
          Align(alignment: Alignment.topLeft,child:  
                Padding(
            padding: const EdgeInsets.fromLTRB(30, 8, 0, 0),
            child:FractionallySizedBox(
                  widthFactor:
                      0.95, // Adjust as needed to control the width of the text box
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child:    Text("Real-time messaging within the app\nfor seamless communication and\ncollaboration between investors and\nstartups.",style: TextStyle(fontSize: 20),),
                  ),
                )
               ),
          ),
          // Align(alignment: Alignment.topLeft,child:  
          //       Padding(
          //   padding: const EdgeInsets.fromLTRB(30, 120, 0, 0),
          //   child:
          //       TextButton(onPressed: () {
            
          // }, child: Text("Skip Now",style: TextStyle(fontSize: 20),)),
          // ),)
          
        ],
        
      ),
    
  
       bottomNavigationBar:   Container(
        height: 100,
       
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(25,0,0,0),
              child: TextButton(onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   PageTransition(
                      //       child: phonenumberscreen(),
                      //       type: PageTransitionType.rightToLeftWithFade));
                  }, child: Text("Skip Now",style: TextStyle(fontSize: 20),)),
                  
            ),
            
            Padding(
              padding: const EdgeInsets.fromLTRB(150,0,0,0),
              child: CircleAvatar(
              radius: 35,
              backgroundColor: Colors.black,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: Icon(Icons.arrow_forward_outlined),
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: CarouselScreen3(),
                            type: PageTransitionType.rightToLeftWithFade ));
                  },
                ),
              ),
                      ),
            ),
          ],
        ),
      ),

    );
  }
}
