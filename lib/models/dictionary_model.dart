// To parse this JSON data, do
//
//     final dictionary = dictionaryFromJson(jsonString);

import 'dart:convert';

List<Dictionary> dictionaryFromJson(String str) =>
    List<Dictionary>.from(json.decode(str).map((x) => Dictionary.fromJson(x)));

String dictionaryToJson(List<Dictionary> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Dictionary {
  Dictionary({
    required this.word,
    required this.phonetic,
    required this.phonetics,
    required this.origin,
    required this.meanings,
  });

  String word;
  String phonetic;
  List<Phonetic> phonetics;
  String origin;
  List<Meaning> meanings;

  factory Dictionary.fromJson(Map<String, dynamic> json) => Dictionary(
        word: json["word"] ?? "No Word Found",
        phonetic: json["phonetic"] ?? "No Phonetic Found",
        phonetics: List<Phonetic>.from(
            json["phonetics"].map((x) => Phonetic.fromJson(x))),
        origin: json["origin"] ?? "No Origin Found",
        meanings: List<Meaning>.from(
            json["meanings"].map((x) => Meaning.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "word": word,
        "phonetic": phonetic,
        "phonetics": List<dynamic>.from(phonetics.map((x) => x.toJson())),
        "origin": origin,
        "meanings": List<dynamic>.from(meanings.map((x) => x.toJson())),
      };
}

class Meaning {
  Meaning({
    required this.partOfSpeech,
    required this.definitions,
  });

  String partOfSpeech;
  List<Definition> definitions;

  factory Meaning.fromJson(Map<String, dynamic> json) => Meaning(
        partOfSpeech: json["partOfSpeech"],
        definitions: List<Definition>.from(
            json["definitions"].map((x) => Definition.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "partOfSpeech": partOfSpeech,
        "definitions": List<dynamic>.from(definitions.map((x) => x.toJson())),
      };
}

class Definition {
  Definition({
    required this.definition,
    required this.example,
    required this.synonyms,
    required this.antonyms,
  });

  String definition;
  String example;
  List<dynamic> synonyms;
  List<dynamic> antonyms;

  factory Definition.fromJson(Map<String, dynamic> json) => Definition(
        definition: json["definition"] ?? "No def",
        example: json["example"] ?? "No Example",
        synonyms: List<dynamic>.from(json["synonyms"].map((x) => x)),
        antonyms: List<dynamic>.from(json["antonyms"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "definition": definition,
        "example": example,
        "synonyms": List<dynamic>.from(synonyms.map((x) => x)),
        "antonyms": List<dynamic>.from(antonyms.map((x) => x)),
      };
}

class Phonetic {
  Phonetic({
    required this.text,
    required this.audio,
  });

  String text;
  String audio;

  factory Phonetic.fromJson(Map<String, dynamic> json) => Phonetic(
        text: json["text"] ?? "No text",
        audio: json["audio"] ?? "No audio",
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "audio": audio,
      };
}
