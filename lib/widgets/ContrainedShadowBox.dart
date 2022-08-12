import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/loggedin/LoggedInPosition.dart';
import '../classes/Profile.dart';

class ContrainedShadowBox extends StatefulWidget {
  const ContrainedShadowBox(
      this.child, this.shadowColor, this.boxColor, this.height, this.width,
      {Key? key})
      : super(key: key);
  final Widget child;
  final Color shadowColor;
  final Color boxColor;
  final double height;
  final double width;

  @override
  State<ContrainedShadowBox> createState() => _ContrainedShadowBoxState();
}

class _ContrainedShadowBoxState extends State<ContrainedShadowBox> {
  double high = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoggedInPosition, List<Profile?>>(
        builder: (context, pos) {
      print(pos);
      pos.removeWhere((element) => element==null);
      print(pos);
      if (pos.isEmpty) {
          return AnimatedContainer(
            height: 0,
            duration: const Duration(seconds: 2),
            curve: Curves.fastOutSlowIn,
            decoration: BoxDecoration(
                color: widget.boxColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: widget.shadowColor.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(1, 3), // changes position of shadow
                  )
                ]),
            child: widget.child,
          );
        }
        if (pos.length >=1 && pos.length < 4) {
          return AnimatedContainer(
            height: 150,
            duration: const Duration(seconds: 2),
            curve: Curves.fastOutSlowIn,
            decoration: BoxDecoration(
                color: widget.boxColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: widget.shadowColor.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(1, 3), // changes position of shadow
                  )
                ]),
            child: widget.child,
          );
        }
        if (pos.length >=4 && pos.length < 8) {
          return AnimatedContainer(
            height: 300,
            duration: const Duration(seconds: 2),
            curve: Curves.fastOutSlowIn,
            decoration: BoxDecoration(
                color: widget.boxColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: widget.shadowColor.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(1, 3), // changes position of shadow
                  )
                ]),
            child: widget.child,
          );
        }

      return AnimatedContainer(
        height: 0,
        duration: const Duration(seconds: 2),
        curve: Curves.fastOutSlowIn,
        decoration: BoxDecoration(
            color: widget.boxColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: widget.shadowColor.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(1, 3), // changes position of shadow
              )
            ]),
        child: widget.child,
      );
    });

    /**DecoratedBox(
        decoration: BoxDecoration(
        color: widget.boxColor,
        borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(10)),
        boxShadow: [
        BoxShadow(
        color: widget.shadowColor.withOpacity(0.5),
        spreadRadius: 2,
        blurRadius: 10,
        offset: const Offset(1, 3), // changes position of shadow
        ),
        ],
        ),*/
  }
}
