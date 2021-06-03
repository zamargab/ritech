import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ritech/Config/colors.dart';
import 'package:ritech/Config/config.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/back2.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Align(
                alignment: Alignment.bottomLeft,
                child: Image.asset(
                  "assets/images/rlogo.png",
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Ritech",
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: "Muli",
                      fontWeight: FontWeight.w800,
                      color: Colors.white),
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0, 10, 30),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi, Gabriel",
                        style: TextStyle(
                            fontSize: 25,
                            fontFamily: "Muli",
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor),
                      ),
                      Text(
                        "Here's Your Balance",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: "Muli",
                            color: Colors.white),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Wallet",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: "Muli",
                                    color: Colors.white),
                              ),
                              Container(
                                child: FutureBuilder<DocumentSnapshot>(
                                  future: Firestore.instance
                                      .collection("users")
                                      .document(RitechApp.sharedPreferences
                                          .getString(RitechApp.userUID))
                                      .get(),
                                  builder: (c, snapshot) {
                                    if (!snapshot.hasData)
                                      return Center(
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              new AlwaysStoppedAnimation<Color>(
                                                  kPrimaryColor),
                                        ),
                                      );
                                    else {
                                      return Text(
                                        "\₦ " +
                                            snapshot.data.data["Wallet"]
                                                .toString(),
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontFamily: "Muli",
                                            color: Colors.white),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 100),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Investment",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: "Muli",
                                    color: Colors.white),
                              ),
                              Container(
                                child: FutureBuilder<DocumentSnapshot>(
                                  future: Firestore.instance
                                      .collection("users")
                                      .document(RitechApp.sharedPreferences
                                          .getString(RitechApp.userUID))
                                      .get(),
                                  builder: (c, snapshot) {
                                    if (!snapshot.hasData)
                                      return Center(
                                        child: CircularProgressIndicator(
                                            valueColor:
                                                new AlwaysStoppedAnimation<
                                                    Color>(kPrimaryColor)),
                                      );
                                    else {
                                      return Text(
                                        "\₦ " +
                                            snapshot.data.data["Invest"]
                                                .toString(),
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontFamily: "Muli",
                                            color: Colors.white),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: _screenWidth,
                padding: EdgeInsets.fromLTRB(30, 20, 30, 10),
                decoration: new BoxDecoration(
                  color: Color(0xFFffffff),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      "Activities",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Muli",
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF05242C)),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: _screenWidth * 0.23,
                            minWidth: _screenWidth * 0.23,
                          ),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Color(0xFFf7f6f9),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 10),
                              Icon(
                                Icons.person,
                                color: kPrimaryColor,
                                size: 30,
                              ),
                              SizedBox(height: 20),
                              Text(
                                "Account",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: "Muli",
                                  color: Color(0xFF05242C),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: _screenWidth * 0.23,
                            minWidth: _screenWidth * 0.23,
                          ),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Color(0xFFf7f6f9),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 10),
                              Icon(
                                Icons.shield,
                                color: kPrimaryColor,
                                size: 30,
                              ),
                              SizedBox(height: 20),
                              Text(
                                "Privacy",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: "Muli",
                                  color: Color(0xFF05242C),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: _screenWidth * 0.23,
                            minWidth: _screenWidth * 0.23,
                          ),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Color(0xFFf7f6f9),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 10),
                              Icon(
                                Icons.help,
                                color: kPrimaryColor,
                                size: 30,
                              ),
                              SizedBox(height: 20),
                              Text(
                                "Help",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: "Muli",
                                  color: Color(0xFF05242C),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Text(
                      "Transactions",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Muli",
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF05242C)),
                    ),
                    SizedBox(height: 10),
                    StreamBuilder(
                        stream: Firestore.instance
                            .collection('users')
                            .document(RitechApp.sharedPreferences
                                .getString(RitechApp.userUID))
                            .collection("transactions")
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    kPrimaryColor),
                              ),
                            );
                          }

                          if (snapshot.data.documents.length < 1) {
                            return Center(
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/images/trans3.png",
                                    height: 200,
                                    width: MediaQuery.of(context).size.width *
                                        0.60,
                                    fit: BoxFit.cover,
                                  ),
                                  Text(
                                    "No Transactions",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontFamily: "Muli",
                                        color: Color(0xFF05242C)),
                                  ),
                                ],
                              ),
                            );
                          }

                          return new ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, index) {
                              final DocumentSnapshot _card =
                                  snapshot.data.documents[index];

                              return Column(
                                children: [
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 50,
                                          padding: EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                              color: Colors.redAccent,
                                              shape: BoxShape.circle),
                                          child: Icon(Icons.arrow_drop_down),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16.0, right: 8.0),
                                            child: Container(
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomLeft,
                                                    child: Text(
                                                      "Eagle Package",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: "Muli",
                                                        color:
                                                            Color(0xFF05242C),
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomLeft,
                                                    child: Text(
                                                      "${RitechApp.timeFormat.format(_card['Time'].toDate())}",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontFamily: "Muli",
                                                        color:
                                                            Color(0xFF808080),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 70,
                                          child: Text(
                                            "₦ " + _card['Amount'],
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: "Muli",
                                              color: Color(0xFF4F4F4F),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider(),
                                ],
                              );
                            },
                          );
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
