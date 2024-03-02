import 'dart:async';

import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:task_ai/models/chat_message_model.dart';
import 'package:task_ai/repos/chat_repo.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatSuccesState(messages: const [])) {
    on<ChatGenerateNewTextMessageEvent>(chatGenerateNewTextMessageEvent);

    
  }

  List<ChatMessageModel> messages = [];
  bool generating = false;

  FutureOr<void> chatGenerateNewTextMessageEvent(
    ChatGenerateNewTextMessageEvent event, Emitter<ChatState> emit) async {
      messages.add(ChatMessageModel(
        role: "user", parts: [
        ChatPartModel(text: event.inputMessage)
      ]));
  emit(ChatSuccesState(messages: messages));
  generating = true;
  String generateText = await ChatRepo.chatTextGenerationRepo(messages);
    if(generateText.isNotEmpty){
      messages.add(ChatMessageModel(role: 'model', parts: [
        ChatPartModel(text: generateText)
      ]));
      emit(ChatSuccesState(messages: messages));
    }
    generating = false;
  }
}
