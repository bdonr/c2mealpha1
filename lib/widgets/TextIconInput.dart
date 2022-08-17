import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextIconInput extends StatefulWidget {
  const TextIconInput({Key? key}) : super(key: key);

  @override
  State<TextIconInput> createState() => _TextIconInputState();
}

class _TextIconInputState extends State<TextIconInput> {
  final TextEditingController _controller = TextEditingController();
  bool emojiShowing = false;

  @override
  _onEmojiSelected(Emoji emoji) {
    print(_controller.text);
  }

  _onBackspacePressed() {
    print(_controller.text);
  }
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 400,
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Material(
                    color: Colors.transparent,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          emojiShowing = !emojiShowing;
                        });
                      },
                      icon: const Icon(
                        Icons.emoji_emotions,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                          controller: _controller,
                          style: const TextStyle(
                              fontSize: 20.0,
                              color: Colors.black87),
                          decoration: InputDecoration(
                            hintText: 'Type a message',
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.only(
                                left: 16.0,
                                bottom: 8.0,
                                top: 8.0,
                                right: 16.0),

                          )),
                    ),
                  ),
                  Material(
                    color: Colors.deepPurple,
                    child: IconButton(
                        onPressed: () {
                          // send message
                        },
                        icon: const Icon(
                          Icons.send,
                          color: Colors.white,
                        )),
                  )
                ],
              ),
            ),
            Offstage(
              offstage: !emojiShowing,
              child: SizedBox(
                height: 100,
                child: EmojiPicker(
                    textEditingController: _controller,
                    onEmojiSelected: (Category category, Emoji emoji) {
                      _onEmojiSelected(emoji);
                    },
                    onBackspacePressed: _onBackspacePressed,
                    config: const Config(
                        columns: 7,
                        // Issue: https://github.com/flutter/flutter/issues/28894
                        verticalSpacing: 0,
                        horizontalSpacing: 0,
                        gridPadding: EdgeInsets.zero,
                        initCategory: Category.RECENT,
                        bgColor: Color(0xFFF2F2F2),
                        indicatorColor: Colors.blue,
                        iconColor: Colors.grey,
                        iconColorSelected: Colors.blue,
                        progressIndicatorColor: Colors.blue,
                        backspaceColor: Colors.blue,
                        skinToneDialogBgColor: Colors.white,
                        skinToneIndicatorColor: Colors.grey,
                        enableSkinTones: true,
                        showRecentsTab: true,
                        recentsLimit: 28,
                        replaceEmojiOnLimitExceed: false,
                        noRecents: Text(
                          'No Recents',
                          style: TextStyle(
                              fontSize: 20, color: Colors.black26),
                          textAlign: TextAlign.center,
                        ),
                        tabIndicatorAnimDuration: kTabScrollDuration,
                        categoryIcons: CategoryIcons(),
                        buttonMode: ButtonMode.MATERIAL)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
