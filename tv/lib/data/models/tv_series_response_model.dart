import 'dart:convert';
import 'package:tv/tv.dart';
import 'package:equatable/equatable.dart';

TvResponse tvSeriesResponseFromJson(String str) =>
    TvResponse.fromJson(json.decode(str));

String tvSeriesResponseToJson(TvResponse data) => json.encode(data.toJson());

class TvResponse extends Equatable {
  TvResponse({
    this.page,
    required this.results,
    this.totalPages,
    this.totalResults,
  });

  final int? page;
  final List<TvModel> results;
  final int? totalPages;
  final int? totalResults;

  factory TvResponse.fromJson(Map<String, dynamic> json) => TvResponse(
        page: json["page"],
        results: List<TvModel>.from((json["results"] as List)
            .map((x) => TvModel.fromJson(x))
            .where((element) => element.posterPath != null)),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };

  @override
  List<Object?> get props => [results];
}
