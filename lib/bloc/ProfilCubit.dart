import 'package:c2mealpha1/classes/Social.dart';
import 'package:c2mealpha1/classes/SocialMedia.dart';
import 'package:c2mealpha1/events/ProfileEvent.dart';
import 'package:c2mealpha1/repository/PersonRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../classes/Profile.dart';
import '../states/ProfileState.dart';

class ProfilCubit extends Cubit<Profile?> {


  final PersonRepository personRepository= PersonRepository();
  ProfilCubit() : super(null) {
    personRepository.users[0].socials = [
      new Social(SocialMedia.TWITTER, "uwuwuwwuwu"),
      new Social(SocialMedia.INSTAGRAM, "uwuwuwwuwu"),
      new Social(SocialMedia.FACEBOOK, "uwuwuwwuwu"),
      new Social(SocialMedia.SNAPSHAT, "uwuwuwwuwu"),
      new Social(SocialMedia.XING, "uwuwuwwuwu"),
    ];
  }

  void getProfile(int id) async{
    print(id);
    print(personRepository.users[id]);
    emit(personRepository.users[id]);
 }
}

