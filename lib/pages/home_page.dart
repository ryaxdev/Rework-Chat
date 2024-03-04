import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_ai/bloc/chat_bloc.dart';
import 'package:task_ai/models/chat_message_model.dart';
import 'package:task_ai/pages/web_view_container.dart';

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
      appBar: AppBar(
        
        title: const Text(
          'Rework Chat',
          style: TextStyle(fontSize: 25,),
          
        ),
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        elevation: 0.00,
        backgroundColor: Colors.grey[900],
        
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.coffee_rounded),
            onPressed: () {
              Navigator.push(context,
              MaterialPageRoute(builder: (context) => const WebViewContainer()));
            }
          )
        ],
      ),
      body: BlocConsumer<ChatBloc, ChatState>(
        bloc: chatBloc,
        listener: (context, state) {},
        
        builder: (context, state) {
          switch (state.runtimeType) {
            case const (ChatSuccesState):
            List<ChatMessageModel> messages = (state as ChatSuccesState).messages;
            
            return SizedBox(
            width: double.maxFinite,
            height: double.maxFinite,
            
            child: Column(
              
              children: [
                
                const SizedBox(
                  width: 15.0,
                  height: 15.0,
                ),
                Expanded(child:ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                  return Container(
                    
                    margin: const EdgeInsets.only(bottom: 15,right: 15,left: 15),
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
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
                        
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)
                          ),
                          color: const Color.fromARGB(255, 8, 8, 8),
                          
                          child: Row(
                            children: [
                              InkWell(
                                borderRadius: BorderRadius.circular(30),
                                onTap: () {},
                                child: Ink(
                                  width: 45,
                                  height: 45,
                                  child: const Icon(Icons.emoji_emotions_outlined),
                                  
                                ),
                              ),
                              Expanded(
                                child: TextFormField( 
                                  maxLines: 5,
                                  minLines: 1,    
                                  controller: textEditingController,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              
                            ],
                          ),
                        ),
                          
                      ),

                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)
                        ),
                        color: Colors.blue,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(30),
                            onTap: (){
                              if(textEditingController.text.isNotEmpty){
                            String text = textEditingController.text;
                            textEditingController.clear();
                            chatBloc.add(ChatGenerateNewTextMessageEvent(inputMessage: text));
                          }
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Icon(Icons.send_rounded),
                            ),
                          ),
                      ),
                      
                      //SizedBox(
                        
                      //  child: IconButton(
                      //    icon: const Icon(Icons.send_rounded),
                      //    iconSize: 50,
                      //    color: Colors.white,
                      //    onPressed: () {
                      //    if(textEditingController.text.isNotEmpty){
                      //      String text = textEditingController.text;
                      //      textEditingController.clear();
                      //      chatBloc.add(ChatGenerateNewTextMessageEvent(inputMessage: text));
                      //    }},
                          
                      //    ),
                      //),
                      
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