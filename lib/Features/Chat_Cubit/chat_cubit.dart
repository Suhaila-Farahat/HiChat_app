import 'package:chat_app/Features/Chat_Cubit/chat_state.dart';
import 'package:chat_app/Models/Message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  static ChatCubit get(context) => BlocProvider.of(context);

  CollectionReference messages = FirebaseFirestore.instance.collection('messages');

  List<MessageModel> messagesList = [];


  void sendMessage ({required String message , required String email}){
    messages.add({
      'msg' : message,
      'createdAt' :DateTime.now(),
      'id' : email
    });
  }

  void getMessages (){
    messages.orderBy('createdAt',descending:true ).snapshots().listen((event){
      for(var doc in event.docs){
        messagesList.clear();
        messagesList.add(MessageModel.fromJson(doc));
      }
        emit(ChatSuccess(messages: messagesList));
    });

  }
}