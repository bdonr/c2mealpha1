import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LongTextField extends StatefulWidget {
  const LongTextField(this.titleController, this.maxLines, {Key? key})
      : super(key: key);
  final TextEditingController titleController;
  final int maxLines;

  @override
  State<LongTextField> createState() => _LongTextFieldState();
}

class _LongTextFieldState extends State<LongTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: widget.maxLines * 24.0,
        child: TextFormField(
            maxLines: widget.maxLines,
            controller: widget.titleController,
            textInputAction: TextInputAction.done,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onFieldSubmitted: (value) {
              print(value);
            },
            decoration: InputDecoration(
              hintText: "Enter a message",
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            )));
  }
}
