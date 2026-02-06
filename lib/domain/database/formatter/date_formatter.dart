String formatNoteDate(DateTime date) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final noteDate = DateTime(date.year, date.month, date.day);

  String time = "${date.hour}:${date.minute.toString().padLeft(2, '0')}";

  if (noteDate == today) {
    return "Сегодня • $time";
  } else {
    return "${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')} • $time";
  }
}
