import 'package:c2mealpha1/classes/Social.dart';
import 'package:c2mealpha1/classes/SocialMedia.dart';
import 'package:c2mealpha1/events/ProfileEvent.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../classes/Profile.dart';
import '../states/ProfileState.dart';

class ProfilCubit extends Bloc<ProfileEvent, ProfileState> {
  ProfilCubit() : super(ProfileInitState()) {
    List<Profile> follower = [];
    List<Profile> folows = [];

    List<Profile> users = [
      Profile(
          "Sabrina",
          "https://mindjazz-pictures.de/wp-content/uploads/2020/06/Woman_header_Still0-1440x810.jpg",
          1),
      Profile(
          "Sarah",
          "https://media.gettyimages.com/photos/beauty-portrait-of-young-woman-picture-id1309405076?s=612x612",
          2),
      Profile(
          "Jenny",
          "https://media.vogue.fr/photos/5d2c4510c9cf700008f68f3c/3:2/w_1439,h_959,c_limit/D4_6SNzWwAAyAfV.jpg",
          3),
      Profile(
          "Jenny",
          "https://media.vogue.fr/photos/5d2c4510c9cf700008f68f3c/3:2/w_1439,h_959,c_limit/D4_6SNzWwAAyAfV.jpg",
          4),
      Profile(
          "Jenny",
          "https://media.vogue.fr/photos/5d2c4510c9cf700008f68f3c/3:2/w_1439,h_959,c_limit/D4_6SNzWwAAyAfV.jpg",
          5),
      Profile(
          "Jenny",
          "https://media.vogue.fr/photos/5d2c4510c9cf700008f68f3c/3:2/w_1439,h_959,c_limit/D4_6SNzWwAAyAfV.jpg",
          6),
      Profile(
          "Jenny",
          "https://media.vogue.fr/photos/5d2c4510c9cf700008f68f3c/3:2/w_1439,h_959,c_limit/D4_6SNzWwAAyAfV.jpg",
          7),
      Profile(
          "Jenny",
          "https://media.vogue.fr/photos/5d2c4510c9cf700008f68f3c/3:2/w_1439,h_959,c_limit/D4_6SNzWwAAyAfV.jpg",
          8),
      Profile(
          "Jenny",
          "https://media.vogue.fr/photos/5d2c4510c9cf700008f68f3c/3:2/w_1439,h_959,c_limit/D4_6SNzWwAAyAfV.jpg",
          9)
    ];
    on<ProfileLoad>((event, emit) => {
          users[0].near = [users[1], users[2], users[4], users[7]],
          users[0].follower = [users[1], users[2]],
          users[0].socials = [new Social(SocialMedia.BLIZZARD, "uwuwuwwuwu"),new Social(SocialMedia.TWITTER, "uwuwuwwuwu"),new Social(SocialMedia.INSTAGRAM, "uwuwuwwuwu")],
          emit(ProfileLoadedState(users[0]))
        });
  }
}
