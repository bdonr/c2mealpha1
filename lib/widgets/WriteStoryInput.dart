import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../repository/FlutterUserRepository.dart';
import '../repository/MessageRepository.dart';

class WriteStoryInput extends StatefulWidget {
  const WriteStoryInput(this.titleController,this.hinText,this.maxLenght,{Key? key}) : super(key: key);

  @override
  State<WriteStoryInput> createState() => _WriteStoryInputState();

  final TextEditingController titleController;
  final String hinText;
  final int maxLenght;

}

class _WriteStoryInputState extends State<WriteStoryInput> {
  final MessageRepository messageRepository = MessageRepository();
  final FlutterRepository repository = FlutterRepository();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
                maxLength: widget.maxLenght,
                controller: widget.titleController,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return widget.hinText;
                  }
                  return null;
                },
                onFieldSubmitted: (value) {
                  setState(() {

                  });
                }),
          ),
        ],
      ),
    );
  }
}
