import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<types.Message> _messages = [];
  final _user = const types.User(id: '82091008-a484-4a89-ae75-a22bf8d6f3ac');
  final _diagBot = const types.User(
    id: 'diagbot',
    firstName: 'DiagBot',
    imageUrl: 'https://example.com/bot-avatar.png',
  );

  @override
  void initState() {
    super.initState();
    _addMessage(types.TextMessage(
      author: _diagBot,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: 'How can I help you today?',
    ));
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    _addMessage(textMessage);

    // Simulate bot response
    Future.delayed(const Duration(seconds: 1), () {
      if (message.text.toLowerCase().contains('zirin')) {
        _addMessage(types.TextMessage(
          author: _diagBot,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: const Uuid().v4(),
          text: "Here's some results for Zirin",
        ));
        _addMessage(types.TextMessage(
          author: _diagBot,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: const Uuid().v4(),
          text: 'Sure. Take a picture of the affected area and Ill help with diagnosis',
        ));
      } else if (message.text.toLowerCase().contains('skin problem')) {
        _addMessage(types.TextMessage(
          author: _diagBot,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: const Uuid().v4(),
          text: 'Sure. Take a picture of the affected area and Ill help with diagnosis',
        ));
      } else {
        _addMessage(types.TextMessage(
          author: _diagBot,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: const Uuid().v4(),
          text: 'How can I assist you further?',
        ));
      }
    });
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.camera,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = types.ImageMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: 1440,
        id: const Uuid().v4(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: 1440,
      );

      _addMessage(image);

      // Simulate diagnosis response
      Future.delayed(const Duration(seconds: 2), () {
        _addMessage(types.TextMessage(
          author: _diagBot,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: const Uuid().v4(),
          text: 'Given the rash pattern, it is urticaria. For this I recommend getting a antihistamine.',
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('DiagBot'),
      ),
      body: Chat(
        messages: _messages,
        onSendPressed: _handleSendPressed,
        user: _user,
        theme: DefaultChatTheme(
          backgroundColor: const Color(0xFF2B3446),
          inputBackgroundColor: const Color(0xFF353F54),
          primaryColor: Colors.blue,
          secondaryColor: const Color(0xFF353F54),
          inputTextColor: Colors.white,
          inputTextCursorColor: Colors.white,
          inputTextDecoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(16),
            hintStyle: TextStyle(color: Colors.white54),
            hintText: 'Ask Anything',
          ),
        ),
        customBottomWidget: Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Color(0xFF2B3446),
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF353F54),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(16),
                            hintStyle: TextStyle(color: Colors.white54),
                            hintText: 'Ask Anything',
                          ),
                          onSubmitted: (text) {
                            if (text.isNotEmpty) {
                              _handleSendPressed(types.PartialText(text: text));
                            }
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.mic, color: Colors.white54),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: IconButton(
                  icon: const Icon(Icons.camera_alt, color: Colors.white),
                  onPressed: _handleImageSelection,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 