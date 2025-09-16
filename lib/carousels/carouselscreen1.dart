// ignore_for_file: use_key_in_widget_constructors, unnecessary_import, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:checkme/clipper.dart' as c;
import 'package:checkme/carousels/carouselscreen2.dart';
import 'package:page_transition/page_transition.dart';

class CarouselScreen1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CarouselScreen1State();
}

class CarouselScreen1State extends State<CarouselScreen1> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          ClipPath(
            clipper: c.CurvedBottomClipper(),
            child: Container(
              height: size.height * 0.55,
              decoration: BoxDecoration(
                // color: Colors.orange,

                //      borderRadius: BorderRadius.horizontal(
                // bottom: Radius.elliptical(
                //     MediaQuery.of(context).size.width, 100.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/images/demoImage.png',
                  height: size.height * 0.2,
                  width: size.width,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                child: FractionallySizedBox(
                  widthFactor:
                      0.7, // Adjust as needed to control the width of the text box
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "Match-Making\nAlgorithm",
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 8, 0, 0),
              child:FractionallySizedBox(
                  widthFactor:
                      0.95, // Adjust as needed to control the width of the text box
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child:   Text(
                "Experience the power of AI matchmaking,\nas our advanced algorithms analyze \ninvestor and startup profiles, intelligently\npairing them.",
                style: TextStyle(
                  fontSize:20,
                ),
              ),
                  ),
                )
             
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 100,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
              child: TextButton(
                  onPressed: () {
                    // Navigator.pushReplacement(
                    //     context,
                    //     PageTransition(
                    //         child: phonenumberscreen(),
                    //         type: PageTransitionType.rightToLeftWithFade));
                  },
                  child: Text(
                    "Skip Now",
                    style: TextStyle(fontSize: 20),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(150, 0, 0, 0),
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
                              child: CarouselScreen2(),
                              type: PageTransitionType.rightToLeftWithFade));
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
