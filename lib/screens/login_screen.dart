import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flash_flutter/components/rounded_button.dart';
import 'package:flash_flutter/constants.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
class LoginPage extends StatefulWidget {
  static const id='login_screen';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static final _auth=FirebaseAuth.instance;
  String email="";
  String password="";
  bool showSpinner=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag:'logo',
              createRectTween: (Rect? begin, Rect? end) {
                return MaterialRectCenterArcTween(begin: begin, end: end);
              },
                  child: Container(
                    child:Image(
                      image:AssetImage('images/logo.png'),
                      height: 150.0,
                    ),

                  ),
                ),
              ),
              SizedBox(
                height:8.0
              ),
              TextField(
                textAlign: TextAlign.center,
                onChanged: (value){
                    email=value;
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your Email'),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value){
                    password=value;
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your password'),
              ),
              SizedBox(
                height: 10.0,
              ),
              RoundButton(colour: Colors.lightBlueAccent,title: 'Log in',onpressed: ()async {
                setState(() {
                  showSpinner=true;
                });
                try{
                  final user=await _auth.signInWithEmailAndPassword(email: email, password: password);
                  if(user!=null){
                    Navigator.pushNamed(context, ChatPage.id);
                  }
                  setState(() {
                    showSpinner=false;
                  });
                }
                catch(e){
                  print(e);
                }
              },),


            ],
          ),
        ),
      )
    );
  }

}
