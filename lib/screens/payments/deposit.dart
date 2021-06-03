import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterwave/flutterwave.dart';
import 'package:ritech/Config/config.dart';
import 'package:ritech/screens/wallet/phoenixDetails.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();
  final currencyController = TextEditingController();
  final narrationController = TextEditingController();
  final publicKeyController = TextEditingController(
      text: "FLWPUBK_TEST-a66078f37583591f66918c168919a796-X");
  final encryptionKeyController =
      TextEditingController(text: "FLWSECK_TEST512dba327c2d");
  final emailController = TextEditingController(
      text: RitechApp.sharedPreferences.getString(RitechApp.userEmail));
  final phoneNumberController = TextEditingController(
      text: RitechApp.sharedPreferences.getString(RitechApp.phoneNumber));

  String selectedCurrency = "";

  @override
  Widget build(BuildContext context) {
    this.currencyController.text = this.selectedCurrency;
    print(RitechApp.sharedPreferences.getString(RitechApp.phoneNumber));
    return Scaffold(
      appBar: AppBar(
        title: Text("test"),
      ),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Form(
          key: this.formKey,
          child: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextFormField(
                  controller: this.amountController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(hintText: "Amount"),
                  validator: (value) =>
                      value.isNotEmpty ? null : "Amount is required",
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: RaisedButton(
                  onPressed: this._onPressed,
                  color: Colors.blue,
                  child: Text(
                    "Make Payment",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _onPressed() {
    if (this.formKey.currentState.validate()) {
      this._handlePaymentInitialization();
    }
  }

  _handlePaymentInitialization() async {
    final flutterwave = Flutterwave.forUIPayment(
        amount: this.amountController.text.toString().trim(),
        currency: "NGN",
        context: this.context,
        publicKey: this.publicKeyController.text.trim(),
        encryptionKey: this.encryptionKeyController.text.trim(),
        email: this.emailController.text.trim(),
        fullName: "Test User",
        txRef: DateTime.now().toIso8601String(),
        narration: "Example Project",
        isDebugMode: true,
        phoneNumber: this.phoneNumberController.text.trim(),
        acceptAccountPayment: true,
        acceptCardPayment: true,
        acceptUSSDPayment: true);
    final response = await flutterwave.initializeForUiPayments();
    if (response != null) {
      if (response.data.status == "successful") {
        savePaymentInfo();
        this.showLoading(response.data.status);
      }
    } else {
      this.showLoading("No Response!");
      AwesomeDialog(
        context: context,
        borderSide: BorderSide(color: Colors.green, width: 2),
        width: 380,
        buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
        headerAnimationLoop: false,
        animType: AnimType.BOTTOMSLIDE,
        title: '',
        desc: 'Are you sure you want to make this investment?',
        showCloseIcon: true,
        btnCancelOnPress: () {},
        btnOkOnPress: () {
          Route route = MaterialPageRoute(builder: (c) => PhoenixDetails());
          Navigator.push(context, route);
        },
      )..show();
    }
  }

  void _openBottomSheet() {
    showModalBottomSheet(
        context: this.context,
        builder: (context) {
          return this._getCurrency();
        });
  }

  Widget _getCurrency() {
    final currencies = [
      FlutterwaveCurrency.UGX,
      FlutterwaveCurrency.GHS,
      FlutterwaveCurrency.NGN,
      FlutterwaveCurrency.RWF,
      FlutterwaveCurrency.KES,
      FlutterwaveCurrency.XAF,
      FlutterwaveCurrency.XOF,
      FlutterwaveCurrency.ZMW
    ];
    return Container(
      height: 250,
      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
      color: Colors.white,
      child: ListView(
        children: currencies
            .map((currency) => ListTile(
                  onTap: () => {this._handleCurrencyTap(currency)},
                  title: Column(
                    children: [
                      Text(
                        currency,
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(height: 4),
                      Divider(height: 1)
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }

  _handleCurrencyTap(String currency) {
    this.setState(() {
      this.selectedCurrency = currency;
      this.currencyController.text = currency;
    });
    Navigator.pop(this.context);
  }

  Future<void> showLoading(String message) {
    return showDialog(
      context: this.context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            margin: EdgeInsets.fromLTRB(30, 20, 30, 20),
            width: double.infinity,
            height: 50,
            child: Text(message),
          ),
        );
      },
    );
  }

  Future savePaymentInfo() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = await _auth.currentUser();

    Firestore.instance
        .collection("users")
        .document(RitechApp.sharedPreferences.getString(RitechApp.userUID))
        .collection("transactions")
        .document()
        .setData({
      "uid": user.uid,
      "Email": user.email,
      "Amount": amountController.text.toString().trim(),
      "Name": RitechApp.sharedPreferences.getString(RitechApp.userName),
      "Time": DateTime.now(),
      "Phone Number":
          RitechApp.sharedPreferences.getString(RitechApp.phoneNumber),
    });

    var document =
        await Firestore.instance.collection('users').document(user.uid).get();
    int oldWalletvalue = document["Wallet"];
    int paid = int.parse(amountController.text.toString());
    int newWalletvalue = oldWalletvalue + paid;
    int passedWalletValue = newWalletvalue;

    print(amountController.text.toString());

    Firestore.instance.collection("users").document(user.uid).updateData({
      "Wallet": passedWalletValue,
    });
  }
}
