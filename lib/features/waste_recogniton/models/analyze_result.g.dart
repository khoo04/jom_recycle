// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analyze_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnalyzeResult _$AnalyzeResultFromJson(Map<String, dynamic> json) =>
    AnalyzeResult(
      wasteName: json['waste_name'] as String,
      wasteCategory: json['waste_category'] as String,
      isRecycleable: json['recyclable_items'] as bool,
      recycleBinColor: json['recycle_bin_color'] as String?,
      instructions: (json['additional_notes'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$AnalyzeResultToJson(AnalyzeResult instance) =>
    <String, dynamic>{
      'waste_name': instance.wasteName,
      'waste_category': instance.wasteCategory,
      'recyclable_items': instance.isRecycleable,
      'recycle_bin_color': instance.recycleBinColor,
      'additional_notes': instance.instructions,
    };
