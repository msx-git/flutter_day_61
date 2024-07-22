extension StringExtensions on String {
  String extractImageUrl() {
    if (startsWith('[') && endsWith(']')) {
      // Remove brackets and quotes
      return substring(1, length - 2).replaceAll('"', '');
    }
    return this; // Return original string if not a valid format
  }
}