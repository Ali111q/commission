extension StringExtension on String {
  String addCommas() {
    String reversed = this.split('').reversed.join('');
    String withCommas = reversed.replaceAllMapped(
        RegExp(r".{3}"), (match) => "${match.group(0)},");
    return withCommas.split('').reversed.join('');
  }
}
