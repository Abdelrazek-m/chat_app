// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat/constant.dart';
import 'package:scholar_chat/views/cubits/chat_cubit/chat_cubit.dart';
import 'package:scholar_chat/widgets/freind_chat_bubble.dart';
import '../models/message_model.dart';
import '../widgets/chat_bubble.dart';

class ChatView extends StatelessWidget {
  ChatView({Key? key}) : super(key: key);

  static String id = '/ChatView';
  List<MessageModel> messagesList = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  _scrollDown() {
    _scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: kMainColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(kLogo, height: 50),
              Text(
                ' Chat',
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocConsumer<ChatCubit, ChatState>(
                listener: (context, state) {
                  if (state is ChatSuccess) {
                    messagesList = state.messagesList;
                  }
                },
                builder: (context, state) {
                  return ListView.builder(
                    controller: _scrollController,
                    reverse: true,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) =>
                        messagesList[index].id == email
                            ? ChatBubble(
                                message: messagesList[index].message,
                              )
                            : FriendChatBubble(
                                message: messagesList[index].message),
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(12),
              child: TextField(
                controller: _controller,
                onSubmitted: (message) {
                  if (message != '') {
                    BlocProvider.of<ChatCubit>(context)
                        .sendMessage(message: message, email: email);
                    _controller.clear();
                    _scrollDown();
                  }
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: kMainColor, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: kMainColor, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                  hintText: 'enter message',
                  //emoji emotions
                  prefixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.emoji_emotions),
                  ),
                  //send icon button
                  suffixIcon: IconButton(
                    onPressed: () {
                      if (_controller.text != '') {
                        try {
                          BlocProvider.of<ChatCubit>(context).sendMessage(
                              message: _controller.text, email: email);
                          _controller.clear();
                          _scrollDown();
                        } on Exception catch (e) {
                          log(e.toString());
                        }
                      }
                      // add message to firebase storage
                    },
                    icon: Icon(
                      Icons.send_rounded,
                      color: kMainColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
