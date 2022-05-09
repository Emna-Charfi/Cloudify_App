import 'package:cloudify_application/model/game_model.dart';
import 'package:cloudify_application/providers/cart.dart';

import 'package:cloudify_application/util/game_utils_free.dart';
import 'package:cloudify_application/widgets/badge.dart';
import 'package:cloudify_application/widgets/drawer/drawer.dart';
import 'package:cloudify_application/widgets/web_view.dart';
//import 'package:cloudify_application/widgets/web_view.dart';
//import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
//import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

class selectedGamePanier extends StatefulWidget {
  final int? index;
  const selectedGamePanier({Key? key, this.index}) : super(key: key);

  @override
  _selectedGamePanierState createState() => _selectedGamePanierState();
}

class _selectedGamePanierState extends State<selectedGamePanier> {
  late String idGame;
  late String prix;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<GameModels> games = GameUtilsFree.getMockedGames();

    return Scaffold(
      backgroundColor: const Color(0xFF232D3B),
      appBar: AppBar(
        title: const Text("CLOUDIFY "),
        backgroundColor: const Color(0xFF232D3B),
        elevation: 4.0,
        actions: [
          //Spacer(),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              color: Color(0xFFF17532),
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
                size: 25,
              ),
              onPressed: () {
                // setState(() {
                //   _currentIndex = 3;
                // });
                Navigator.of(context).pushNamed("/home/panier");
              },
            ),
          ),
        ],
      ),
      drawer: DrawerS(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //   SizedBox(height: 1),
            picture(games[widget.index!].image),
            subTitleSection(
                context,
                games[widget.index!].price,
                games[widget.index!].title,
                games[widget.index!].description,
                games[widget.index!].id),
            DescriptionSection(games[widget.index!].description),
            bottunTry(context, games[widget.index!].link),
            moreAboutSection,
            lineSection,
            //boxSectionText,

            iconPicture(games[widget.index!].gameImages),
            lineSection,
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

Widget picture(String image) => GestureDetector(
      child: Container(
          height: 400,
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  // borderRadius: BorderRadius.circular(20),
                  child: Image.network(image),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                          // Colors.black.withOpacity(0.7),
                          Colors.orangeAccent,
                          Colors.transparent
                        ]))),
              ),
            ],
          )),
    );

Widget subTitleSection(
    BuildContext context, int price, String title, String desc, String id) {
  return Container(
    // color: Colors.grey.shade200,
    height: 50,
    //margin: EdgeInsets.all(20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        //  SizedBox(width: 20),
        GestureDetector(
          child: Text(
            title,
            style: (TextStyle(
              //double underline
              decorationColor: Colors.brown, //text decoration 'underline' color
              decorationThickness: 1.5, //decoration 'underline' thickness
              fontStyle: FontStyle.normal,
              color: Colors.orangeAccent,
              fontWeight: FontWeight.w900,
              // fontStyle: ,
              fontSize: 20,
            )),
          ),
          onTap: () {
            // Navigator.pushNamed(context, "/resetPwd");
          },
        ),
      ],
    ),
  );
}

Widget DescriptionSection(String desc) {
  return Container(
    margin: EdgeInsets.fromLTRB(20, 10, 10, 10),
    child: RichText(
      text: TextSpan(
        text: desc,
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    ),
  );
}

Widget bottunTry(BuildContext context, String link) {
  return Container(
    margin: EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          // margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          height: 40,
          width: 360,
          child: ElevatedButton(
            child: const Text("Play Now !"),
            style: ElevatedButton.styleFrom(
              primary: Colors.deepOrangeAccent, // background

              onPrimary: Colors.white, // foreground
              //shape: StadiumBorder(),
              // side: BorderSide(width: 2, color: Colors.red),
            ),
            onPressed: () {
              print("Le port of web view" + link);
              // Navigator.pushNamed(context, "/webview");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WebViewD(link: link)));
            },
          ),
        ),
      ],
    ),
  );
}

// void _launchURL() async {
//   const _url = 'https://flutter.io';
//   if (!await launch(_url)) throw 'Could not launch $_url';
// }

Widget moreAboutSection = Container(
  // margin: EdgeInsets.all(20),
  padding: EdgeInsets.all(10),

  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        color: Colors.transparent,
        width: 32,
        height: 25,
      ),
      GestureDetector(
        child: const Text(
          "More Picture About this Game",
          style: (TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        ),
        onTap: () {
          // Navigator.pushNamed(context, "/resetPwd");
        },
      ),
      Container(
        color: Colors.transparent,
        width: 32,
        height: 25,
      ),
    ],
  ),
);

Widget iconPicture(List<String> games) {
  print("The Game Length*****" + games.length.toString());
  if (games.isEmpty) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            width: 340,
            height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.transparent,
                  // Color(0xFF232D3B),
                ],
              ),
            ),
            child: Container(
              width: double.infinity,
              //padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage("assets/images/Cyberpunk2077.jpg"),
                  // colorFilter: null,
                  fit: BoxFit.cover,
                ),
                // gradient: LinearGradient(
                //   begin: Alignment.topCenter,
                //   end: Alignment.bottomCenter,
                //   colors: [
                //     Color(0xFF232D3B),
                //     Colors.black,
                //   ],
                // ),
              ),
            ),
          ),

          // Text('New')
        ],
      ),
    );
  } else {
    print("***************************************");
    print("the first Game********************" + games[0].toString());
    print("the first Game********************" + games[1].toString());
    print("the first Game********************" + games[2].toString());
    print("the first Game********************" + games[3].toString());
    print("***************************************");

    return SingleChildScrollView(
      padding: EdgeInsets.all(5),
      scrollDirection: Axis.horizontal,
      // margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  width: 340,
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white,
                        Colors.transparent,
                        // Color(0xFF232D3B),
                      ],
                    ),
                  ),
                  child: Container(
                    width: double.infinity,
                    //padding: EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: NetworkImage(
                          games[0].toString(),
                        ),

                        // colorFilter: null,
                        fit: BoxFit.cover,
                      ),
                      // gradient: LinearGradient(
                      //   begin: Alignment.topCenter,
                      //   end: Alignment.bottomCenter,
                      //   colors: [
                      //     Color(0xFF232D3B),
                      //     Colors.black,
                      //   ],
                      // ),
                    ),
                  ),
                ),

                // Text('New')
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.fromLTRB(10, 20, 20, 10),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  width: 340,
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white,
                        Colors.transparent,
                        // Color(0xFF232D3B),
                      ],
                    ),
                  ),
                  child: Container(
                    width: double.infinity,
                    //padding: EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: NetworkImage(
                          games[1].toString(),
                        ),
                        // colorFilter: null,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.fromLTRB(10, 20, 20, 10),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  width: 340,
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white,
                        Colors.transparent,
                        // Color(0xFF232D3B),
                      ],
                    ),
                  ),
                  child: Container(
                    width: double.infinity,
                    //padding: EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: NetworkImage(
                          games[2].toString(),
                        ),
                        // colorFilter: null,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.fromLTRB(10, 20, 20, 10),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  width: 340,
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white,
                        Colors.transparent,
                        // Color(0xFF232D3B),
                      ],
                    ),
                  ),
                  child: Container(
                    width: double.infinity,
                    //padding: EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: NetworkImage(
                          games[3].toString(),
                        ),
                        // colorFilter: null,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}

Widget lineSection = Container(
  color: Colors.grey,
  padding: EdgeInsets.all(2),
);
