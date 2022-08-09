import 'package:equatable/equatable.dart';

import '../classes/SocialMedia.dart';

class SocialSearchState extends Equatable {
  final List<SocialMedia> socialList = [
    SocialMedia.ONLYFANS,
    SocialMedia.YOUTUBE,
    SocialMedia.TIKTOK,
    SocialMedia.SNAPCHAT,
    SocialMedia.INSTAGRAM,
    SocialMedia.TWITCH,
    SocialMedia.TWITTER,
    SocialMedia.NOTHING
  ];
  List<SocialMedia> socialList2 = [
  ];
  @override
  List<Object?> get props => [];
}

class SocialSearchAddState extends SocialSearchState{
  SocialSearchAddState(SocialMedia x){
    socialList2.add(socialList.firstWhere(
            (e) => e.toString() == x.toString()));
    socialList.removeWhere(
            (e) => e.toString() == x.toString());
  }
  List<Object?> get props =>[this.socialList,this.socialList2];
}

class SocialSearchInitState extends SocialSearchState{
  SocialSearchInitState();
  List<Object?> get props =>[socialList,this.socialList2];
}

