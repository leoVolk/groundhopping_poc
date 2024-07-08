import 'package:flutter/material.dart';
import 'package:learning_flutter/widgets/messages/messagebubble.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key, required this.chatId});

  final int chatId;

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  ScrollController _scrollController = ScrollController();
  TextEditingController _textController = TextEditingController();
  bool _inputFocused = false;
  List<Widget> _messages = List.generate(
      10,
      (index) => MessageBubbleWidget(
          content:
              'Supporting line text lorem ipsum dolor sit amet, consectetur.'));

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    _scrollController.dispose();
    _textController.dispose();
  }

  _addMessage() {
    if (_textController.text != '') {
      setState(() {
        _messages.add(MessageBubbleWidget(
          content: _textController.text,
        ));
      });

      _textController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text('Chat_${widget.chatId}'),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
        ),
        body: Column(
          children: [
            Expanded(
                child: ListView(
              controller: _scrollController,
              reverse: true,
              children: _messages.reversed.toList(),
            )),
            Container(
                color: Theme.of(context).colorScheme.surfaceContainer,
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (!_inputFocused)
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.add_circle_outline_outlined)),
                        if (!_inputFocused)
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.emoji_emotions_outlined)),
                        Expanded(
                            child: TextField(
                          onTap: () => {
                            setState(() {
                              _inputFocused = true;
                            }),
                          },
                          onTapOutside: (event) => {
                            setState(() {
                              _inputFocused = false;
                            }),
                          },
                          maxLines: 3,
                          minLines: 1,
                          controller: _textController,
                          decoration: InputDecoration(
                            hintText: 'Write a message...',
                            fillColor: Theme.of(context).colorScheme.surfaceDim,
                            filled: true,
                            isDense: true,
                            prefixIcon: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.text_fields),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                                borderSide: BorderSide.none),
                          ),
                        )),
                        IconButton(
                            onPressed: () {
                              _addMessage();
                            },
                            icon: Icon(Icons.send)),
                      ],
                    ),
                  ),
                ))
          ],
        ));
  }
}
