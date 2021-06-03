import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ritech/Config/colors.dart';
import 'package:ritech/Config/config.dart';
import 'package:ritech/screens/auth/login.dart';
import 'package:ritech/screens/auth/register.dart';
import 'package:ritech/screens/wallet/investment.dart';
import 'package:ritech/screens/wallet/transactions.dart';

class Wallet extends StatefulWidget {
  Wallet({Key key}) : super(key: key);

  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          bottom: PreferredSize(
              child: Container(
                color: Color(0xFF0F2F2F2),
                height: 4.0,
              ),
              preferredSize: Size.fromHeight(4.0)),
          leading: Container(
            height: 3,
            width: 3,
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.fromLTRB(20, 2, 0, 2),
            decoration:
                BoxDecoration(color: kHomeColor, shape: BoxShape.circle),
            child: Center(
              child: IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/back-n.svg",
                  color: kPrimaryColor,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
          title: Text(
            "Wallet",
            style: TextStyle(
              fontSize: 16,
              fontFamily: "Muli",
              fontWeight: FontWeight.w800,
              color: Color(0xFF05242C),
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                constraints: BoxConstraints(
                  minHeight: 200,
                ),
                decoration: new BoxDecoration(
                  color: kHomeColor,
                  border: Border.all(color: kPrimaryColor, width: 4),
                  borderRadius: new BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(50, 20, 50, 20),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Container(
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
                                                kPrimaryColor)),
                                  );
                                else {
                                  return Text(
                                    "\₦ " +
                                        snapshot.data.data["Wallet"].toString(),
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontFamily: "Muli",
                                        fontWeight: FontWeight.bold,
                                        color: kPrimaryColor),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Icon(
                                    Icons.arrow_circle_up,
                                    color: kPrimaryColor,
                                  ),
                                  InkWell(
                                    child: Center(
                                      child: Container(
                                        child: Text(
                                          "Deposit",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: "Muli",
                                              color: kPrimaryColor),
                                        ),
                                      ),
                                    ),
                                    onTap: () {},
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.bar_chart,
                                    color: kPrimaryColor,
                                  ),
                                  InkWell(
                                    child: Center(
                                      child: Container(
                                        child: Text(
                                          "Invest",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: "Muli",
                                              color: kPrimaryColor),
                                        ),
                                      ),
                                    ),
                                    onTap: () {},
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.arrow_circle_down,
                                    color: kPrimaryColor,
                                  ),
                                  InkWell(
                                    child: Center(
                                      child: Container(
                                        child: Text(
                                          "Withdraw",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: "Muli",
                                              color: kPrimaryColor),
                                        ),
                                      ),
                                    ),
                                    onTap: () {},
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            TabBar(
              unselectedLabelColor: kHomeColor,
              labelColor: kHomeColor,
              tabs: [
                Tab(
                  text: 'Investments',
                ),
                Tab(
                  text: 'Transactions',
                )
              ],
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: kPrimaryColor,
              indicatorWeight: 1.0,
            ),
            Expanded(
              child: TabBarView(
                children: [
                  WalletInvestment(),
                  WalletTransactions(),
                ],
                controller: _tabController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
