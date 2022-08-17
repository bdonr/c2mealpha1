import 'package:c2mealpha1/bloc/loggedin/LoginCubit.dart';
import 'package:c2mealpha1/widgets/TopView.dart';
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
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, Profile?>(builder: (context, login) {
      if (login != null) {
        return Material(
          child: CustomScrollView(
            slivers: [
              TopView(login),
              SliverToBoxAdapter(
                child: Container(
                  child: Text("asd"),
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
