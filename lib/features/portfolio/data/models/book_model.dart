import '../../domain/entities/book_entity.dart';

class BookModel extends BookEntity {
  const BookModel({
    required super.id,
    required super.title,
    required super.author,
    required super.coverUrl,
    required super.linkUrl,
    super.status = 'Recommended',
    super.rating = 5,
    super.review = '',
    super.order = 0,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      author: json['author'] as String? ?? '',
      coverUrl: json['cover_url'] as String? ?? '',
      linkUrl: json['link_url'] as String? ?? '',
      status: json['status'] as String? ?? 'Recommended',
      rating: json['rating'] as int? ?? 5,
      review: json['review'] as String? ?? '',
      order: json['order'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'cover_url': coverUrl,
      'link_url': linkUrl,
      'status': status,
      'rating': rating,
      'review': review,
      'order': order,
    };
  }
}
