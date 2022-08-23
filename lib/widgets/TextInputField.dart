import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextInputField extends StatefulWidget {
  const TextInputField(this.titleController, this.hinText, this.maxLenght,
      {Key? key})
      : super(key: key);
  final TextEditingController titleController;
  final String hinText;
  final int maxLenght;

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  late int allowed = widget.maxLenght;
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
                    allowed = widget.titleController.text.length -
                        widget.maxLenght;
                  });
                }),
          ),
        ],
      ),
    );
  }
}
