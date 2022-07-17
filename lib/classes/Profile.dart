import 'Social.dart';
import 'SocialMedia.dart';

class Profile{
  final String name;
  final String url;
  final int id;
  late final List<Profile> _follower;
  late List<Profile> _follows;
  late final List<Profile> _near;
  late final List<Social> _socials;


  Profile(this.name, this.url, this.id);


  set near(List<Profile> value) {
    _near = value;
  }


  List<Social> get socials => _socials;

  set socials(List<Social> value) {
    _socials = value;
  }

  List<Profile> get follower => _follower;

  set follows(List<Profile> value) {
    _follows = value;
  }


  set follower(List<Profile> value) {
    _follower = value;
  }

  List<Profile> get follows => _follows;

  List<Profile> get near => _near;
}