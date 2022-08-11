import 'package:c2mealpha1/widgets/BoxAvatarView.dart';
import 'package:flutter/cupertino.dart';

import '../classes/Profile.dart';
import 'UserListView.dart';

class UserGridView extends StatefulWidget {
  const UserGridView({
    Key? key,
    required this.list,
  }) : super(key: key);
  final List<Profile?> list;

  @override
  State<UserGridView> createState() => _UserGridViewState();
}

class _UserGridViewState extends State<UserGridView> {
  @override
  Widget build(BuildContext context) {
    if(widget.list.isNotEmpty){
      return GridView.builder(
          shrinkWrap: true,
          itemCount: widget.list.length,
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4),
          itemBuilder: (BuildContext context, int index) {
            return widget.list[index]==null?Container():BoxAvatarView(40, widget.list[index]!);

          });
    }
    return Container();

  }
}