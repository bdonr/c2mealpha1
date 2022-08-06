import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShadowBox extends StatefulWidget {
  const ShadowBox(this.child,this.shadowColor,this.boxColor,this.height,this.width,{Key? key}) : super(key: key);
  final Widget child;
  final Color shadowColor;
  final Color boxColor;
  final double height;
  final double width;
  @override
  State<ShadowBox> createState() => _ShadowBoxState();
}

class _ShadowBoxState extends State<ShadowBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
        ),
        height: widget.height,
        width: widget.width,
        child: widget.child);
  }
}
