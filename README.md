# 🎯 Goal:

    - Use http package
    - Fetch data from a public API
    - Show Quote
    - Handle loading/error states

## 💡 Mini Project: Quote App
    
### Features:
    - Fetch quotes from API
    - Show quote & author
    - Refresh button to get new quote

### 🔹 Step 1: Setup
    flutter create quote_api_app
    cd quote_api_app

    #### pubspec.yaml:
    dependencies:
      flutter:
       sdk: flutter
      http: ^0.13.5

### 🔹 Step 2: API Endpoint
    Use this free API:
        https://api.quotable.io/random
    
    Sample response:

    json
        {
            "_id": "abc123",
            "content": "Be yourself; everyone else is already taken.",
            "author": "Oscar Wilde"
        }


### 🔹 Step 3: HTTP Call + UI

    import 'package:flutter/material.dart';
    import 'package:http/http.dart' as http;
    import 'dart:convert';

    class Quote {
      final String content;
      final String author;
    
      Quote({required this.content, required this.author});
    
      factory Quote.fromJson(Map<String, dynamic> json) {
        return Quote(
          content: json['content'],
          author: json['author'],
        );
      }
    }

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
            quote = Quote(content: "Error fetching quote", author:     "😢");
          }
        } catch (e) {
          print("Fetch Error: $e");
          quote = Quote(content: "Exception occurred", author:     "😢");
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
            child: isLoading
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
                        Text("- ${quote!.author}", style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 40),
                        ElevatedButton(
                          onPressed: fetchQuote,
                          child: const Text("New Quote"),
                        )
                      ],
                    ),
                  ),
          ),
        );
      }
    }



### Screenshots...
[Quote 1.](screenshots/flutter_01.png)

[Quote 2.](screenshots/flutter_02.png)