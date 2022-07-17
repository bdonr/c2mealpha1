import 'package:c2mealpha1/events/ProfileEvent.dart';
import 'package:c2mealpha1/states/ProfileState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../bloc/ProfilCubit.dart';

class TopView extends StatefulWidget {
  const TopView({Key? key}) : super(key: key);

  @override
  State<TopView> createState() => _TopViewState();
}

class _TopViewState extends State<TopView> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        expandedHeight: 400,
        backgroundColor: Color(0xFFFFFFFF),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        centerTitle: false,
        floating: true,
        actions: [
          IconButton(
            onPressed: () => {},
            icon: const FaIcon(FontAwesomeIcons.house),
            color: Color(0xD2D0D0CE),
            iconSize: 20,
          ),
          IconButton(
            onPressed: () => {},
            icon: const FaIcon(FontAwesomeIcons.message),
            color: Color(0xD2D0D0CE),
            iconSize: 20,
          ),
          IconButton(
            onPressed: () => {},
            icon: const FaIcon(FontAwesomeIcons.bell),
            color: Color(0xD2D0D0CE),
            iconSize: 20,
          ),
          IconButton(
            onPressed: () => {},
            icon: const FaIcon(FontAwesomeIcons.magnifyingGlass),
            color: Color(0xD2D0D0CE),
            iconSize: 20,
          ),
        ],
        flexibleSpace: Container(
          width: 100,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(27.0)),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 250,
                  width: 370,
                  child: BlocBuilder<ProfilCubit, ProfileState>(
                      builder: (context, state) {
                    if (state is ProfileLoadedState) {
                      return ClipOval(
                        child: FadeInImage.assetNetwork(
                          placeholder: state.profile.url,
                          image: state.profile.url,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 200.0),
                child: Container(
                  child: Row(
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
                          "1.9M",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 70, bottom: 120),
                        child: Text(
                          "Follows 512k",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white.withOpacity(0.7),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26.withOpacity(0.5),
                        spreadRadius: -10,
                        blurRadius: 9,
                        offset: Offset(0, -5), // changes position of shadow
                      ),
                    ],
                  ),
                  height: 200,
                  width: double.infinity,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 175, left: 10),
                child: TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.deepPurple)),
                    onPressed: () => {},
                    child: const Text(
                      "follow",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 270),
                child: Text(
                  "My Socials",
                  style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 300.0),
                child: Text("asdasd"),
              )
            ],
          ),
        ));
  }
}
