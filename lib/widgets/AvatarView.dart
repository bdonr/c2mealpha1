import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../bloc/ProfilCubit.dart';
import '../classes/Profile.dart';

class AvatarView extends StatefulWidget {
  const AvatarView(this.avatarsize,this.url,
      {super.key});

  final String url;
  final double avatarsize;

  @override
  _AvatarViewState createState() {
    return _AvatarViewState();
  }
}

class _AvatarViewState extends State<AvatarView> {
  String func(double i) {
    if (i > 999 && i < 999999) {
      return roundDouble(i / 1000, 2).toString() + "k";
    }
    if (i > 1000000 && i < 999999999) {
      return roundDouble(i / 1000000, 2).toString() + "M";
    }
    if (i > 1000000000) {
      return roundDouble(i / 1000000000, 2).toString() + "B";
    }
    return i.toInt().toString();
  }

  double roundDouble(double value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: CircleAvatar(
              radius: widget.avatarsize,
              backgroundColor: Colors.transparent,
              backgroundImage: widget.url!=null ?NetworkImage(widget.url):null,
              child: Material(
                shape: CircleBorder(),
                clipBehavior: Clip.hardEdge,
                color: Colors.transparent,
                child: InkWell(onTap: (){
                    Navigator.pushNamed(context, '/profileview');
                    BlocProvider.of<ProfilCubit>(context).getProfile(widget.url);
                },),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40, left: 6),
            child: Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.users,
                  color: Colors.white,
                  size: 6,
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}