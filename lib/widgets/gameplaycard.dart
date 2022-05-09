import 'package:cloudify_application/model/game_model.dart';
import 'package:cloudify_application/widgets/web_view.dart';

import 'package:flutter/material.dart';

class GamePlayCard extends StatelessWidget {
  GameModels? game;
  Function? onCardClick;

  GamePlayCard({this.game, this.onCardClick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        this.onCardClick!();
      },
      child: Container(
          // margin: EdgeInsets.all(20),
          // height: 150,
          child: Stack(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                // begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  //  Colors.transparent,
                  Color.fromARGB(255, 132, 89, 26),

                  Colors.transparent.withGreen(7),
                  // Colors.white,
                  // Color(0xFF232D3B),
                ],
              ),
            ),
            child: Container(
                margin: EdgeInsets.all(20),
                height: 150,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child:
                            Image.network(this.game!.image, fit: BoxFit.cover),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                          height: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                              gradient: LinearGradient(
                                  // begin: Alignment.bottomCenter,
                                  // end: Alignment.topCenter,
                                  colors: [
                                    Colors.black.withOpacity(0.7),
                                    Colors.transparent
                                  ]))),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          //MainAxisAlignment.spaceBetween,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //SizedBox(width: 10),
                            Text(this.game!.title,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25)),
                            //Spacer(flex: 3),
                            //SizedBox(width: 10),
                            GestureDetector(
                              child: Icon(
                                Icons.play_arrow_sharp,
                                color: Colors.green,
                                size: 60,
                              ),
                              onTap: () async {
                                print("Le port of web view" + this.game!.link);
                                //WebView();
                                //PLAY NOW
                                //_launchURL();
                                //Navigator.pushNamed(context, "/webview");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            WebViewD(link: this.game!.link)));
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )),
          ),
        ],
      )),
    );
  }
}
