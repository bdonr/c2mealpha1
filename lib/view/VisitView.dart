import 'dart:io';

import 'package:c2mealpha1/bloc/loggedin/LoginCubit.dart';
import 'package:c2mealpha1/bloc/visit/VisitCubit.dart';
import 'package:c2mealpha1/widgets/PrivatView.dart';
import 'package:c2mealpha1/widgets/PublicView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../classes/Profile.dart';

class VisitView extends StatefulWidget {
  const VisitView({Key? key}) : super(key: key);

  @override
  State<VisitView> createState() => _VisitViewState();
}

class _VisitViewState extends State<VisitView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, Profile?>(builder: (context, profile) {
      return BlocBuilder<VisitCubit, Profile?>(builder: (context, visit) {
        if(visit!= null && profile!=null && visit.id==profile.id){
          return PrivatView();
        }
        else{
          if(visit!=null && profile!=null) {
            return PublicView();
          }
        }
        return CircularProgressIndicator();
      });
    });
  }
}
