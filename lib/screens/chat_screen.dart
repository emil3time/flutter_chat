import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_final/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final Stream<QuerySnapshot> _channelStream = FirebaseFirestore.instance
    .collection('messages')
    .orderBy('time', descending: false)
    .snapshots();
////
User? loggedInUser;

///////
class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  String? messageText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser!.email);
      }
    } catch (e) {
      print(e);
    }
  }
  // metoa ktorej uzywalem by sprawdzic dokumenty w bazie danych
  // void messagesStream() async {
  //   await for (var snapshot in _firestore.collection('messages').snapshots()) {
  //     for (var message in snapshot.docs) {
  //       print(message.data());
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
                // messagesStream();
                //Implement logout functionality
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
                  MaterialButton(
                    onPressed: () {
                      // clear field after send
                      messageTextController.clear();

                      //Implement send functionality.
                      // messageText + loggedInUser.email
                      _firestore.collection('messages').add({
                        'text': messageText,
                        'sender': loggedInUser!.email,
                        'time': FieldValue.serverTimestamp()
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
  }
}

class MessagesStream extends StatelessWidget {
  const MessagesStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      // <2> Pass `Stream<QuerySnapshot>` to stream
      stream: _channelStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        return Expanded(
          child: ListView(
              reverse: true,
              shrinkWrap: true,
              children: snapshot.data!.docs.reversed.map((docs) {
                String sender = docs['sender'];
                String newMessage = docs['text'];
                final currentUser = loggedInUser!.email;
                if (currentUser == sender) {
                  // this message is from now logged user
                }
                return MessageBubbles(
                  bubbleSender: sender,
                  bubbleNewMessage: newMessage,
                  // porownanie maila obecnie zalogowanego uzytkownika z mailem ktory jest przypisany do kazdej pojedynczej wiadomosci  jezeli sa identyczne bool isMe = true;
                  isMe: currentUser == sender,
                );
              }).toList()),
        );
      },
    );
  }
}

class MessageBubbles extends StatelessWidget {
  MessageBubbles({
    required this.bubbleSender,
    required this.bubbleNewMessage,
    required this.isMe,
  });

  final String bubbleSender;
  final String bubbleNewMessage;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            '$bubbleSender',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 12.0,
            ),
          ),
          Material(
            elevation: 5.0,
            color: isMe ? Colors.lightBlueAccent : Colors.white,
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
            child: Container(
              // width: MediaQuery.of(context).size.width / 1.2,
              // height: MediaQuery.of(context).size.height / 7,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Text(
                  '$bubbleNewMessage',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: isMe ? Colors.white : Colors.black54,
                    wordSpacing: 2.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//
//
// StreamBuilder<QuerySnapshot>(
// stream: _firestore.collection('messages').snapshots(),
// builder: (BuildContext context,
//     AsyncSnapshot<QuerySnapshot> snapshot) {
// if (snapshot.hasData) {
// final List<DocumentSnapshot> messages = snapshot.data!.docs;
// List<Text> messageWidgets = [];
// for (var message in messages) {
// final messageText = message['text'];
// final messageSender = message['sender'];
// final messageWidget =
// Text('$messageText from $messageSender');
// messageWidgets.add(messageWidget);
// }
// return Column(
// children: messageWidgets,
// );
// }
// },
// ),

//
// if (snapshot.hasError) {
// return Text(' Error: ${snapshot.hasError}');
// }
// switch (snapshot.connectionState) {
// case ConnectionState.waiting:
// return Center(
// child: CircularProgressIndicator(
// backgroundColor: Colors.blue,
// ),
// );
// default:
// final messages = snapshot.data!.docs;
// for (var message in messages) {
// final messageText = message['text'];
// final messageSender = message['sender'];
// final messageWidget = Text(
// '$messageText from $messageSender',
// style: TextStyle(fontSize: 50.0),
// );
// messageWidgets.add(messageWidget);
// }
// }
//
// return Expanded(
// child: ListView(
// reverse: false,
// padding: EdgeInsets.symmetric(
// vertical: 20.0, horizontal: 10.0),
// children: messageWidgets,
// ),
// );
