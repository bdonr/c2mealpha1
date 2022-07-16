import 'package:equatable/equatable.dart';

import '../classes/Profile.dart';

abstract class ProfileState extends Equatable{
  List<Object?> get props => [];

}

class ProfileInitState extends ProfileState{

}

class ProfileLoadedState extends ProfileState{
  late final Profile _profile;
  ProfileLoadedState(profile){
    this._profile = profile;
  }
  @override
  Profile get profile => _profile;
}

class ProfileLoadingState extends ProfileState{

}

class ProfileLoadingErrorState extends ProfileState{

}