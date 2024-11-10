class PaggingModel<T> {
  final int page;
  final int totalPages;
  final List<T> data;

  PaggingModel({
    required this.page,
    required this.totalPages,
    required this.data,
  });

  factory PaggingModel.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJson) {
    return PaggingModel(
      page: json['currentPage'] as int,
      totalPages: json['pagesCount'] as int,
      data: (json['data'] as List<dynamic>)
          .map((item) => fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
