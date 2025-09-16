// ignore_for_file: use_key_in_widget_constructors, unnecessary_import, prefer_const_constructors, sized_box_for_whitespace, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:checkme/clipper.dart'as c;

class CarouselScreen4 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CarouselScreen4State();
}

class CarouselScreen4State extends State<CarouselScreen4> {
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
            child:Image.asset("assets/images/carousel4image.jpg",fit: BoxFit.cover,width: double.infinity,)
      
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
                    child:  Text("Verified Startups\n& Investors",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
                  ),
                )
               ),
          
          ),
          
          Align(alignment: Alignment.topLeft,child:  
                Padding(
            padding: const EdgeInsets.fromLTRB(30, 8, 0, 0),
            child:FractionallySizedBox(
                  widthFactor:
                      0.85, // Adjust as needed to control the width of the text box
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child:    Text("Discover verified startups and\ninvestors, ensuring credibility and\ntrust within the MoneyFest.",style: TextStyle(fontSize: 18),),
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
    
  
       bottomNavigationBar:    Padding(
         padding: const EdgeInsets.all(16.0),
         child: ElevatedButton(child: Text("Continue",style: TextStyle(fontSize: 22,color: Colors.white),),onPressed: () {
              // Navigator.push(
              //           context,
              //           PageTransition(
              //               child: phonenumberscreen(),
              //               type: PageTransitionType.rightToLeftWithFade ));
          },style: ElevatedButton.styleFrom(backgroundColor: Colors.black45 ),),
       )
      

    );
  }
}
