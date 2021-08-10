import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/blocs/news/news_bloc.dart';
import 'package:news_app/network/rest_client.dart';

import 'pages/home_page.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          lazy: false,
          create: (_) => RestClient(),),],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context)=>
              NewsBloc
                (restClient:
              context.read<RestClient>())..fetchNews())
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
