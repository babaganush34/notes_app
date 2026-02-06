import 'package:intl/intl.dart';

String formatNoteDate(DateTime date) {
  return DateFormat('dd.MM.yyyy • HH:mm').format(date);
}