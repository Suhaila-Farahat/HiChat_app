import 'package:chat_app/Constants.dart';
import 'package:chat_app/Models/Message_model.dart';
import 'package:flutter/material.dart';


class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key,required this.messageModel});

  final MessageModel messageModel;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
            top: 10,
            left: 15
        ),
        decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.only(
              topLeft:Radius.circular(20),
              topRight:Radius.circular(20),
              bottomRight:Radius.circular(20),
            )
        ),
        child:Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            messageModel.msg,
            style:TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontFamily: appFont,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}


class ChatBubbleFriend extends StatelessWidget {
  const ChatBubbleFriend({super.key,required this.messageModel});

  final MessageModel messageModel;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(
            top: 10,
            right: 15
        ),
        decoration: BoxDecoration(
            color: Color(0xff092635),
            borderRadius: BorderRadius.only(
              topLeft:Radius.circular(20),
              topRight:Radius.circular(20),
              bottomLeft:Radius.circular(20),
            )
        ),
        child:Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            messageModel.msg,
            style:TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontFamily: appFont,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
