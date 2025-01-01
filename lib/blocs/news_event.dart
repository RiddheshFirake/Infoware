// news_event.dart
import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object?> get props => [];
}

class FetchNewsEvent extends NewsEvent {}

class SearchNewsEvent extends NewsEvent {
  final String query;

  const SearchNewsEvent(this.query); // Ensure the constructor is constant

  @override
  List<Object?> get props => [query]; // Add query to the props for Equatable comparison
}
