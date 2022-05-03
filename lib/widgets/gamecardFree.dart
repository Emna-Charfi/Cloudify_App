import 'package:cloudify_application/model/game_model.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FreeGameCard extends StatelessWidget {
  GameModels? game;
  Function? onCardClick;

  FreeGameCard({this.game, this.onCardClick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        this.onCardClick!();
      },
      child: Container(
          //margin: EdgeInsets.all(5),
          height: 300,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(15),
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(70),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      Colors.transparent,
                      Colors.white,

                      Colors.orangeAccent.shade100,
                      Colors.white,

                      Colors.white,
                      Colors.orangeAccent.shade100,
                      Colors.transparent,
                      // Color(0xFF232D3B),
                    ],
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.fromLTRB(5, 5, 5, 25),
                  height: 150,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: GestureDetector(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(this.game!.image,
                                fit: BoxFit.cover),
                            //Image.asset(),
                          ),
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
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Colors.black.withOpacity(0.7),
                                      Colors.transparent
                                    ]))),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              SizedBox(width: 10),
                              Text(this.game!.title,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25))
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              SizedBox(width: 10),
                              IconButton(
                                onPressed: () {
                                  // PLAY NOW
                                  //_launchURL();
                                  Navigator.pushNamed(context, "/webview");
                                },
                                icon: Icon(
                                  Icons.play_circle_fill,
                                  size: 70,
                                  color: Colors.orange,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }

  void _launchURL() async {
    const _url = 'https://flutter.io';
    if (!await launch(_url)) throw 'Could not launch $_url';
  }
}
