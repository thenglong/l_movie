import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:l_movie/blocs/main_bloc_observer.dart';
import 'package:l_movie/screens/home_screen.dart';
import 'package:l_movie/theme/theme.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  BlocOverrides.runZoned(
    () {
      runApp(const MainApp());
    },
    blocObserver: MainBlocObserver(),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Movie App",
      theme: defaultTheme,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
      ],
      home: const HomeScreen(),
    );
  }
}
