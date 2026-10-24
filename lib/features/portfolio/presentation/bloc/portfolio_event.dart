import 'package:equatable/equatable.dart';

abstract class PortfolioEvent extends Equatable {
  const PortfolioEvent();

  @override
  List<Object?> get props => [];
}

class FetchPortfolioDataEvent extends PortfolioEvent {
  final bool forceRefresh;
  const FetchPortfolioDataEvent({this.forceRefresh = false});

  @override
  List<Object?> get props => [forceRefresh];
}

class FilterProjectsByCategoryEvent extends PortfolioEvent {
  final String category; // 'All' or specific category
  const FilterProjectsByCategoryEvent(this.category);

  @override
  List<Object?> get props => [category];
}

class SubmitContactMessageEvent extends PortfolioEvent {
  final String name;
  final String email;
  final String subject;
  final String message;

  const SubmitContactMessageEvent({
    required this.name,
    required this.email,
    required this.subject,
    required this.message,
  });

  @override
  List<Object?> get props => [name, email, subject, message];
}
