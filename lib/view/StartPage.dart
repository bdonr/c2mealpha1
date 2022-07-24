import 'package:c2mealpha1/bloc/LoginCubit.dart';
import 'package:c2mealpha1/bloc/MainImageCubit.dart';
import 'package:c2mealpha1/bloc/NavCubit.dart';
import 'package:c2mealpha1/bloc/PokemonBLoc.dart';
import 'package:c2mealpha1/bloc/PokemonDetailsCubit.dart';
import 'package:c2mealpha1/classes/MainImage.dart';
import 'package:c2mealpha1/states/PokemonState.dart';
import 'package:c2mealpha1/states/ProfileState.dart';
import 'package:c2mealpha1/widgets/AvatarView.dart';
import 'package:c2mealpha1/widgets/FollowUser.dart';
import 'package:c2mealpha1/widgets/NearUser.dart';
import 'package:c2mealpha1/widgets/TopView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../bloc/FollowerCubit.dart';
import '../bloc/ProfilCubit.dart';
import '../classes/Profile.dart';
import '../events/PageEvents.dart';
import '../events/PokemonEvent.dart';
import '../helper/formater.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 400,
          backgroundColor: Color(0xFFFFFFFF),
          systemOverlayStyle: SystemUiOverlayStyle.light,
          centerTitle: false,
          floating: true,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () async => {
                    Navigator.of(context).pop(context),
                    BlocProvider.of<ProfilCubit>(context)
                        .getProfile("50myTvoVDnY1TIkhiFJh")
                  }),
          actions: [
            MenuButton(() {
              Navigator.pushNamed(context, '/home');
            }, FaIcon(FontAwesomeIcons.house)),
            MenuButton(() {
              Navigator.pushNamed(context, '/messages');
            }, FaIcon(FontAwesomeIcons.message)),
            MenuButton(() {
              Navigator.pushNamed(context, '/notifications');
            }, FaIcon(FontAwesomeIcons.bell)),
            MenuButton(() {
              Navigator.pushNamed(context, '/search');
            }, FaIcon(FontAwesomeIcons.magnifyingGlass)),
          ],
          flexibleSpace:
              BlocBuilder<LoginCubit, Profile?>(builder: (context, details) {
            if (details != null) {
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
                              Formater.func(details.followerCount),
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.bold),
                            )),
                        Padding(
                            padding: EdgeInsets.only(left: 70, bottom: 120),
                            child: Text(
                              "Follows${Formater.func(details.follows)}",
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
          }),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 100,
            child: Scaffold(
              body: Row(
                children: [
                  Expanded(
                    flex: 8,
                    child: Container(
                      height: 100,
                      color: Colors.white,
                      child: BlocBuilder<LoginCubit, Profile?>(
                          builder: (context, details) {
                        if (details != null) {
                          print(details.toString());
                          return Text(details.name);
                        }
                        return CircularProgressIndicator();
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class ProfileImageHeader extends StatelessWidget {
  const ProfileImageHeader(
    this.imageurl, {
    Key? key,
  }) : super(key: key);
  final imageurl;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topCenter,
        child: Container(
          height: 250,
          width: 700,
          child: ClipRRect(
            child: FadeInImage.assetNetwork(
              placeholder: imageurl,
              image: imageurl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ));
  }
}
