import 'package:c2mealpha1/bloc/loggedin/SocialSearchCubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomSwitch extends StatefulWidget {
  const CustomSwitch({Key? key}) : super(key: key);

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  @override
  bool isSwitched = false;
  var textValue = '';



  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Transform.scale(
          scale: 2,
          child: Switch(
            onChanged: (value) => {
              if (isSwitched == false)
                {
                  setState(() {
                    BlocProvider.of<SocialSearchCubit>(context).setExact();
                    isSwitched = true;
                    textValue = 'with all of this socials';
                  })
                }
              else
                {
                  setState(() {
                    BlocProvider.of<SocialSearchCubit>(context).setExact();
                    isSwitched = !isSwitched;
                    textValue = 'with any of this socials';
                  })
                }
            },
            value: isSwitched,
            activeColor: Colors.blue,
            activeTrackColor: Colors.yellow,
            inactiveThumbColor: Colors.redAccent,
            inactiveTrackColor: Colors.orange,
          )),
      Text(
        '$textValue',
        style: TextStyle(fontSize: 20),
      )
    ]);
  }
}
