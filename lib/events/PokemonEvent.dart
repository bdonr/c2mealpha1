import 'package:equatable/equatable.dart';

abstract class PokemonEvent extends Equatable{

}

class PokemonRequestEvent extends PokemonEvent{
  @override
  final int page;


  PokemonRequestEvent(this.page);

  List<Object?> get props => [this.page];


}