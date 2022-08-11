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
  var textValue = 'any';



  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Expanded(
        child: Transform.scale(
            scale: 2,
            child: Switch(
              onChanged: (value) => {
                if (isSwitched == false)
                  {
                    setState(() {
                      BlocProvider.of<SocialSearchCubit>(context).setExact();
                      isSwitched = true;
                      textValue = 'all';
                    })
                  }
                else
                  {
                    setState(() {
                      BlocProvider.of<SocialSearchCubit>(context).setExact();
                      isSwitched = !isSwitched;
                      textValue = 'any';
                    })
                  }
              },
              value: isSwitched,
              activeColor: Colors.blue,
              activeTrackColor: Colors.yellow,
              inactiveThumbColor: Colors.redAccent,
              inactiveTrackColor: Colors.orange,
            )),
      ),
      Text(
        '$textValue',
        style: TextStyle(fontSize: 20),
      )
    ]);
  }
}
