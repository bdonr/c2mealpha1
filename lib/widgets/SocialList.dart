import 'package:c2mealpha1/classes/Social.dart';
import 'package:c2mealpha1/widgets/ShadowBox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../classes/Profile.dart';
import '../config/SocialConfig.dart';

class SocialList extends StatefulWidget {
  const SocialList(this.list, {Key? key}) : super(key: key);
  final List<Social> list;

  @override
  State<SocialList> createState() => _SocialListState();
}

class _SocialListState extends State<SocialList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 3.0),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: widget.list.length,
          itemBuilder: (context, index) {
            List<String> x = widget.list[index].socialMedia
                .toString()
                .toLowerCase()
                .split(".");
            return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: ShadowBox(
                        SocialConfig.configIcon(widget.list[index]),
                        SocialConfig.configColor(widget.list[index]),
                        SocialConfig.configColor(widget.list[index]),
                        100,100)));
          }),
    );
  }
}
