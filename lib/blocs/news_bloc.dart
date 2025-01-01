// blocs/news/news_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infoware/models/news.dart';
import 'package:infoware/repositories/news_repository.dart';
import 'package:infoware/blocs/news_event.dart';

part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository newsRepository;

  NewsBloc({required this.newsRepository}) : super(NewsInitial()) {
    // Fetch News Event
    on<FetchNewsEvent>((event, emit) async {
      emit(NewsLoading());
      try {
        final List<News> news = await newsRepository.fetchNews();
        emit(NewsLoaded(news: news));
      } catch (e) {
        emit(NewsError(message: e.toString()));
      }
    });

    // Search News Event
    on<SearchNewsEvent>((event, emit) async {
      emit(NewsLoading());
      try {
        final List<News> news = await newsRepository.searchNews(event.query);
        emit(NewsLoaded(news: news));
      } catch (e) {
        emit(NewsError(message: e.toString()));
      }
    });
  }
}
