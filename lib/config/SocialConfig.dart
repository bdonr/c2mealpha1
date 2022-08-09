import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../classes/Social.dart';
import '../classes/SocialMedia.dart';

class SocialConfig {
  static Color configColor(Social x) {
    if (x.socialMedia == SocialMedia.INSTAGRAM) {
      return Colors.lightBlueAccent;
    }
    if (x.socialMedia == SocialMedia.TWITTER) {
      return Colors.blueAccent;
    }
    if (x.socialMedia == SocialMedia.TWITCH) {
      return Colors.deepPurple;
    }
    if (x.socialMedia == SocialMedia.FACEBOOK) {
      return Colors.blue;
    }
    if (x.socialMedia == SocialMedia.ONLYFANS) {
      return Colors.lightBlue;
    }
    if (x.socialMedia == SocialMedia.PINTEREST) {
      return Colors.deepOrange;
    }
    return Colors.deepPurple;
  }

  static Color configColorByEnum(SocialMedia x) {
    if (x== SocialMedia.INSTAGRAM) {
      return Colors.pink;
    }
    if (x == SocialMedia.TWITTER) {
      return Colors.blueAccent;
    }
    if (x == SocialMedia.TIKTOK) {
      return Colors.black;
    }
    if (x == SocialMedia.SNAPCHAT) {
      return Colors.yellowAccent;
    }
    if (x == SocialMedia.TWITCH) {
      return Colors.deepPurple;
    }
    if (x == SocialMedia.FACEBOOK) {
      return Colors.blue;
    }
    if (x == SocialMedia.ONLYFANS) {
      return Colors.greenAccent;
    }
    if (x == SocialMedia.YOUTUBE) {
      return Colors.red;
    }
    if (x == SocialMedia.PINTEREST) {
      return Colors.deepOrange;
    }
    if (x == SocialMedia.NOTHING) {
      return Colors.grey;
    }
    return Colors.deepPurple;
  }



  static FaIcon configIconEnum(SocialMedia x) {
    if (x == SocialMedia.INSTAGRAM) {
      return FaIcon(FontAwesomeIcons.instagram, color: Colors.white);
    }
    if (x == SocialMedia.TWITTER) {
      return FaIcon(FontAwesomeIcons.twitter, color: Colors.white);
    }
    if (x == SocialMedia.TWITCH) {
      return FaIcon(FontAwesomeIcons.twitch, color: Colors.white);
    }
    if (x == SocialMedia.FACEBOOK) {
      return FaIcon(FontAwesomeIcons.facebook, color: Colors.white);
      ;
    }
    if (x == SocialMedia.ONLYFANS) {
      return FaIcon(FontAwesomeIcons.fan, color: Colors.white);
    }
    if (x == SocialMedia.PINTEREST) {
      return FaIcon(FontAwesomeIcons.pinterest, color: Colors.white);
    }
    if (x == SocialMedia.XING) {
      return FaIcon(FontAwesomeIcons.xing, color: Colors.white);
    }
    return FaIcon(FontAwesomeIcons.hourglassEmpty, color: Colors.white);
  }

  static FaIcon configIcon(Social x) {
    print(x.socialMedia);
    if (x.socialMedia == SocialMedia.INSTAGRAM) {
      return FaIcon(FontAwesomeIcons.instagram, color: Colors.white);
    }
    if (x.socialMedia == SocialMedia.TWITTER) {
      return FaIcon(FontAwesomeIcons.twitter, color: Colors.white);
    }
    if (x.socialMedia == SocialMedia.TWITCH) {
      return FaIcon(FontAwesomeIcons.twitch, color: Colors.white);
    }
    if (x.socialMedia == SocialMedia.FACEBOOK) {
      return FaIcon(FontAwesomeIcons.facebook, color: Colors.white);
      ;
    }
    if (x.socialMedia == SocialMedia.ONLYFANS) {
      return FaIcon(FontAwesomeIcons.fan, color: Colors.white);
    }
    if (x.socialMedia == SocialMedia.PINTEREST) {
      return FaIcon(FontAwesomeIcons.pinterest, color: Colors.white);
    }
    if (x.socialMedia == SocialMedia.XING) {
      return FaIcon(FontAwesomeIcons.xing, color: Colors.white);
    }
    return FaIcon(FontAwesomeIcons.hourglassEmpty, color: Colors.white);
  }

  static Text configTextEnum(SocialMedia x) {
    String tmp = _modifyText(x.toString());
    return Text(
      tmp,
      style: TextStyle(
          color: _configTextColor(tmp),fontWeight: FontWeight.bold,fontSize: 20),
    );
  }

  static Text configText(String x) {
    x=_modifyText(x);
    return Text(
      x,
      style: TextStyle(
          color: _configTextColor(x), fontSize: 12,fontWeight: FontWeight.bold),
    );
  }
}

String _modifyText(String x) {
  String tmp = x.split(".")[1];
  return tmp[0].toUpperCase() + tmp.substring(1, tmp.length).toLowerCase();
}

Color _configTextColor(String x) {
  if (x == "Instagram") {
    return Colors.white;
  }
  if (x=="Twitter") {
    return Colors.white;
  }
  if (x == "Twitch") {
    return Colors.white;
  }
  if (x == "Facebook") {
    return Colors.white;
  }
  if (x == "Onlyfans") {
    return Colors.white;
  }
  if (x == "Pinterest") {
    return Colors.white;
  }
  if (x == "Youtube") {
    return Colors.white;
  }if (x == "Snapchat") {
    return Colors.black;
  }if (x == "Tiktok") {
    return Colors.white;
  }
  if (x == "Nothing") {
    return Colors.orange;
  }
   return Colors.grey;
}
