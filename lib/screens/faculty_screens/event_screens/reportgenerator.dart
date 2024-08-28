import 'package:event_quest/models/event.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class EventReportGenerator {
  final GenerativeModel model = GenerativeModel(
    model: 'gemini-pro',
    apiKey: 'AIzaSyBXpwcezV-uPCUrHJAeWHkGBlTgSZ0kdQ4',
  );
  String generatedContent = '';
  String generatedHighlightsOfActivity = '';
  String generatedKeyTakeAways = '';
  String generatedActivitySummary = '';
  String generatedFollowUp = '';

  Future<void> generateContent(Event event) async {
    final content = [
      Content.text(
          "${event.eventName} Event name and ${event.eventDescription} event description.Please write the report for this event for perfect 800 words only in single paragraph only.please dont use **. Don't write title"),
    ];
    final response = await model.generateContent(content);
    generatedContent = response.text!;
  }

  Future<void> generateHighlightsOfActivity(Event event) async {
    final content = [
      Content.text(
          "${event.eventName} Event name and ${event.eventDescription} event description.Please write the Highlight of the Activity report for this event in simple paragraph with perfect 50 words only which should be real.please dont use **"),
    ];
    final response = await model.generateContent(content);
    generatedHighlightsOfActivity = response.text!;
  }

  Future<void> generateKeyTakeAways(Event event) async {
    final content = [
      Content.text(
          "${event.eventName} Event name and ${event.eventDescription} event description.Please write the Key Take Aways of event in report in simple 2 bullet points which should be real.please dont use **"),
    ];
    final response = await model.generateContent(content);
    generatedKeyTakeAways = response.text!;
  }

  Future<void> generateActivitySummary(Event event) async {
    final content = [
      Content.text(
          "${event.eventName} Event name and ${event.eventDescription} event description.Please write the Summary of the Activity report for this event in simple paragraph of perfect 70 words which should be real.please dont use **"),
    ];
    final response = await model.generateContent(content);
    generatedActivitySummary = response.text!;
  }

  Future<void> generateFollowUp(Event event) async {
    final content = [
      Content.text(
          "${event.eventName} Event name and $generatedActivitySummary.Please write the FollowUp of the Activity for this event in simple one point 20 words only which should be real.please dont use **"),
    ];
    final response = await model.generateContent(content);
    generatedFollowUp = response.text!;
  }
}
