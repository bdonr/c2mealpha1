import 'Social.dart';
import 'SocialMedia.dart';

class Profile{
  final String name;
  final String id;
  final int followerCount;
  final int messageCount;
  final int follows;

  Profile(this.id,this.name, this.followerCount, this.messageCount, this.follows);

}