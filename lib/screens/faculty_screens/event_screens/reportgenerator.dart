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
          "${event.eventName} Event name and ${event.eventDescription} event description. Please generate a report for this event in a single paragraph of exactly 800 words. Ensure that the content is plain text, without any special characters, formatting, or emphasis like **. Do not include any titles or headers."),
    ];
    final response = await model.generateContent(content);
    generatedContent = response.text!;
  }

  Future<void> generateHighlightsOfActivity(Event event) async {
    final content = [
      Content.text(
          "${event.eventName} Event name and ${event.eventDescription} event description. Please write a plain text highlight of the activity for this event in a single paragraph of exactly 50 words. Ensure that the content is plain text, without any special characters, formatting, or emphasis like **."),
    ];
    final response = await model.generateContent(content);
    generatedHighlightsOfActivity = response.text!;
  }

  Future<void> generateKeyTakeAways(Event event) async {
    final content = [
      Content.text(
          "${event.eventName} Event name and ${event.eventDescription} event description. Please list the key takeaways of this event in plain text, using only 2 bullet points. Ensure that the content is plain text, without any special characters, formatting, or emphasis like **."),
    ];
    final response = await model.generateContent(content);
    generatedKeyTakeAways = response.text!;
  }

  Future<void> generateActivitySummary(Event event) async {
    final content = [
      Content.text(
          "${event.eventName} Event name and ${event.eventDescription} event description. Please write a plain text summary of the activity for this event in a single paragraph of exactly 70 words. Ensure that the content is plain text, without any special characters, formatting, or emphasis like **."),
    ];
    final response = await model.generateContent(content);
    generatedActivitySummary = response.text!;
  }

  Future<void> generateFollowUp(Event event) async {
    final content = [
      Content.text(
          "${event.eventName} Event name and $generatedActivitySummary. Please write a plain text follow-up of the activity for this event in one point of exactly 20 words. Ensure that the content is plain text, without any special characters, formatting, or emphasis like **."),
    ];
    final response = await model.generateContent(content);
    generatedFollowUp = response.text!;
  }
}
