import 'package:education_system/shared/main_cubit/main_cubit.dart';
import 'package:education_system/shared/utils/colors.dart';
import 'package:education_system/student/features/profile/manager/profile_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "package:flutter_localizations/flutter_localizations.dart";

import 'admin/features/home/view/home_page.dart';
import 'components/locale/applocale.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyA1wYGW15FWHjhRk1L0GUYznXXSpVuDsek",
      authDomain: "education-system1.firebaseapp.com",
      projectId: "education-system1",
      storageBucket: "education-system1.appspot.com",
      messagingSenderId: "1020935355775",
      appId: "1:1020935355775:web:2766a86f4b08faaf9aae4a",
      measurementId: "G-SQDTC6BQ0T",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MainCubit()),
        BlocProvider(create: (context) => ProfileCubit()),
      ],
      child: BlocConsumer<MainCubit, MainState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              appBarTheme: const AppBarTheme(iconTheme: IconThemeData(color: ColorsAsset.kbackgorund)),
              expansionTileTheme: ExpansionTileThemeData(
                  backgroundColor: ColorsAsset.kLightPurble,
                  childrenPadding: const EdgeInsets.all(10),
                  shape: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            localizationsDelegates: const [
              AppLocale.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale("en", ""),
              Locale("ar", ""),
            ],
            localeResolutionCallback: (currentLang, supportLang) {
              if (currentLang != null) {
                for (Locale locale in supportLang) {
                  if (locale.languageCode == currentLang.languageCode) {
                    return currentLang;
                  }
                }
              }
              return supportLang.first;
            },
            locale: Locale(MainCubit.get(context).lang),
            // TeacherLayout
            // Studentlayout
            // LoginPage
            home: const AdminHomePage(),
          );
        },
      ),
    );
  }
}
