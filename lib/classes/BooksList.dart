class BooksList {
  List<Map<String, dynamic>> booksList;
  BooksList({
    required this.booksList,
  });

  Map<String, dynamic> toJson() => {"books_list": booksList};

  factory BooksList.fromJson(Map<String, dynamic> json) {
    return BooksList(
        booksList: json["books_list"] as List<Map<String, dynamic>>);
  }
}
