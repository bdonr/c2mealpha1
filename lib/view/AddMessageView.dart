import 'package:c2mealpha1/bloc/loggedin/LoginCubit.dart';
import 'package:c2mealpha1/widgets/TextIconInput.dart';
import 'package:c2mealpha1/widgets/TextInputField.dart';
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
  final _formKey = GlobalKey<FormState>();
  final TextEditingController textController1 = TextEditingController();
  final TextEditingController textController2 = TextEditingController();
  final TextEditingController textController3 = TextEditingController();
  final TextEditingController textController4 = TextEditingController();
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextInputField(textController1),
                      TextInputField(textController2),
                      ElevatedButton(
                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            print(textController1.text+"   "+textController2.text);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                          }
                        },
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                ),
              )
            ]));
      }
      return CircularProgressIndicator();
    });
  }
}