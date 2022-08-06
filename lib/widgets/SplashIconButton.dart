import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashIconButton extends StatefulWidget {
  const SplashIconButton(this.icon,this.color,{Key? key}) : super(key: key);
  final IconData icon;
  final Color color;
  @override
  State<SplashIconButton> createState() => _SplashIconButtonState();
}

class _SplashIconButtonState extends State<SplashIconButton> {
  @override
  Widget build(BuildContext context) {
    return  Material(
        borderRadius: BorderRadius.circular(4),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(4),
          radius: 25,
          onTap: ()=>{},
          splashColor: Colors.grey,
          highlightColor: Colors.grey,
          child: Container(
            width: 34,
            height: 34,
            child: Icon(
              widget.icon,
              color: widget.color,
              size: 24,
            ),
          ),
        ));
  }
}
