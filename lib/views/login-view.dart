import 'package:app_instagram/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final dynamic       _scaffoldKey  = GlobalKey<ScaffoldState>();
  final GoogleSignIn  _googleSignIn = GoogleSignIn();
  GoogleSignInAccount _currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      print(account);
      account.authentication.then((GoogleSignInAuthentication value){
        print(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;  
    final screenHeight = size.height;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Color.fromRGBO(236, 240, 241, 1),
        key: _scaffoldKey,
        body: Stack(
          children: <Widget>[
            LayoutBuilder(builder: (BuildContext context, BoxConstraints viewportConstraints){
              return Container(
                // color: Colors.white,
                width: screenWidth,
                height: screenHeight,
                child: _body(screenHeight: screenHeight, screenWidth: screenWidth),
              );
            })
          ],
        ),
      ),
    );
  }

  Widget _body({double screenWidth, double screenHeight}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // Image.asset('assets/images/logo.png', height: 75, alignment: Alignment.center, fit: BoxFit.fill),
        SizedBox(height: 100),
        Text("Ingresa", style: TextStyle(color: Colors.white, fontSize: 18)),
        SizedBox(height: 100),
        _btnSignGoogle(screenHeigh: screenHeight, screenWidth: screenWidth),
        SizedBox(height: 25)
      ],
    );
  }

  Widget _btnSignGoogle({double screenWidth, double screenHeigh}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: const Radius.circular(5.0),
              topLeft: const Radius.circular(5.0),
            ),
            border: Border.all(
              color: Color.fromRGBO(66, 133, 244, 1),
              width: 3, //                   <--- border width here
            )
          ),
          child: Container(
            width: 10,
            height: 10,
            child: Image.asset('assets/images/google.png', fit: BoxFit.fill)
          ),
        ),
        Container(
          width: 250,//screenWidth*0.75,
          height: 60,//screenHeigh*0.12,
          decoration: BoxDecoration(
            color: Color.fromRGBO(66, 133, 244, 1),
            borderRadius: BorderRadius.only(
              bottomRight: const Radius.circular(5.0),
              topRight: const Radius.circular(5.0),
            ),
          ),
          child: MaterialButton(
            onPressed: ()async {
              try {
                await _googleSignIn.signIn();
              }catch (error) {
                print(error);// Mostrar mensaje de error
              }
            },
            child: Text("Ingresar con Google", style: TextStyle(color:Colors.white, fontSize: 18)),
          ),
        ),
      ],
    );
  }
}