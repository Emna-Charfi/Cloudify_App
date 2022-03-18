import 'package:cloudify_application/game.dart';
import 'package:cloudify_application/store.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const String _title = 'Flutter ';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              //   SizedBox(height: 1),
              boxSection,
              //rowSection,
              lineSection,
              subTitleSection(context),

              boxSectionText,
              iconSection2,
              subTitleSectionTry(context),
              boxSectionTitle,
              informationText
            ],
          ),
        ),
      ),
    );
  }
}

Widget boxSection = Container(
  width: double.infinity,
  padding: EdgeInsets.all(25),
  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
  decoration: BoxDecoration(
    //  borderRadius: BorderRadius.circular(15),
    image: DecorationImage(
      image: AssetImage("assets/images/pleusieurJeux.jpg"),
      // colorFilter: null,
      fit: BoxFit.cover,
    ),
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFF232D3B),
        Colors.black,
      ],
    ),
  ),
  child: Container(
    width: double.infinity,
    height: 300,
    //padding: EdgeInsets.all(25),
    decoration: BoxDecoration(
      // borderRadius: BorderRadius.circular(15),
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.grey,
          Colors.transparent,
          Colors.green,
          //Color(0xFF232D3B),
        ],
      ),
    ),

    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 90),
        Text(
          'Play it is Gift ! ',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Instantly access a collection of games and try Stadia Pro for 1 month.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          child: const Text("Try For Free"),
          style: ElevatedButton.styleFrom(
            primary: Colors.orange, // background

            onPrimary: Colors.white, // foreground
          ),
          onPressed: () {},
        ),
        SizedBox(height: 10),
        Text(
          'You will be automatically charged 9.99 DT month at the end of the trial period. The subscription can be canceled at any time. Unless terminated beforehand, the subscription is renewed automatically.',
          style: TextStyle(color: Colors.white, fontSize: 8),
        ),
      ],
    ),
  ),
);

Widget rowSection = Container(
  color: Colors.black,
  height: 100,
  margin: EdgeInsets.all(20),
  child: Row(
    children: [
      Container(
        color: Colors.blue,
        height: 100,
        width: 100,
      ),
      Expanded(
        child: Container(
          color: Colors.amber,
        ),
      ),
      Container(
        color: Colors.purple,
        height: 100,
        width: 100,
      ),
    ],
  ),
);

Widget lineSection = Container(
  color: Colors.grey[200],
  padding: EdgeInsets.all(4),
);

Widget subTitleSection(BuildContext context) {
  return Container(
    margin: EdgeInsets.all(20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          color: Colors.green,
          width: 6,
          height: 30,
        ),
        Container(
          color: Colors.transparent,
          width: 105,
          height: 25,
        ),
        SizedBox(width: 20),
        GestureDetector(
          child: const Text(
            "About Cloudify",
            style: (TextStyle(color: Colors.grey, fontWeight: FontWeight.w600)),
          ),
          onTap: () {
            // Navigator.pushNamed(context, "/resetPwd");
          },
        ),
        SizedBox(width: 20),

        Container(
          color: Colors.transparent,
          width: 32,
          height: 25,
        ),
        //   Container(
        //     margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        //     child: ElevatedButton(
        //       child: const Text("Try Now"),
        //       style: ElevatedButton.styleFrom(
        //         primary: Colors.orange, // background

        //         onPrimary: Colors.white, // foreground
        //       ),
        //       onPressed: () {},
        //     ),
        //   ),
      ],
    ),
  );
}

Widget subTitleSectionTry(BuildContext context) {
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
            child: const Text("Show all the Games here"),
            style: ElevatedButton.styleFrom(
              primary: Colors.green, // background

              onPrimary: Colors.white, // foreground
              //shape: StadiumBorder(),
              // side: BorderSide(width: 2, color: Colors.red),
            ),
            onPressed: () {
              Navigator.pushNamed(context, "/home/store");
              //Store();
            },
          ),
        ),
      ],
    ),
  );
}

Widget boxSectionText = Container(
  width: double.infinity,
  padding: EdgeInsets.all(5),
  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
  child: Container(
    decoration: BoxDecoration(
      // borderRadius: BorderRadius.circular(15),
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white,
          Colors.white,
          //Color(0xFF232D3B),
        ],
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Enjoy more games ',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Buy your favorite games, without subscription.',
          style: TextStyle(
            color: Colors.black,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  ),
);

Widget iconSection2 = SingleChildScrollView(
  padding: EdgeInsets.all(10),
  scrollDirection: Axis.horizontal,
  // margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              width: 150,
              height: 150,
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
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              width: 150,
              height: 150,
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
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              width: 150,
              height: 150,
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
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              width: 150,
              height: 150,
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
      SizedBox(height: 10),
      Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              width: 150,
              height: 150,
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

Widget boxSectionTitle = Container(
  //width: double.infinity,
  padding: EdgeInsets.all(25),
  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
  width: 110,
  height: 90,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(15),
    image: DecorationImage(
      image: AssetImage("assets/images/logo2.png"),
      colorFilter: null,
      fit: BoxFit.cover,
    ),
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFF232D3B),
        Colors.white,
      ],
    ),
  ),
);

Widget informationText = Container(
  padding: EdgeInsets.all(5),
  margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        'The ideal subscription ',
        style: TextStyle(
          color: Colors.black,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 10),
      Text(
        'You will be automatically charged 9.99 DT month at the end of the trial period. The subscription can be canceled at any time. Unless terminated beforehand, the subscription is renewed automatically.',
        style: TextStyle(color: Colors.black, fontSize: 8),
      ),
    ],
  ),
);
