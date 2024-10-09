class Book {
  final String subtitle;
  final String title;

  final String authors;
  final String description;
  final String price;
  final String isbn;
  final String publisher;
  final String publishedDate;
  // final String language;
  final String pages;
  final String rating;
  final String imageUrl;
  // final String category;

  const Book({
    required this.subtitle,
    required this.title,

    required this.authors,
    required this.description,
    required this.price,
    required this.isbn,
    required this.publisher,
    required this.publishedDate,
    // required this.language,
    required this.pages,
    required this.rating,
    required this.imageUrl,
    // required this.category,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    /*
{
    "error": "0"
    "title": "Securing DevOps"
    "subtitle": "Security in the Cloud"
    "authors": "Julien Vehent"
    "publisher": "Manning"
    "isbn10": "1617294136"
    "isbn13": "9781617294136"
    "pages": "384"
    "year": "2018"
    "rating": "5"
    "desc": "An application running in the cloud can benefit from incredible efficiencies, but they come with unique security threats too. A DevOps team's highest priority is understanding those risks and hardening the system against them.Securing DevOps teaches you the essential techniques to secure your cloud ..."
    "price": "$26.98"
    "image": "https://itbook.store/img/books/9781617294136.png"
    "url": "https://itbook.store/books/9781617294136"
    "pdf": {
              "Chapter 2": "https://itbook.store/files/9781617294136/chapter2.pdf",
              "Chapter 5": "https://itbook.store/files/9781617294136/chapter5.pdf"
           }
}
    */

    return Book(
      title: json['title'],
      subtitle: json['subtitle'],
      authors: json['authors'],
      publisher: json['publisher'],
      isbn: json['isbn13'],
      pages: json['pages'],
      publishedDate: json['year'],
      rating: json['rating'],
      description: json['desc'],
      price: json['price'],
      imageUrl: json['image'],
      // language: json['language'],
      // category: json['category'],
    );

  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'id': subtitle,
      'authors': authors,
      'publisher': publisher,
      'isbn': isbn,
      'publishedDate': publishedDate,
      'pages': pages,
      'description': description,
      'price': price,
      // 'language': language,
      'rating': rating,
      'imageUrl': imageUrl,
      // 'category': category,
    };


  }

  }