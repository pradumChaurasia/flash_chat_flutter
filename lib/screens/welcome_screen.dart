import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'register_screen.dart';
import 'package:flash_flutter/components/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id='welcome_screen';
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin{

  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller=AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
      // upperBound: 100,
    );
    animation=CurvedAnimation(parent: controller, curve: Curves.decelerate);
    // animation=ColorTween(begin: Colors.red,end:Colors.blue).animate(controller);
    controller.forward();
    // animation.addStatusListener((status) {
    //   if(status==AnimationStatus.completed){
    //     controller.reverse(from:1.0);
    //   }
    //   else if(status==AnimationStatus.dismissed){
    //     controller.forward();
    //   }
    // });

    controller.addListener(() {
      setState(() {
        print(animation?.value);
      });

    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // backgroundColor: Colors.red.withOpacity(controller.value),
      // backgroundColor: Colors.white,
        body: Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Hero(
                tag:'logo',

                createRectTween: (Rect? begin, Rect? end) {
                  return MaterialRectCenterArcTween(begin: begin, end: end);
                },
                child: Container(
                    child: Image(
                  image: AssetImage('images/logo.png'),
                  height: 60.0,
                )),
              ),
              AnimatedTextKit(
                    animatedTexts:[
                      TypewriterAnimatedText(
                        'Flash Chat',
                        // '${controller.value.toInt()}%',
                        textStyle: TextStyle(
                          fontSize: 45.0,
                          fontWeight: FontWeight.w900,
                          // color: Colors.black,
                        ),
                      ),
                    ],
                totalRepeatCount: 4,
                pause: const Duration(milliseconds: 1000),
                displayFullTextOnTap: true,
                stopPauseOnTap: true,
              ),

            ],
          ),
          SizedBox(
            height: 48.0,
          ),
          RoundButton(colour: Colors.lightBlueAccent,title: 'Log in',onpressed: (){
            Navigator.pushNamed(context, LoginPage.id);
          },),
          RoundButton(colour: Colors.blueAccent, title: 'Register', onpressed: (){
            Navigator.pushNamed(context, RegisterPage.id);
          }),
          // Padding(
          //   padding: EdgeInsets.symmetric(vertical: 16.0),
          //   child: Material(
          //       elevation: 5.0,
          //       color: Colors.blueAccent,
          //       borderRadius: BorderRadius.circular(30.0),
          //       child: MaterialButton(
          //         onPressed: () {
          //           Navigator.pushNamed(context, RegisterPage.id);
          //           // Navigator.push(context,MaterialPageRoute(builder: (context){
          //           //   return RegisterPage();
          //           // }));
          //         },
          //         minWidth: 200.0,
          //         height: 42.0,
          //         child: Text(
          //           'Register',
          //         ),
          //       )),
          // )
        ],
      ),
    ));
  }
}


