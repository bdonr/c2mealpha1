import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextInputField extends StatefulWidget {
  const TextInputField(this.titleController,{Key? key}) : super(key: key);
  final TextEditingController titleController;
  @override
  State<TextInputField> createState() => _TextInputFieldState();
}


class _TextInputFieldState extends State<TextInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(child:
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21),
              child: TextFormField(
                  controller: widget.titleController,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onFieldSubmitted: (value){
                    print(value);
                  }
              )
          ),

    );
  }
}
