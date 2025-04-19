import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:myapp/model/quote.dart';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  Quote? quote;
  bool isLoading = true;

  Future<void> fetchQuote() async {
    setState(() => isLoading = true);

    try {
      final res = await http.get(
        Uri.parse('https://dummyjson.com/quotes/random'),
      );

      print("Status Code: ${res.statusCode}");
      print("Body: ${res.body}");

      if (res.statusCode == 200) {
        final data = json.decode(res.body);
        quote = Quote.fromJson(data);
      } else {
        quote = Quote(content: "Error fetching quote", author: "😢");
      }
    } catch (e) {
      print("Fetch Error: $e");
      quote = Quote(content: "Exception occurred", author: "😢");
    }

    setState(() => isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    fetchQuote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quote App")),
      body: Center(
        child:
            isLoading
                ? const CircularProgressIndicator()
                : Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '"${quote!.content}"',
                        style: const TextStyle(fontSize: 22),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "- ${quote!.author}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: fetchQuote,
                        child: const Text("New Quote"),
                      ),
                    ],
                  ),
                ),
      ),
    );
  }
}
