import 'package:c2mealpha1/bloc/loggedin/LoginCubit.dart';
import 'package:c2mealpha1/widgets/TopView.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../classes/Profile.dart';

class AddMessageView extends StatefulWidget {
  const AddMessageView({Key? key}) : super(key: key);

  @override
  State<AddMessageView> createState() => _AddMessageViewState();
}

class _AddMessageViewState extends State<AddMessageView> {
  final TextEditingController _controller = TextEditingController();
  bool emojiShowing = false;

  @override
  _onEmojiSelected(Emoji emoji) {
    print('_onEmojiSelected: ${emoji.emoji}');
  }

  _onBackspacePressed() {
    print('_onBackspacePressed');
  }

  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, Profile?>(builder: (context, login) {
      if (login != null) {
        return Material(
          child: CustomScrollView(
            slivers: [
              TopView(login),
              SliverToBoxAdapter(
                child: Container(
                  height: 500,
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                            height: 66.0,
                            color: Colors.blue,
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
                                      color: Colors.white,
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
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                        )),
                                  ),
                                ),
                                Material(
                                  color: Colors.transparent,
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
                            )),
                      ),
                      Offstage(
                        offstage: !emojiShowing,
                        child: SizedBox(
                          height: 250,
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
              )
            ],
          ),
        );
      }
      return CircularProgressIndicator();
    });
    ;
  }
}
