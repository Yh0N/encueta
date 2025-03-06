import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:survey/controllers/survey_controller.dart';
import 'package:survey/models/survey.dart';

class HomeSurvey extends StatelessWidget {
  HomeSurvey({super.key});

  final SurveyController surveyController = Get.put(SurveyController());
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _optionController = TextEditingController();
  final RxList<String> options = <String>[].obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Survey App"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return surveyController.surveys.isEmpty
                  ? const Center(child: Text("No hay encuestas disponibles"))
                  : ListView.builder(
                      itemCount: surveyController.surveys.length,
                      itemBuilder: (context, index) {
                        return _buildSurveyCard(index);
                      },
                    );
            }),
          ),
          _buildSurveyInput(),
        ],
      ),
    );
  }

  Widget _buildSurveyCard(int index) {
    final Survey survey = surveyController.surveys[index];

    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text(survey.question),
            subtitle: Obx(() => Text(
                  survey.isActive.value ? "Activa" : "Cerrada",
                  style: TextStyle(
                    color: survey.isActive.value ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          ),
          Obx(() => Column(
                children: List.generate(survey.options.length, (i) {
                  return ListTile(
                    title: Text(survey.options[i]),
                    subtitle: Text("Votos: ${survey.votes[i]}"),
                    trailing: survey.isActive.value
                        ? IconButton(
                            icon: const Icon(Icons.how_to_vote, color: Colors.blue),
                            onPressed: () => surveyController.vote(index, i),
                          )
                        : null,
                  );
                }),
              )),
          Obx(() => survey.isActive.value
              ? ElevatedButton(
                  onPressed: () => surveyController.closeSurvey(index),
                  child: const Text("Cerrar Encuesta"),
                )
              : const SizedBox.shrink()),
        ],
      ),
    );
  }

  Widget _buildSurveyInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            controller: _questionController,
            decoration: const InputDecoration(labelText: "Nueva Encuesta"),
          ),
          Obx(() => Column(
                children: options
                    .map((option) => ListTile(
                          title: Text(option),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => options.remove(option),
                          ),
                        ))
                    .toList(),
              )),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _optionController,
                  decoration: const InputDecoration(labelText: "Agregar opción"),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add, color: Colors.green),
                onPressed: () {
                  if (_optionController.text.isNotEmpty) {
                    options.add(_optionController.text);
                    _optionController.clear();
                  }
                },
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              if (_questionController.text.isNotEmpty && options.isNotEmpty) {
                surveyController.addSurvey(_questionController.text, List<String>.from(options));
                _questionController.clear();
                options.clear();
              }
            },
            child: const Text("Crear Encuesta"),
          ),
        ],
      ),
    );
  }
}
