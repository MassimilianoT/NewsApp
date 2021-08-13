import 'package:news_app/database/database_helper.dart';

abstract class AbstractDAO{
  final DatabaseHelper databaseHelper;

  AbstractDAO(this.databaseHelper);

}