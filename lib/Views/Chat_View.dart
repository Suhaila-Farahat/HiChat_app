import 'package:chat_app/Components/Chat_Bubble.dart';
import 'package:chat_app/Constants.dart';
import 'package:chat_app/Features/Chat_Cubit/chat_cubit.dart';
import 'package:chat_app/Features/Chat_Cubit/chat_state.dart';
import 'package:chat_app/Models/Message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatView extends StatelessWidget {
  ChatView({super.key});
  static String id = 'Chat View';

  TextEditingController msgController = TextEditingController();
  final scrollController = ScrollController();

  List<MessageModel> messagesList = [];

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        title: Text(
          'HiChat',
          style: TextStyle(
              fontSize: 20, fontFamily: appFont, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                var ListOfMessages = BlocProvider.of<ChatCubit>(context).messagesList;
                return ListView.builder(
                  reverse: true,
                  controller: scrollController,
                  itemBuilder: (context, index) {
                    return ListOfMessages[index].id == email
                        ? ChatBubble(messageModel: ListOfMessages[index])
                        : ChatBubbleFriend(messageModel: ListOfMessages[index]);
                  },
                  itemCount: ListOfMessages.length,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: msgController,
              onSubmitted: (data) {
                BlocProvider.of<ChatCubit>(context).sendMessage(message: data, email: email.toString());

                msgController.clear();

                scrollController.animateTo(0,
                    duration: const Duration(seconds: 1), curve: Curves.easeIn);
              },
              style: TextStyle(
                  color: primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                suffixIcon: Icon(
                  Icons.send,
                  color: primaryColor,
                ),
                hintText: 'Message',
                hintStyle: TextStyle(
                    color: primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: primaryColor, width: 1.5)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: primaryColor, width: 1.5)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
