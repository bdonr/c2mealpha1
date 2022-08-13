import 'dart:ffi';

import 'package:c2mealpha1/bloc/loggedin/LoginCubit.dart';
import 'package:c2mealpha1/bloc/visit/SocialsCubit.dart';
import 'package:c2mealpha1/classes/Profile.dart';
import 'package:c2mealpha1/classes/SocialMedia.dart';
import 'package:c2mealpha1/repository/FlutterUserRepository.dart';
import 'package:c2mealpha1/states/SearchState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../bloc/loggedin/SocialChangeBloc.dart';
import '../bloc/visit/VisitCubit.dart';
import '../classes/Social.dart';
import 'TopView.dart';

class EditView extends StatefulWidget {
  const EditView({Key? key}) : super(key: key);

  @override
  State<EditView> createState() => _EditViewState();
}

class _EditViewState extends State<EditView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, Profile?>(builder: (context, profile) {
      if (profile != null) {
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () async => {
                        Navigator.of(context).pop(context),
                      }),
              actions: [
                MenuButton(() {
                  Navigator.pushNamed(context, '/home');
                  BlocProvider.of<VisitCubit>(context).findProfile(profile.id);
                }, FaIcon(FontAwesomeIcons.house)),
                MenuButton(() {
                  Navigator.pushNamed(context, '/edit');
                  BlocProvider.of<VisitCubit>(context).findProfile(profile.id);
                }, FaIcon(FontAwesomeIcons.gear)),
                MenuButton(() {
                  Navigator.pushNamed(context, '/messages');
                  BlocProvider.of<VisitCubit>(context).findProfile(profile.id);
                }, FaIcon(FontAwesomeIcons.message)),
                MenuButton(() {
                  Navigator.pushNamed(context, '/notifications');
                  BlocProvider.of<VisitCubit>(context).findProfile(profile.id);
                }, FaIcon(FontAwesomeIcons.bell)),
                MenuButton(() {
                  Navigator.pushNamed(context, '/search');
                  BlocProvider.of<VisitCubit>(context).findProfile(profile.id);
                }, FaIcon(FontAwesomeIcons.magnifyingGlass)),
              ],
            ),
            SliverToBoxAdapter(
                child: Material(
                    child: Container(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ListView(
                  children: [
                    Text(
                      "Settings",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text("username:"),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(profile.name),
                              ),
                              const Align(
                                alignment: Alignment.centerLeft,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Icon(Icons.edit),
                              ),
                            ]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text("about me:"),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(profile.about),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Icon(Icons.edit),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ))),
            SliverToBoxAdapter(
              child: Material(child: BlocBuilder<SocialsCubit, List<Social>>(
                  builder: (context, social) {
                return Container(
                    height: 500, child: EditItems(social, profile.id));
              })),
            ),
          ],
        );
      }
      return CircularProgressIndicator();
    });
  }
}

class EditItems extends StatefulWidget {
  EditItems(this.list, this.profileID, {Key? key}) : super(key: key);
  final List<Social> list;
  final String profileID;

  @override
  State<EditItems> createState() => _EditItemsState();
}

class _EditItemsState extends State<EditItems> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        //TWITCH,YOUTUBE,XING,FACEBOOK,TWITTER,INSTAGRAM,SNAPCHAT,PINTEREST,ONLYFANS,STEAM,BLIZZARD,TIKTOK,NOTHING
        padding: const EdgeInsets.only(top: 8.0),
        child: ListView.builder(
            itemCount: SocialMedia.values.length,
            itemBuilder: (context, index) {
              return EditItem(
                  Social(SocialMedia.values[index],
                      _asdad(widget.list, SocialMedia.values[index])),
                  widget.profileID);
            }));
  }

  String _asdad(List<Social> listSo, SocialMedia y) {
    String x = "";
    for (Social b in listSo) {
      if (b.socialMedia.name == y.name) {
        x = b.link;
      }
    }
    return x;
  }
}

class EditItem extends StatefulWidget {
  EditItem(this.description, this.ProfileID, {Key? key}) : super(key: key);
  final Social description;
  final String ProfileID;
  final flutterRepo = FlutterRepository();

  @override
  State<EditItem> createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  bool show = false;

  @override
  Widget build(BuildContext context) {
    final myController = TextEditingController();
    return BlocBuilder<SocialChangeBloc, SocialEditState>(
        builder: (context, state) {
      if (state is SocialInitState) {
        myController.text = widget.description.link;
      }
      if (state is SocialUpdateState) {
        if (state.social.socialMedia == widget.description.socialMedia) {
          myController.text = state.social.link;
        }
        else{
          myController.text = widget.description.link;
        }
      }
      return Padding(
          padding: EdgeInsets.only(top: 25),
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(widget.description.socialMedia.name.toLowerCase()),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Text(myController.text),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          show = !show;
                        });
                      },
                      icon: FaIcon(FontAwesomeIcons.chevronDown))),
            ]),
            show
                ? AnimatedContainer(
                    key: UniqueKey(),
                    height: 100,
                    duration: const Duration(seconds: 2),
                    curve: Curves.fastOutSlowIn,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 10,
                            offset: const Offset(
                                1, 3), // changes position of shadow
                          )
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextFormField(
                              controller: myController,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                              )),
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () async {
                                  setState(() {
                                    show = !show;
                                  });
                                  Social k = Social(
                                      widget.description.socialMedia,
                                      myController.text);
                                  BlocProvider.of<SocialChangeBloc>(context)
                                      .add(SocialUpdateEvent(
                                          k, widget.ProfileID));
                                  ;
                                },
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.green,
                                )),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    show = !show;
                                  });
                                },
                                icon: const Icon(
                                  Icons.remove,
                                  color: Colors.orange,
                                )),
                          ],
                        )
                      ],
                    ),
                  )
                : Container()
          ]));
    });
  }
}
