import 'package:c2mealpha1/bloc/LoginCubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../bloc/MainImageCubit.dart';
import '../classes/Profile.dart';
import '../helper/formater.dart';
import '../view/StartPage.dart';

class LoggedInMenu extends StatelessWidget {
  const LoggedInMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit,Profile?>(
      builder: (context,profile){
        if(profile!=null) {
          return BlocBuilder<LoggedInImageCubit, ProfileImageHeader?>(
              builder: (context, image) {
                if (image != null) {
                  return Column(children: [
                    Container(child: image),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 65, bottom: 120),
                          child: FaIcon(
                            FontAwesomeIcons.solidHeart,
                            color: Colors.red,
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 0, bottom: 120),
                            child: Text(
                              Formater.func(profile.followerCount),
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.bold),
                            )),
                        Padding(
                            padding: EdgeInsets.only(left: 70, bottom: 120),
                            child: Text(
                              "Follows${Formater.func(profile.follows)}",
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                  ]);
                }
                return CircularProgressIndicator();
              });
        }
        return CircularProgressIndicator();
  });
  }
}