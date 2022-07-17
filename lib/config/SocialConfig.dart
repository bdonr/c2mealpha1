import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../classes/Social.dart';
import '../classes/SocialMedia.dart';

class SocialConfig {
  static Color configColor(Social x) {
    print(x.socialMedia);
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

  static Text configText(Social x) {
    String tmp = x.socialMedia.toString();
    return Text(
      _modifyText(tmp),
      style: TextStyle(
          color: _configTextColor(x), fontSize: 12),
    );
  }
}

String _modifyText(String x) {
  String tmp = x.split(".")[1];
  return tmp[0].toUpperCase() + tmp.substring(1, tmp.length).toLowerCase();
}

Color _configTextColor(Social x) {
  print(x.socialMedia);
  if (x.socialMedia == SocialMedia.INSTAGRAM) {
    return Colors.grey;
  }
  if (x.socialMedia == SocialMedia.TWITTER) {
    return Colors.grey;;
  }
  if (x.socialMedia == SocialMedia.TWITCH) {
    return Colors.grey;
  }
  if (x.socialMedia == SocialMedia.FACEBOOK) {
    return Colors.grey;
  }
  if (x.socialMedia == SocialMedia.ONLYFANS) {
    return Colors.grey;
  }
  if (x.socialMedia == SocialMedia.PINTEREST) {
    return Colors.grey;
  }
   return Colors.grey;
}
