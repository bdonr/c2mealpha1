import 'package:c2mealpha1/bloc/NavCubit.dart';
import 'package:c2mealpha1/config/SocialConfig.dart';
import 'package:c2mealpha1/events/PageEvents.dart';
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
          MenuButton((){BlocProvider.of<NavBloc>(context)..add(StartPage());},FaIcon(FontAwesomeIcons.house)),
          MenuButton((){BlocProvider.of<NavBloc>(context)..add(MessagePage());},FaIcon(FontAwesomeIcons.message)),
          MenuButton((){BlocProvider.of<NavBloc>(context)..add(NotificationPage());},FaIcon(FontAwesomeIcons.bell)),
          MenuButton((){BlocProvider.of<NavBloc>(context)..add(SearchPage());},FaIcon(FontAwesomeIcons.magnifyingGlass)),
        ],
        flexibleSpace: Container(
          width: 100,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(27.0)),
          ),
          child: Stack(
            children: [
              ProfileImageHeader(),
              Padding(
                padding: const EdgeInsets.only(top: 200.0),
                child: Container(
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
                  child: Row(
                    children: const [
                      Padding(
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
              const Padding(
                padding: EdgeInsets.only(top: 270),
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
                child: BlocBuilder<ProfilCubit, ProfileState>(
                    builder: (context, state) {
                  if (state is ProfileLoadedState) {
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.profile.socials.length,
                        itemBuilder: (context, index) {
                          List<String> x = state
                              .profile.socials[index].socialMedia
                              .toString()
                              .toLowerCase()
                              .split(".");
                          String j = x[1];

                          return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(25.0),
                                child: Container(
                                  color: SocialConfig.configColor(state.profile.socials[index]),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 34,top: 30),
                                    child: SocialConfig.configIcon(state.profile.socials[index]),
                                  ),
                                  width: 90,
                                  height: 100,
                                ),
                              )

                          );
                        });
                  }
                  return CircularProgressIndicator();
                }),
              )
            ],
          ),
        ));
  }
}

class MenuButton extends StatelessWidget {
  const MenuButton(this.callback,this.icon,{
    Key? key,
  }) : super(key: key);
  final VoidCallback callback;
  final FaIcon icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: callback,
      icon: icon,
      color: Color(0xD2D0D0CE),
      iconSize: 20,
    );
  }
}

class ProfileImageHeader extends StatelessWidget {
  const ProfileImageHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 250,
        width: 700,
        child:
            BlocBuilder<ProfilCubit, ProfileState>(builder: (context, state) {
          if (state is ProfileLoadedState) {
            return ClipRRect(
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
    );
  }
}
