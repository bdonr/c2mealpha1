import 'package:c2mealpha1/repository/PersonRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../classes/Profile.dart';

class FollowsCubit extends Cubit<List<Profile?>>{

  FollowsCubit():super([]);

  void getFollows() async{
    PersonRepository.followsProfile(1, 1000000).listen((event) {
      emit (event.map((e) => e).toList());
    });
  }

}