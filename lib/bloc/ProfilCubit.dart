import 'package:c2mealpha1/classes/Social.dart';
import 'package:c2mealpha1/classes/SocialMedia.dart';
import 'package:c2mealpha1/events/ProfileEvent.dart';
import 'package:c2mealpha1/repository/PersonRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../classes/Profile.dart';
import '../states/ProfileState.dart';

class ProfilCubit extends Bloc<ProfileEvent, ProfileState> {
  final PersonRepository personRepository= PersonRepository();
  ProfilCubit() : super(ProfileInitState()) {

    on<ProfileLoad>((event, emit) => {

          personRepository.users[0].socials = [
            new Social(SocialMedia.TWITTER, "uwuwuwwuwu"),
            new Social(SocialMedia.INSTAGRAM, "uwuwuwwuwu"),
            new Social(SocialMedia.FACEBOOK, "uwuwuwwuwu"),
            new Social(SocialMedia.SNAPSHAT, "uwuwuwwuwu"),
            new Social(SocialMedia.XING, "uwuwuwwuwu"),
          ],
          emit(ProfileLoadedState(personRepository.users[0]))
        });
  }
}
