import 'package:c2mealpha1/repository/FlutterUserRepository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../classes/Social.dart';

class SocialChangeBloc extends Bloc<SocialEditEvent,SocialEditState> {


  SocialChangeBloc() : super(SocialInitState()){
    on((event, emit) {
      if(event is SocialUpdateEvent){
        emit(SocialUpdateState(event.social,event.id));
      }
    });
  }

}

class SocialEditEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class SocialUpdateEvent extends SocialEditEvent{
  final Social social;
  final String id;
  SocialUpdateEvent(this.social,this.id);
  @override
  List<Object?> get props => [this.social,this.id];
}


class SocialEditState extends Equatable{
  final FlutterRepository repository = new FlutterRepository();
  @override
  List<Object?> get props => [];
}

class SocialInitState extends SocialEditState{
  @override
  List<Object?> get props => [];
}


class SocialUpdateState extends SocialEditState{
  final Social social;
  final String id;
  SocialUpdateState(this.social,this.id){
    repository.addSocial(social);
  }
  @override
  List<Object?> get props => [this.social,this.id];
}