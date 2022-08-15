 import 'package:c2mealpha1/classes/Profile.dart';
import 'package:c2mealpha1/states/SearchState.dart';
import 'package:equatable/equatable.dart';
import 'package:location/location.dart';

import '../classes/SocialMedia.dart';
import '../enums/SearchCriteria.dart';
import '../repository/FlutterUserRepository.dart';

abstract class SearchEvent extends Equatable{

}

class InitEvent extends SearchEvent{

  @override
  List<Object?> get props => [props];
}

class SliderMoveEvent extends SearchEvent{

  final double range;
  SliderMoveEvent(this.range);
  List<Object?> get props =>[range];
}
class SliderMoveEvent2 extends SearchEvent{
  final double gender;
  SliderMoveEvent2(this.gender);
  List<Object?> get props =>[gender];
}

class SliderMoveEvent3 extends SearchEvent{
  final double single;
  SliderMoveEvent3(this.single);
  List<Object?> get props =>[single];
}

class StartSearchEvent extends SearchEvent{
  StartSearchEvent();
  List<Object?> get props =>[];
}

class GenderSelectedEvent extends SearchEvent{
  final String gender;
  GenderSelectedEvent(this.gender);
  @override
  List<Object?> get props =>[gender];
}


class GenderAndNameSelectedEvent extends SearchEvent{
  final String gender;
  final String name;
  GenderAndNameSelectedEvent(this.gender,this.name);
  @override
  List<Object?> get props =>[gender,name];
}

