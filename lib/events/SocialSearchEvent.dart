import 'package:equatable/equatable.dart';

import '../classes/SocialMedia.dart';

class SocialSearchEvent extends Equatable {
  List<Object?> get props => [];
}


class SocialSearchAddEvent extends SocialSearchEvent{
  final SocialMedia x;
  SocialSearchAddEvent(this.x);
  List<Object?> get props =>[];
}

class SocialSearchInitEvent extends SocialSearchEvent{

  List<Object?> get props =>[];
}

