import 'package:flutter/material.dart';
import 'package:flash_flutter/components/rounded_button.dart';
import 'package:flash_flutter/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
class RegisterPage extends StatefulWidget {
  static const id='register_screen';
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<RegisterPage> {
  final _auth =FirebaseAuth.instance;
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
                    child: Container(
                      child:Image(
                        image:AssetImage('images/logo.png'),
                        height: 150.0,
                      ),

                    ),
                  ),
                ),
                SizedBox(
                    height:6.0
                ),
                TextField(
                  textAlign:TextAlign.center,
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
                  textAlign:TextAlign.center,
                  onChanged: (value){
                    password=value;
                  },
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your password'),
                ),
                SizedBox(
                  height: 15.0,
                ),
                RoundButton(colour:Colors.blueAccent,title:'Register',onpressed:()async {
                  setState(() {
                    showSpinner=true;
                  });
                  try{
                    final newUser=
                    await _auth.createUserWithEmailAndPassword(email: email, password: password);
                    if(newUser!=null){
                      Navigator.pushNamed(context, ChatPage.id);
                    }
                    setState(() {
                      showSpinner=false;
                    });

                  }
                  catch(e){
                    print(e);
                  }

                  // print(email);
                  // print(password);
                }),


              ],
            ),
          ),
        )
    );
  }
}

// class RoundedButton extends StatelessWidget {
//   const RoundedButton({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//         padding: EdgeInsets.symmetric(horizontal: 24.0),
//       child: Material(
//         color: Colors.blueAccent,
//         borderRadius: BorderRadius.all(Radius.circular(30.0)),
//         elevation: 5.0,
//         child: MaterialButton(
//           onPressed: () {
//             //Implement registration functionality.
//           },
//           minWidth: 200.0,
//           height: 42.0,
//           child: Text(
//             'Register',
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//       ),
//     );
//   }
// }
