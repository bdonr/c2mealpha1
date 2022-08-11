import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 1.0,
        maxHeight: 300,
      ),
      child: DecoratedBox(
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
          child: widget.child),
    );
  }
}
