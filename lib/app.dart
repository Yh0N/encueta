import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:survey/screens/home_survey.dart';

class SurveyApp extends StatelessWidget {
  const SurveyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Survey App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: false,
      ),
      home: HomeSurvey(),
    );
  }
}
