import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/widgets/auth_widget/auth_model.dart';
import 'package:themoviedb/widgets/auth_widget/auth_widget.dart';
import 'package:themoviedb/widgets/loader_widget/loader_view_model.dart';
import 'package:themoviedb/widgets/loader_widget/loader_widget.dart';
import 'package:themoviedb/widgets/main_screen/main_screen_widget.dart';
import 'package:themoviedb/widgets/movie_details/movie_details_model.dart';
import 'package:themoviedb/widgets/movie_details/movie_details_widget.dart';
import 'package:themoviedb/widgets/movie_list/movie_list_model.dart';
import 'package:themoviedb/widgets/movie_list/movie_list_widget.dart';
import 'package:themoviedb/widgets/movie_trailer/movie_trailer_widget.dart';
import 'package:themoviedb/widgets/news_list/news_list_widget.dart';
import 'package:themoviedb/widgets/tv_show_list/tv_show_list_widget.dart';

class ScreenFactory {
  Widget makeLoader() {
    return Provider(
      create: (context) => LoaderViewModel(context),
      child: const LoaderWidget(),
      lazy: false,
    );
  }

  Widget makeAuth() {
    return ChangeNotifierProvider(
      create: (_) => AuthViewModel(),
      child: const AuthWidget(),
    );
  }

  Widget makeMainScreen() {
    return  const MainScreenWidget();
  }

  Widget makeMovieDetails(int movieId) {
    return ChangeNotifierProvider(
        create: (_) => MovieDetailsModel(movieId),
        child: const MovieDetailsWidget());
  }

  Widget makeMovieTrailer(String youTubeKey) {
    return MovieTrailerWidget(youTubeKey: youTubeKey);
  }

  Widget makeNewsList() {
    return const NewsListWidget();
  }

  Widget makeMovieList() {
    return ChangeNotifierProvider(
      create: (_) => MovieListViewModel(),
      child: const MovieListWidget(),
    );
  }

  Widget makeTVShowList() {
    return const TVShowListWidget();
  }
}
