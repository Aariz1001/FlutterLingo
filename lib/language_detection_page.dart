import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tflite_flutter/tflite_flutter.dart';

class LanguageDetectionPage extends StatefulWidget {
  const LanguageDetectionPage({super.key});

  @override
  State<LanguageDetectionPage> createState() => _LanguageDetectionPageState();
}

class _LanguageDetectionPageState extends State<LanguageDetectionPage> {

  final TextEditingController sentence = TextEditingController();

  String _detectedlanguage = "Language Not Detected";



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: const Text('Language Detection',
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold
          ),
        ),
        actions: [
          GestureDetector(
            child: const Icon(
                Icons.logout,
                color: Colors.black,
              ),
              onTap: () {
                FirebaseAuth.instance.signOut();
            },
          )
        ],
      ),
      backgroundColor: Colors.grey[300],
    body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  controller: sentence,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(20)
                    ),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    hintText: "Enter a sentence",
                    hintStyle: const TextStyle(
                      color: Colors.black
                    )
                  )
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {detectLanguage(sentence.text);},
                child: const Text(
                  'Detect Language',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                _detectedlanguage,
              ),
            ],
          )
        ),
      ),
    );
  }
Future<void> detectLanguage(String sentence) async {
  final interpreter = await Interpreter.fromAsset('language_detection.tflite');
  final input = sentence.codeUnits;
  final output = List.filled(1, 0.0);
  interpreter.run(input, output);
  final languageIndex = output[0].toInt();
  final languages = ['English', 'Spanish', 'French', 'German', 'Italian'];
  _language = languages[languageIndex];
  interpreter.close();
}
}