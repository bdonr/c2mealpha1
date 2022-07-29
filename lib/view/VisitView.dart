import 'package:flutter/cupertino.dart';

class VisitView extends StatefulWidget {
  const VisitView({Key? key}) : super(key: key);

  @override
  State<VisitView> createState() => _VisitViewState();
}

class _VisitViewState extends State<VisitView> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text("visit"),);
  }
}
