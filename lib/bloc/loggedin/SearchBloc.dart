import 'package:c2mealpha1/states/SearchState.dart';
import 'package:c2mealpha1/states/SocialSearchState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

import '../../events/SearchEvent.dart';
import '../../events/SocialSearchEvent.dart';
import '../../repository/FlutterUserRepository.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {



  SearchBloc() : super(InitState()) {
    on((SearchEvent event, emit) {
      if (event is SliderMoveEvent) {
        emit(SliderMoveState(event.range));
      }
      if (event is SliderMoveEvent2) {
        emit(SliderMoveState2(event.gender));
      }
      if (event is SliderMoveEvent3) {
        emit(SliderMoveState3(event.single));
      }
      if (event is StartSearchEvent) {
        emit(StartSearchState());
      }


      if (event is GenderSelectedEvent) {
        emit(GenderSelectedState(event.gender));
      }
      if (event is GenderAndNameSelectedEvent) {
        emit(GenderAndNameSelectedState(event.gender, event.name));
      }
    });
  }
}

class SearchSocialBloc extends Bloc<SocialSearchEvent, SocialSearchState> {
  SearchSocialBloc() : super(SocialSearchInitState()) {
    on((SocialSearchAddEvent event, emit) {
      if (event is SocialSearchAddEvent) {
        emit(SocialSearchAddState(event.x));
      }
      if (event is SocialSearchInitEvent) {
        emit(SocialSearchInitState());
      }
    });
  }
}
