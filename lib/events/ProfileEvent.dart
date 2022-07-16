import 'package:equatable/equatable.dart';

import '../classes/Profile.dart';

abstract class ProfileEvent extends Equatable{
  List<Object?> get props => [];
}
class ProfileInit extends ProfileEvent{

}
class ProfileLoad extends ProfileEvent{


}