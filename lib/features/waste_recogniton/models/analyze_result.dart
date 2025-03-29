import 'package:json_annotation/json_annotation.dart';

part 'analyze_result.g.dart';

@JsonSerializable()
class AnalyzeResult {
  @JsonKey(name: "waste_name")
  final String wasteName;

  @JsonKey(name: "waste_category")
  final String wasteCategory;

  @JsonKey(name: "recyclable_items")
  final bool isRecycleable;

  @JsonKey(name: "recycle_bin_color")
  final String? recycleBinColor;

  @JsonKey(name: 'additional_notes')
  final List<String> instructions;

  AnalyzeResult({
    required this.wasteName,
    required this.wasteCategory,
    required this.isRecycleable,
    this.recycleBinColor,
    required this.instructions,
  });

  factory AnalyzeResult.fromJson(Map<String, dynamic> json) =>
      _$AnalyzeResultFromJson(json);

  Map<String, dynamic> toJson() => _$AnalyzeResultToJson(this);
}
