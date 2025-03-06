import 'package:get/get.dart';

class Survey {
  String question;
  List<String> options;
  RxList<int> votes;
  RxBool isActive;

  Survey({
    required this.question,
    required this.options,
    required this.votes,
    required this.isActive,
  });
}
