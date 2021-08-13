import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/blocs/favourites/favourite_bloc.dart';
import 'package:news_app/blocs/news/news_bloc.dart';
import 'package:news_app/database/dao/articles_dao.dart';
import 'package:news_app/database/dao/favourites_dao.dart';
import 'package:news_app/database/database_helper.dart';
import 'package:news_app/misc/mappers/database/article_mapper.dart';
import 'package:news_app/misc/mappers/database/favourite_mapper.dart';
import 'package:news_app/misc/mappers/network/news_mapper.dart';
import 'package:news_app/network/rest_client.dart';
import 'package:news_app/repositories/favourite_repository.dart';
import 'package:news_app/repositories/news_repository.dart';
import 'package:provider/provider.dart';

import 'pages/home_page.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      Provider(create:(_) => DatabaseHelper() ),
      Provider(create:(context) => ArticlesDAO(context.read()) ),
      Provider(create:(context) => FavouritesDAO(context.read()) ),

      
    ], child: MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          lazy: false,
          create: (context) => NewsRepository(
              restClient: RestClient(),
              newsMapper: NewsMapper(),
              connectivity: Connectivity(),
              articleMapper: ArticleMapper(),
              articlesDao: context.read<ArticlesDAO>()),
        ),
        RepositoryProvider(
            create: (context) => FavouriteRepository(
                favouritesDao: context.read<FavouritesDAO>(),
                favouriteMapper: FavouriteMapper()))
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
              NewsBloc(newsRepository: context.read<NewsRepository>())
                ..fetchNews()),
          BlocProvider(
            create: (context) =>
            FavouriteBloc(favouriteRepository: context.read<FavouriteRepository>())
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
    ),);
  }
}
