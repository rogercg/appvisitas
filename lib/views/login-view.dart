import 'package:app_instagram/routes/router-constans.dart';
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
      if(account!=null){
        Navigator.pushNamed(context, HomeViewRoute);
      }
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: screenHeight * 0.30),
          child: Column(
            children: <Widget>[
                Text("Instamoment", style: TextStyle(color: Colors.black87, fontSize: 65, fontFamily: 'Billabong')),
                SizedBox(height: screenHeight*0.1),
                _btnSignGoogle(screenHeigh: screenHeight, screenWidth: screenWidth),
                SizedBox(height: 7.5),
                Divider(indent: 5, thickness: 1),
                SizedBox(height: 7.5),
                Container(
                  width: screenWidth - 60,
                  child: InkWell(
                    onTap: (){},
                    child: Text(
                      'Registrarte con tu correo electrónico o número de teléfono', 
                      style: TextStyle(
                        color: Color.fromRGBO(66, 133, 244, 1), 
                        fontWeight: FontWeight.bold, fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ),
        Column(
          children: <Widget>[
            Divider(indent: 5, thickness: 1),
            InkWell(
              onTap: (){},
              child: RichText(
                softWrap: true,
                overflow: TextOverflow.visible,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "¿Ya tienes una cuenta? ",
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: "Inicia sesión",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 15)
          ],
        )
      ],
    );
  }

  Widget _btnSignGoogle({double screenWidth, double screenHeigh}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 55,
          height: 55,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: const Radius.circular(5.0),
              topLeft: const Radius.circular(5.0),
            ),
            border: Border.all(
              color: Color.fromRGBO(66, 133, 244, 1),
              width: 3,
            )
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset('assets/images/google.png', fit: BoxFit.fill),
          )
        ),
        Container(
          width: screenWidth - 120,
          height: 55,//screenHeigh*0.12,
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