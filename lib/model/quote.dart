class Quote {
  final String content;
  final String author;

  Quote({required this.content, required this.author});

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(content: json['quote'], author: json['author']);
  }
  //  Map<String, dynamic> toJson() {
  //   return {
  //     'content': content,
  //     'author': author,
  //   };
  // }
}
