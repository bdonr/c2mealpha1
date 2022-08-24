import 'dart:io';

import 'package:c2mealpha1/repository/FlutterUserRepository.dart';
import 'package:c2mealpha1/repository/MessageRepository.dart';
import 'package:c2mealpha1/widgets/ImagePickV.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WriteCommentInput extends StatefulWidget {
  const WriteCommentInput(this.reference,this.titleController, this.hinText, this.maxLenght,
      {Key? key})
      : super(key: key);
  final TextEditingController titleController;
  final String hinText;
  final int maxLenght;
  final DocumentReference reference;



  @override
  State<WriteCommentInput> createState() => _WriteCommentInputState();
}

class _WriteCommentInputState extends State<WriteCommentInput> {
  File? selectedFile = null;

  call(File x){
    setState((){
      selectedFile = x;
    });
  }

  final MessageRepository messageRepository = MessageRepository();
  final FlutterRepository repository = FlutterRepository();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Expanded(child: ImagePickV(call)),
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
                    messageRepository.addComment(widget.reference, widget.titleController.text,selectedFile);
                  });
                }),
          ),
        ],
      ),
    );
  }
}
