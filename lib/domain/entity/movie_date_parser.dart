DateTime? parseMovieDateFromString(String? rawDate) {
  if (rawDate == null || rawDate.trim().isEmpty) {
    print('rawData: $rawDate.toString()');
    return null;
  }
  return DateTime.tryParse(rawDate);
}
