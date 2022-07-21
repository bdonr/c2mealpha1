import 'package:flutter/cupertino.dart';

import '../widgets/TopView.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      TopView(),
      /* return
                */
    ]);
  }
}
