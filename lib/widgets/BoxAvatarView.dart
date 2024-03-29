import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../bloc/visit/DoIFollowCubit.dart';
import '../bloc/visit/SocialsCubit.dart';
import '../bloc/visit/VisitCubit.dart';
import '../classes/Profile.dart';

class BoxAvatarView extends StatefulWidget {
  const BoxAvatarView(this.avatarsize, this.profile, {super.key});

  final Profile profile;
  final double avatarsize;

  @override
  _BoxAvatarViewState createState() {
    return _BoxAvatarViewState();
  }
}

class _BoxAvatarViewState extends State<BoxAvatarView> {
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
        child: Stack(children: [
          Positioned.fill(
              bottom: 0.0,
              child: GridTile(
                child: Material(
                  child: Image.network(
                    widget.profile.profilImageurl,
                    fit: BoxFit.cover,
                  ),
                ),
                footer: Container(
                  height: 40,
                  child: GridTileBar(
                    backgroundColor: Colors.black12,
                    title: Text(
                      widget.profile.name,
                      style: const TextStyle(
                          fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(widget.profile.followerCount.toString()+"follower",style: const TextStyle(
                        fontSize: 10, fontWeight: FontWeight.bold),),

                  ),
                ),
              )),
          Positioned.fill(
              child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () async{
                    BlocProvider.of<VisitCubit>(context).findProfile(widget.profile.id);
                    BlocProvider.of<SocialsCubit>(context).getSocials(widget.profile.id);
                    BlocProvider.of<DoIFollowCubit>(context).areWeFollower(widget.profile);
                    Navigator.pushNamed(context, '/profileview');
                    },
                  ))),
        ]));
  }
}
