import 'package:c2mealpha1/bloc/loggedin/FollowsCubit.dart';
import 'package:c2mealpha1/bloc/loggedin/LoggedInPosition.dart';
import 'package:c2mealpha1/bloc/loggedin/LoginCubit.dart';
import 'package:c2mealpha1/bloc/loggedin/LoggedInImageCubit.dart';
import 'package:c2mealpha1/bloc/loggedin/LoginSocialsCubit.dart';
import 'package:c2mealpha1/bloc/loggedin/NearCubit.dart';
import 'package:c2mealpha1/bloc/NavCubit.dart';
import 'package:c2mealpha1/bloc/loggedin/SocialChangeBloc.dart';
import 'package:c2mealpha1/bloc/visit/CommentCubit.dart';
import 'package:c2mealpha1/bloc/visit/DoIFollowCubit.dart';
import 'package:c2mealpha1/bloc/loggedin/MyStoriesCubit.dart';
import 'package:c2mealpha1/bloc/visit/StoryCubit.dart';

import 'package:c2mealpha1/bloc/visit/VisitCubit.dart';
import 'package:c2mealpha1/classes/MainImage.dart';
import 'package:c2mealpha1/events/PokemonEvent.dart';
import 'package:c2mealpha1/events/ProfileEvent.dart';
import 'package:c2mealpha1/navigation/AppNavigator.dart';
import 'package:c2mealpha1/repository/FlutterUserRepository.dart';
import 'package:c2mealpha1/states/PageStates.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/loggedin/FollowerCubit.dart';
import 'bloc/loggedin/MessageCubit.dart';
import 'bloc/loggedin/SearchBloc.dart';
import 'bloc/loggedin/SocialSearchCubit.dart';
import 'bloc/visit/SocialsCubit.dart';
import 'classes/Profile.dart';
import 'events/PageEvents.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  FlutterRepository repository = FlutterRepository();
  Future<FirebaseApp> fbApp =
      Firebase.initializeApp(options: DefaultFirebaseOptions.android);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: Theme.of(context)
            .copyWith(primaryColor: Colors.red, accentColor: Colors.redAccent),
        home: FutureBuilder(
            future: fbApp,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return FutureBuilder(
                    future: repository.login("50myTvoVDnY1TIkhiFJh"),
                    builder: (context, snap) {
                      if (snap.hasData) {
                        return MultiBlocProvider(providers: [
                          _login(),
                          _visitProfile(),
                          _visitProfileSocials(),
                          _startSocials(),
                          _startPos(),
                          _startFollow(),
                          _startMessages(),
                          _startFollower(),
                          _mainImage(),
                          _startSearch(),
                          _startSocialSearch(),
                          _socialListen(),
                          _doIfollow(),
                          _visitStory(),
                          _visitComment(),
                          _visitMyStories()
                        ], child: SafeArea(child: AppNavigator()));
                      }
                      if (snap.hasError) {
                        print(snap.error.toString());
                      } else {
                        return CircularProgressIndicator();
                      }
                      return Container();
                    });
              }
              if (snapshot.hasError) {
                return Text("${snapshot.error}");
              } else {
                return CircularProgressIndicator();
              }
            }));
  }

  static _login() => BlocProvider(
      create: (context) => LoginCubit()..login("50myTvoVDnY1TIkhiFJh"));

  static _doIfollow() => BlocProvider(create: (context) => DoIFollowCubit());

  static _socialListen() =>
      BlocProvider(create: (context) => SocialChangeBloc());

  static _startPos() => BlocProvider(create: (context) => LoggedInPosition());

  static _startSearch() => BlocProvider(create: (context) => SearchBloc());

  static _startSocialSearch() =>
      BlocProvider(create: (context) => SocialSearchCubit()..start());

  static _startFollow() => BlocProvider(
      create: (context) => FollowsCubit()..getFollows("50myTvoVDnY1TIkhiFJh"));

  static _startFollower() => BlocProvider(
      create: (context) =>
          FollowerCubit()..getFollower("50myTvoVDnY1TIkhiFJh"));

  static _startMessages() => BlocProvider(
      create: (context) => MessageCubit()..getMessages("50myTvoVDnY1TIkhiFJh"));

  static _mainImage() => BlocProvider(
      create: (context) =>
          LoggedInImageCubit()..getImage("50myTvoVDnY1TIkhiFJh"));

  static _visitProfile() => BlocProvider(
      create: (context) => VisitCubit()..findProfile("50myTvoVDnY1TIkhiFJh"));

  static _visitProfileSocials() => BlocProvider(
      create: (context) => SocialsCubit()..getSocials("50myTvoVDnY1TIkhiFJh"));

  static _startSocials() => BlocProvider(
      create: (context) =>
          LoginSocialsCubit()..getSocials("50myTvoVDnY1TIkhiFJh"));

  static _visitStory() => BlocProvider(
      create: (context) =>
          StoryCubit());

  static _visitMyStories()=> BlocProvider(create: (context) => MyStoriesCubit());
  static _visitComment()=> BlocProvider(create: (context) => CommentCubit());
}
