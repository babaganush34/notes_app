import 'package:drift/drift.dart';

class Notes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 50)();
  TextColumn get content => text().named('body')();
  DateTimeColumn get date => dateTime().withDefault(currentDateAndTime)();
}
