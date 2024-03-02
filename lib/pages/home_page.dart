import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:task_ai/bloc/chat_bloc.dart';
import 'package:task_ai/models/chat_message_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ChatBloc chatBloc = ChatBloc();
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ChatBloc, ChatState>(
        bloc: chatBloc,
        listener: (context, state) {
        
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case ChatSuccesState:
            List<ChatMessageModel> messages = (state as ChatSuccesState).messages;
            return Container(
            width: double.maxFinite,
            height: double.maxFinite,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: 100,
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Rework Chat",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      Icon(
                        Icons.image_search,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                Expanded(child:ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 15,right: 15,left: 15),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white.withOpacity(0.1)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(messages[index].role == "user" ? "User" : "Chat IA",
                        style: TextStyle(
                          fontSize: 16,
                          color: messages[index].role == "user" ? Colors.amber : Colors.purple.shade200
                        ),),
                        const   SizedBox(height: 12,),
                        Text(messages[index].parts.first.text,
                        style: const TextStyle(height: 1.2),),
                      ],
                    ));
                })),
                if (chatBloc.generating) Row(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      child: Lottie.asset('assets/loader.json')),
                  ],
                ),
                Container(

                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                            controller: textEditingController,
                        style: const TextStyle(color: Colors.black),
                        cursorColor: Theme.of(context).primaryColor,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100)),
                            fillColor: Colors.white,
                            hintText: "Preguntale algo a la IA",
                            hintStyle: TextStyle(
                              color: Colors.grey.shade400
                            ),
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor))),
                      )),
                      const SizedBox(width: 12),
                      InkWell(
                        onTap: () {
                          if(textEditingController.text.isNotEmpty){
                            String text = textEditingController.text;
                            textEditingController.clear();
                            chatBloc.add(ChatGenerateNewTextMessageEvent(inputMessage: text));
                          }
                        },
                        child: CircleAvatar(
                          radius: 32,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Theme.of(context).primaryColor,
                            child: const Center(
                              child: Icon(Icons.send, color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );

            default:

            return const SizedBox();
          }
        },
      ),
    );
  }
}
