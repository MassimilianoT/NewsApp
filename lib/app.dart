import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/blocs/news/news_bloc.dart';
import 'package:news_app/misc/mappers/news_mapper.dart';
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
          create: (_) => NewsRepository(
              restClient: RestClient(), newsMapper: NewsMapper()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  NewsBloc(newsRepository: context.read<NewsRepository>())
                    ..fetchNews())
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
