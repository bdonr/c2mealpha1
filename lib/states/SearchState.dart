import 'package:c2mealpha1/repository/FlutterUserRepository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:location/location.dart';

import '../classes/SocialMedia.dart';
import '../enums/SearchCriteria.dart';

abstract class SearchState extends Equatable{
  final FlutterRepository repository=FlutterRepository();
  List<Object?> get props => [];

}

class InitState extends SearchState{
  @override
  InitState(){
    repository.standartSearch();
  }
  @override
  List<Object?> get props => [];
}

class SliderMoveState extends SearchState{
  final double range;
  SliderMoveState(this.range){
    repository.distance=this.range;
  }
  @override
  List<Object?> get props =>[this.range];
}

class SliderMoveState2 extends SearchState{
  final double gender;
  SliderMoveState2(this.gender){
    repository.distance=this.gender;
  }
  @override
  List<Object?> get props =>[this.gender];
}
class SliderMoveState3 extends SearchState{
  final double single;
  SliderMoveState3(this.single){
    repository.distance=this.single;
  }
  @override
  List<Object?> get props =>[this.single];
}



class GenderSelectedState extends SearchState{
  final String gender;
  GenderSelectedState(this.gender){
    repository.genderWhere(this.gender);
  }
  @override
  List<Object?> get props =>[this.gender];
}


class GenderAndNameSelectedState extends SearchState{

  final String gender;
  final String name;
  GenderAndNameSelectedState(this.gender,this.name){
    repository.nameGenderWhere(this.name, this.gender);
  }
  @override
  List<Object?> get props =>[this.gender,this.name];
}

class SocialSearchAddState extends SearchState{
   List<SocialMedia> socialList=[];
   List<SocialMedia> socialList2=[];
  SocialSearchAddState(this.socialList,this.socialList2);
  @override
  List<Object?> get props =>[this.socialList,this.socialList2];
}

class SocialSearchInitState extends SearchState{
  List<SocialMedia> socialList = [
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

  SocialSearchInitState();
  List<Object?> get props =>[socialList,this.socialList2];
}