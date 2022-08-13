import 'package:c2mealpha1/bloc/loggedin/LoginCubit.dart';
import 'package:c2mealpha1/bloc/visit/SocialsCubit.dart';
import 'package:c2mealpha1/classes/Profile.dart';
import 'package:c2mealpha1/classes/SocialMedia.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
                  onPressed: () async =>
                  {
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
                              style: TextStyle(
                                  color: Colors.black, fontSize: 20),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text("username:"),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0),
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
                    return Container(height: 500, child: EditItems(social));
                  })),
            ),
          ],
        );
      }
      return CircularProgressIndicator();
    });
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

class EditItems extends StatefulWidget {
  EditItems(this.list, {Key? key}) : super(key: key);
  final List<Social> list;


  @override
  State<EditItems> createState() => _EditItemsState();
}

class _EditItemsState extends State<EditItems> {
  late bool show = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      //TWITCH,YOUTUBE,XING,FACEBOOK,TWITTER,INSTAGRAM,SNAPCHAT,PINTEREST,ONLYFANS,STEAM,BLIZZARD,TIKTOK,NOTHING
        padding: const EdgeInsets.only(top: 8.0),
        child: ListView.builder(
            itemCount: SocialMedia.values.length,
            itemBuilder: (context, index) {
              return EditItem(SocialMedia.values[index].name.toLowerCase(), _asdad(widget.list,SocialMedia.values[index]));
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
  const EditItem(this.description,this.value,{Key? key}) : super(key: key);
  final String description;
  final String value;

  @override
  State<EditItem> createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  bool show = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 25),
        child: Column(children: [
          Row(
              children: [
                Text(widget.description),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Text(
                      widget.value),
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

          show ? AnimatedContainer(
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
                      initialValue: widget.value,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                      )
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.add,
                          color: Colors.green,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.remove,
                          color: Colors.orange,
                        )),
                  ],
                )
              ],
            ),
          ) : Container()
        ]));
  }
}

