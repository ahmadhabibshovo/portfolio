import 'package:equatable/equatable.dart';

class BookEntity extends Equatable {
  final int id;
  final String title;
  final String author;
  final String coverUrl;
  final String linkUrl;
  final String status;
  final int rating;
  final String review;
  final int order;

  const BookEntity({
    required this.id,
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.linkUrl,
    this.status = 'Recommended',
    this.rating = 5,
    this.review = '',
    this.order = 0,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    author,
    coverUrl,
    linkUrl,
    status,
    rating,
    review,
    order,
  ];
}
