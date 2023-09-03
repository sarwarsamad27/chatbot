import 'dart:convert';

import 'package:ai/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

import 'model.dart';

class message extends StatefulWidget {
  const message({super.key});

  @override
  State<message> createState() => _messageState();
}

class _messageState extends State<message> {
  late bool isLoading;

  TextEditingController _textController = TextEditingController();
  final _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = false;
  }

  Future<String> generateResponse(prompt)async{
    final apiKey =apiSecretKey;
    var url = Uri.https("api.openai.com","/v1/completions");

    final response  = await http.post(
        url,
        headers: {
          'content-Type':'application/json',
          'Authorization':'Bearer $apiKey'
        },
        body: jsonEncode({
          "model": "text-davinci-003",
          "prompt":prompt,
          'temperature': 0,
          'max_tokens': 2000,
        })

    );
    Map<String ,dynamic> getresponse = jsonDecode(response.body);
    print(getresponse['choices'][0]);
    return getresponse['choices'][0]['text'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Group discuss'),
        centerTitle: true,
        backgroundColor: Colors.black26,
      ),

      body: Column(
        children: [
          Expanded(
            child: _buildList(),
          ),
          Visibility(
            visible: isLoading,
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                _buildInput(),
                // _buildMike(),
                _buildSubmit(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Expanded _buildInput() {
    return Expanded(
        child: TextField(
          textCapitalization: TextCapitalization.sentences,
          style: const TextStyle(color: Colors.white),
          controller: _textController,
          cursorColor: Colors.white,
          decoration: const InputDecoration(
            fillColor: Colors.grey,
            filled: true,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
          ),
        ));
  }

  // Widget _buildMike() {
  //   return Visibility(
  //       visible: !isLoading,
  //       child: Container(
  //         child: IconButton(
  //           icon: Icon(Icons.mic, color: Colors.grey),
  //           onPressed: () {},
  //         ),
  //       ));
  // }

  Widget _buildSubmit() {
    return Visibility(
        visible: !isLoading,
        child: Container(
          child: IconButton(
            icon: const Icon(
              Icons.send_rounded,
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                _messages.add(ChatMessage(text: _textController.text, chatMessageType: ChatMessageType.user));
                isLoading=true;
              });
              var input = _textController.text;
              _textController.clear();
              Future.delayed(const Duration(milliseconds: 50)).then((value) => _scrollDown());

              generateResponse(input).then((value) {
                setState(() {
                  isLoading = false;
                  _messages.add(ChatMessage(text: value, chatMessageType: ChatMessageType.bot));
                });
              });
              _textController.clear();
              Future.delayed(const Duration(milliseconds: 50)).then((value) => _scrollDown());
            },
          ),
        ));
  }
  void _scrollDown(){
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  ListView _buildList() {
    return ListView.builder(
        controller: _scrollController,
        itemCount: _messages.length > 10 ? 10 : _messages.length,
        itemBuilder: ((context, index) {
          var message = _messages[ index];
          return ChatMessageWigdet(
            text: message.text,
            chatMessageType: message.chatMessageType,
          );
        }));
  }
}

class ChatMessageWigdet extends StatelessWidget {
  final String text;
  final ChatMessageType chatMessageType;
  const ChatMessageWigdet(
      {super.key, required this.text, required this.chatMessageType});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(16),
      color: Colors.grey,
      child: Row(children: [
        chatMessageType == ChatMessageType.bot
            ? Container(
            margin: const EdgeInsets.only(right: 16),
            child: const CircleAvatar(
              backgroundColor: Colors.grey,
              child: Image(image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2qcUWZ2_pDJHlcPvMfFiRACR1FHrXBl8quA&usqp=CAU') ),

            ))
            : Container(
          margin: const EdgeInsets.only(right: 16),
          child: const CircleAvatar(
            child: Icon(Icons.person),
          ),
        ),
        Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Text(
                    text,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.white),
                  ),
                )
              ],
            ))
      ]),
    );
  }
}
