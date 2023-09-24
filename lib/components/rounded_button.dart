import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {

  RoundButton({required this.colour,required this.title, required this.onpressed});
  final Color colour;
  final String title;
  final Function onpressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: (){
            if(onpressed!=null){
              onpressed!();
            }
          },
          // onPressed: () {
          //
          //   // Navigator.pushNamed(context, LoginPage.id);
          //   // Navigator.push(context,MaterialPageRoute(builder: (context){
          //   //   return LoginPage();
          //   // }
          //   // ),
          //   // );
          // },
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white
            ),
          ),
        ),
      ),
    );
  }
}