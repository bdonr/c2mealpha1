import 'package:c2mealpha1/repository/FlutterUserRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../classes/Profile.dart';
import 'SplashIconButton.dart';

class TopViewMenu extends StatefulWidget {
  const TopViewMenu(this.profile,this.visiter, {Key? key}) : super(key: key);
  final Profile profile;
  final Profile visiter;

  @override
  State<TopViewMenu> createState() => _TopViewMenuState();
}

class _TopViewMenuState extends State<TopViewMenu> {
  FlutterRepository repository = FlutterRepository();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 120),
      child: Column(
        children: [
          Row(
            children: [
              Padding(padding: EdgeInsets.only(left: 10)),
              SplashIconButton(FontAwesomeIcons.solidHeart,Colors.red),
              Padding(padding: EdgeInsets.only(left: 3)),
              Text(
                widget.profile.followerCount.toString(),
                style: TextStyle(color: Colors.grey),
              ),
              Padding(padding: EdgeInsets.only(left: 20)),
              SplashIconButton(FontAwesomeIcons.personWalking,Colors.blue),
              Padding(padding: EdgeInsets.only(left: 3)),
              Text(
                widget.profile.follows.toString(),
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
          Row(
            children: [
              TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.deepPurple),
                    overlayColor: MaterialStateProperty.all(Colors.red),
                  ),
                  onPressed: () {
                    repository.addFriends(widget.profile, widget.visiter);
                  },
                  child: const Text(
                    'Follow',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
