

import 'package:c2mealpha1/states/SearchState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

import '../../events/SearchEvent.dart';

class SearchBloc extends Bloc<SearchEvent,SearchState>{

  SearchBloc() : super(InitState()) {
    on((SearchEvent event, emit) {
      if (event is SliderMoveEvent) {
        emit(SliderMoveState(event.range));
      }
      if (event is GenderSelectedEvent) {
        emit(GenderSelectedState(event.gender));
      }      if (event is GenderAndNameSelectedEvent) {
        emit(GenderAndNameSelectedState(event.gender,event.name));
      }
    });
  }

}