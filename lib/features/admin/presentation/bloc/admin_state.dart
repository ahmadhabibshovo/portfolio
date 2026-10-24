import 'package:equatable/equatable.dart';

import '../../../portfolio/domain/entities/book_entity.dart';
import '../../../portfolio/domain/entities/highlight_entity.dart';
import '../../../portfolio/domain/entities/social_link_entity.dart';
import '../../domain/entities/contact_message_entity.dart';

abstract class AdminState extends Equatable {
  const AdminState();

  @override
  List<Object?> get props => [];
}

class AdminInitialState extends AdminState {}

class AdminLoadingState extends AdminState {}

class AdminLoadedState extends AdminState {
  final List<ContactMessageEntity> messages;
  final List<SocialLinkEntity> socialLinks;
  final List<BookEntity> books;
  final List<HighlightEntity> highlights;
  final String? feedbackMessage;
  final String? uploadedFileUrl;

  const AdminLoadedState({
    required this.messages,
    this.socialLinks = const [],
    this.books = const [],
    this.highlights = const [],
    this.feedbackMessage,
    this.uploadedFileUrl,
  });

  AdminLoadedState copyWith({
    List<ContactMessageEntity>? messages,
    List<SocialLinkEntity>? socialLinks,
    List<BookEntity>? books,
    List<HighlightEntity>? highlights,
    String? feedbackMessage,
    String? uploadedFileUrl,
  }) {
    return AdminLoadedState(
      messages: messages ?? this.messages,
      socialLinks: socialLinks ?? this.socialLinks,
      books: books ?? this.books,
      highlights: highlights ?? this.highlights,
      feedbackMessage: feedbackMessage,
      uploadedFileUrl: uploadedFileUrl ?? this.uploadedFileUrl,
    );
  }

  @override
  List<Object?> get props => [
    messages,
    socialLinks,
    books,
    highlights,
    feedbackMessage,
    uploadedFileUrl,
  ];
}

class AdminFailureState extends AdminState {
  final String message;
  const AdminFailureState(this.message);

  @override
  List<Object?> get props => [message];
}
