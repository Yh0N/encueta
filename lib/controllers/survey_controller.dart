import 'package:get/get.dart';
import 'package:survey/models/survey.dart';

class SurveyController extends GetxController {
  var surveys = <Survey>[].obs;

  void addSurvey(String question, List<String> options) {
    surveys.add(Survey(
      question: question,
      options: options,
      votes: List.generate(options.length, (_) => 0).obs,
      isActive: true.obs,
    ));
  }

  void vote(int surveyIndex, int optionIndex) {
    if (surveys[surveyIndex].isActive.value) {
      surveys[surveyIndex].votes[optionIndex]++;
      surveys.refresh();
    }
  }

  void closeSurvey(int index) {
    surveys[index].isActive.value = false;
    surveys.refresh();
  }
}
