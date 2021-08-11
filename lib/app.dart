import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/blocs/favourites/favourite_bloc.dart';
import 'package:news_app/blocs/news/news_bloc.dart';
import 'package:news_app/database/database_helper.dart';
import 'package:news_app/misc/mappers/database/article_mapper.dart';
import 'package:news_app/misc/mappers/network/news_mapper.dart';
import 'package:news_app/network/rest_client.dart';
import 'package:news_app/repositories/news_repository.dart';

import 'pages/home_page.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          lazy: false,
            create: (_) => DatabaseHelper()),
        RepositoryProvider(
          lazy: false,
          create: (context) => NewsRepository(
              restClient: RestClient(),
              newsMapper: NewsMapper(),
            connectivity: Connectivity(),
            articleMapper: ArticleMapper(),
            databaseHelper: context.read<DatabaseHelper>()
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  NewsBloc(newsRepository: context.read<NewsRepository>())
                    ..fetchNews()),
          BlocProvider(
            create: (context) =>
            FavouriteBloc(newsRepository: context.read<NewsRepository>())
            ..fetchFavourites(),
          )
        ],
        child: MaterialApp(
          title: 'News App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: HomePage(),
        ),
      ),
    );
  }
}
