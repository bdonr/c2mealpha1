import 'package:c2mealpha1/bloc/loggedin/LoginCubit.dart';
import 'package:c2mealpha1/widgets/TextIconInput.dart';
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
  @override
  late FocusNode focusNode = FocusNode();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  late TextEditingController currentEditor;
  bool emojiShowing = false;

  late String title;
  late String description;
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, Profile?>(builder: (context, login) {
      if (login != null) {
        return Material(
            child: CustomScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                slivers: [
              TopView(login),
              SliverToBoxAdapter(
                  child: GestureDetector(
                      //onTap: () => FocusScope.of(context).unfocus(),
                      /// > flutter 2.0
                      onTap: () =>
                          FocusManager.instance.primaryFocus?.unfocus(),
                      child: ListView(
                          padding: const EdgeInsets.all(14.0),
                          shrinkWrap: true,
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          children: [
                            Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 21),
                                child: TextFormField(
                                  controller: titleController,
                                    textInputAction: TextInputAction.done,
                                    onFieldSubmitted: (value){
                                     print(value);
                                    }
                                )
                            ),
                            Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 21),
                                child: TextFormField(
                                  controller: descriptionController,
                                    textInputAction: TextInputAction.done,
                                    onFieldSubmitted: (value){
                                      print(value);
                                    }
                                )
                            ),

                          ])))
            ]));
      }
      return CircularProgressIndicator();
    });
  }
}
