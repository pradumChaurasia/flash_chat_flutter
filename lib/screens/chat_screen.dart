// import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:flash_flutter/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firstore = FirebaseFirestore.instance;
User? loggedInUser;
class ChatPage extends StatefulWidget {
  static const id = 'chat_screen';
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final messageTextController=TextEditingController();
  final _auth = FirebaseAuth.instance;
  // User? loggedInUser;
  String messageText = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  // void getMessages()async{
  //   final messages=await _firstore.collection('messages').get();
  //   for(var message in messages.docs){
  //     print(message.data());
  //   }
  //
  // }

  // void messageStream() async {
  //   try {
  //     await for (var snapshot in _firstore.collection('messages').snapshots()) {
  //       for (var message in snapshot.docs) {
  //         print(message.data());
  //       }
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser?.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                // Implement logout functionality
                _auth.signOut();
                Navigator.pop(context);
                // getMessages();
                // messageStream();
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(),
            // StreamBuilder<QuerySnapshot>(
            //   stream: _firstore.collection('messages').snapshots(),
            //   builder: (context, snapshot) {
            //     if (!snapshot.hasData) {
            //       return Center(
            //         child: CircularProgressIndicator(
            //           backgroundColor: Colors.lightBlueAccent,
            //         ),
            //       );
            //     }
            //     final messages = snapshot.data?.docs;
            //     List<MessageBubbles> messagesBubbles = [];
            //     for (var message in messages!) {
            //       var data = message.data() as Map;
            //       final messageText = data['text'];
            //       final messageSender = data['sender'];
            //       final messageBubble = MessageBubbles(
            //         sender: messageSender,
            //         text: messageText,
            //       );
            //       messagesBubbles.add(messageBubble);
            //     }
            //     return Expanded(
            //       child: ListView(
            //         padding:
            //             EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            //         children: messagesBubbles,
            //       ),
            //     );
            //   },
            // ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        //Do something with the user input.
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(

                    onPressed: () {
                      messageTextController.clear();
                      //Implement send functionality.
                      //messsageText+loggedinUser
                      _firstore.collection('messages').add({
                        'text': messageText,
                        'sender': loggedInUser?.email,
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}

class MessagesStream extends StatelessWidget {
  const MessagesStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firstore.collection('messages').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data?.docs.reversed;
        List<MessageBubbles> messagesBubbles = [];
        for (var message in messages!) {
          var data = message.data() as Map;
          final messageText = data['text'];
          final messageSender = data['sender'];

          final currentUser=loggedInUser?.email;
          // if(currentUser==messageSender){
          //   //the message from the logged in user
          // }

          final messageBubble = MessageBubbles(
            sender: messageSender,
            text: messageText,
            isMe:currentUser==messageSender,
          );
          messagesBubbles.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding:
            EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messagesBubbles,
          ),
        );
      },
    );
  }
}


class MessageBubbles extends StatelessWidget {
  // const MessageBubbles({super.key});

  MessageBubbles({required this.sender, required this.text,required this.isMe});
  final String sender;
  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMe? CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(color: Colors.black54, fontSize: 12.0),
          ),
          Material(
              elevation: 5.0,
              // borderRadius: BorderRadius.circular(30.0),
              borderRadius: isMe? BorderRadius.only(topLeft: Radius.circular(30.0),
                  bottomLeft: Radius.circular(30.0),bottomRight: Radius.circular(30.0)):
              BorderRadius.only(topRight: Radius.circular(30.0),
                  bottomLeft: Radius.circular(30.0),bottomRight: Radius.circular(30.0)),
              color: isMe? Colors.lightBlueAccent: Colors.white,
              child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 15.0,
                      color: isMe?Colors.white:Colors.black54,
                    ),
                  ))),
        ],
      ),
    );
  }
}
