import 'package:freezed_annotation/freezed_annotation.dart';

part 'cycle_prediction_model.freezed.dart';
part 'cycle_prediction_model.g.dart';

/// App-level model for a predicted upcoming cycle.
///
/// Produced by [CyclePredictionService.predictNextCycle]. Null is returned
/// by that service when fewer than 3 completed cycles are available.
/// The fertile window is the 5-day window centred on ovulation day
/// (ovulation_day - 2 to ovulation_day + 2).
@freezed
abstract class CyclePredictionModel with _$CyclePredictionModel {
  const factory CyclePredictionModel({
    /// Predicted start date of the next period.
    required DateTime predictedStart,

    /// Predicted end date of the next period.
    required DateTime predictedEnd,

    /// First day of the predicted fertile window.
    required DateTime fertileWindowStart,

    /// Last day of the predicted fertile window.
    required DateTime fertileWindowEnd,

    /// Confidence score in the range [0.0, 1.0].
    /// Derived from cycle regularity (std-dev of historical lengths).
    required double confidence,

    /// True if the user's cycle history shows high variability (std_dev > 5 days).
    @Default(false) bool isIrregular,
  }) = _CyclePredictionModel;

  factory CyclePredictionModel.fromJson(Map<String, dynamic> json) =>
      _$CyclePredictionModelFromJson(json);
}
