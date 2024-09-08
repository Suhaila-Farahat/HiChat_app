class MessageModel {
  final String msg;
  final String id;

  MessageModel({required this.msg, required this.id});

  factory MessageModel.fromJson(json) {
    return MessageModel(
        msg: json['msg'],
        id: json['id']
    );
  }
}
