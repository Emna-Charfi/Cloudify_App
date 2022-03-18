import 'package:cloudify_application/model/game_model.dart';

import 'package:cloudify_application/util/game_utils.dart';

import 'package:flutter/material.dart';

class selectedGamePanier extends StatefulWidget {
  final int? index;
  const selectedGamePanier({Key? key, this.index}) : super(key: key);

  @override
  _selectedGamePanierState createState() => _selectedGamePanierState();
}

class _selectedGamePanierState extends State<selectedGamePanier> {
  late String idGame;
  late String prix;
  // late Panier? panier;

  @override
  void initState() {
    super.initState();

    // idGame = panier?.idGame ?? '';
    // prix = panier?.prix ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    List<GameModels> games = GameUtils.getMockedGames();

    return Scaffold(
      backgroundColor: const Color(0xFF232D3B),
      appBar: AppBar(
        title: const Text("CLOUDIFY "),
        // backgroundColor: const Color(0xFF232D3B),
        backgroundColor: Colors.transparent,
        elevation: 4.0,
        actions: [
          IconButton(
            onPressed: () => {
              //SharedPreferences prefs = await SharedPreferences.getInstance();
              // await prefs.clear();
              Navigator.pushReplacementNamed(context, "/signin"),
            },
            icon: Icon(
              Icons.logout,
              size: 30,
              color: Colors.green,
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            AppBar(
              automaticallyImplyLeading: false,
              title: const Text("CLOUDIFY"),
              backgroundColor: const Color(0xFF232D3B), //584C3B
            ),
            ListTile(
              title: Row(
                children: const [
                  Icon(Icons.edit),
                  SizedBox(
                    width: 20,
                  ),
                  Text("Modifier profil")
                ],
              ),
              onTap: () {
                Navigator.pushNamed(context, "/home/updateUser");
              },
            ),
            ListTile(
              title: Row(
                children: const [
                  Icon(Icons.vertical_align_bottom),
                  SizedBox(
                    width: 20,
                  ),
                  Text("Navigation du bas")
                ],
              ),
              onTap: () {
                Navigator.pushNamed(context, "/home");
              },
            ),
            ListTile(
              title: Row(
                children: const [
                  Icon(Icons.power_off_rounded),
                  SizedBox(
                    width: 20,
                  ),
                  Text("Disconnect")
                ],
              ),
              onTap: () async {
                //SharedPreferences prefs = await SharedPreferences.getInstance();
                // await prefs.clear();
                Navigator.pushReplacementNamed(context, "/signin");
              },
            )
          ],
        ),
      ),
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
            bottunTry(context),
            moreAboutSection,
            lineSection,
            //boxSectionText,

            iconPicture,
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
                  child: Image.asset(image, fit: BoxFit.cover),
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
    BuildContext context, double price, String title, String desc, String id) {
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
        // SizedBox(width: 20),
        // GestureDetector(
        //   child: Text(
        //     price.toString(),
        //     style: (TextStyle(
        //       //double underline
        //       decorationColor: Colors.brown, //text decoration 'underline' color
        //       decorationThickness: 1.5, //decoration 'underline' thickness
        //       fontStyle: FontStyle.normal,
        //       color: Colors.white,
        //       fontWeight: FontWeight.w900,
        //       // fontStyle: ,
        //       fontSize: 20,
        //     )),
        //   ),
        //   onTap: () {
        //     // Navigator.pushNamed(context, "/resetPwd");
        //   },
        // ),
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

Widget bottunTry(BuildContext context) {
  return Container(
    margin: EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          // margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          height: 30,
          width: 290,
          child: ElevatedButton(
            child: const Text("Play Now !"),
            style: ElevatedButton.styleFrom(
              primary: Colors.redAccent.shade700, // background

              onPrimary: Colors.white, // foreground
              //shape: StadiumBorder(),
              // side: BorderSide(width: 2, color: Colors.red),
            ),
            onPressed: () {
              //Navigator.pushNamed(context, "/home/panier");
              //Play Npw
            },
          ),
        ),
      ],
    ),
  );
}

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

Widget iconPicture = SingleChildScrollView(
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
                    image: AssetImage("assets/images/Spellbreak.jpg"),
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
                    image:
                        AssetImage("assets/images/Horizon_Forbidden_West.jpg"),
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
                    image: AssetImage("assets/images/fifa-world.jpg"),
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
                    image: AssetImage("assets/images/Dying_Light_2.jpg"),
                    // colorFilter: null,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  ),
);

Widget lineSection = Container(
  color: Colors.grey,
  padding: EdgeInsets.all(2),
);
