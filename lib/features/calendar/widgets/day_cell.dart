import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/enums/cycle_phase.dart';
import '../../../data/models/day_data_model.dart';
import '../../../services/cycle/phase_calculator.dart';

/// A single calendar day cell for [CycleCalendar].
///
/// Phase-tinted circle (confirmed 20% alpha, predicted 30% alpha).
/// Today: primary purple ring. Selected: filled primary circle.
/// Predicted: dashed arc border via [CustomPainter].
/// Period dot = AppColors.menstrual. Symptoms-only dot = textSecondary.
class DayCell extends StatelessWidget {
  const DayCell({
    super.key,
    required this.day,
    required this.dayData,
    required this.isSelected,
    required this.isToday,
    required this.isOutsideMonth,
  });

  final DateTime day;
  final DayDataModel? dayData;
  final bool isSelected;
  final bool isToday;
  final bool isOutsideMonth;

  Color _phaseFill(CyclePhase phase, bool predicted) {
    if (predicted) {
      return PhaseCalculator.getPhaseColorPredicted(phase).withAlpha(77);
    }
    return PhaseCalculator.getPhaseColor(phase).withAlpha(51);
  }

  Color _phaseBorder(CyclePhase phase, bool predicted) {
    if (predicted) {
      return PhaseCalculator.getPhaseColorPredicted(phase).withAlpha(128);
    }
    return PhaseCalculator.getPhaseColor(phase).withAlpha(153);
  }

  @override
  Widget build(BuildContext context) {
    final phase = dayData?.phase;
    final isPredicted = dayData?.isPredicted ?? false;
    final hasPeriod = dayData?.periodLog != null;
    final hasSymptoms =
        (dayData?.symptomEntries.isNotEmpty ?? false) && !hasPeriod;

    final phaseColor = phase != null
        ? _phaseFill(phase, isPredicted)
        : Colors.transparent;
    final borderColor = phase != null
        ? _phaseBorder(phase, isPredicted)
        : Colors.transparent;

    return Opacity(
      opacity: isOutsideMonth ? 0.35 : 1.0,
      child: Semantics(
        label: _semanticLabel(),
        button: true,
        selected: isSelected,
        // excludeSemantics: true prevents child widgets from creating redundant
        // semantic nodes. The label above already describes all visual content.
        excludeSemantics: true,
        child: SizedBox(
          width: AppSizes.calendarDaySize,
          height: AppSizes.calendarDaySize,
          child: Stack(
            alignment: Alignment.center,
            children: [
              _PhaseBackground(
                phaseColor: phaseColor,
                borderColor: borderColor,
                isPredicted: isPredicted && phase != null,
                isSelected: isSelected,
                isToday: isToday,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 2),
                  Text(
                    '${day.day}',
                    style: AppTypography.body2.copyWith(
                      fontWeight: isToday || isSelected
                          ? FontWeight.w600
                          : FontWeight.w400,
                      color: _numberColor(phase),
                    ),
                  ),
                  const SizedBox(height: 2),
                  _DotIndicator(
                    hasPeriod: hasPeriod,
                    hasSymptoms: hasSymptoms,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _numberColor(CyclePhase? phase) {
    if (isSelected) return AppColors.surface;
    if (isToday && phase == null) return AppColors.primary;
    return AppColors.textPrimary;
  }

  String _semanticLabel() {
    final buf = StringBuffer('${day.day}');
    final ph = dayData?.phase;
    if (ph != null) buf.write(', ${ph.description}');
    if (dayData?.periodLog != null) buf.write(', period logged');
    if (dayData?.symptomEntries.isNotEmpty ?? false) {
      buf.write(', symptoms logged');
    }
    if (dayData?.isPredicted ?? false) buf.write(', predicted');
    if (isToday) buf.write(', today');
    if (isSelected) buf.write(', selected');
    return buf.toString();
  }
}

// ---------------------------------------------------------------------------
// _PhaseBackground
// ---------------------------------------------------------------------------

class _PhaseBackground extends StatelessWidget {
  const _PhaseBackground({
    required this.phaseColor,
    required this.borderColor,
    required this.isPredicted,
    required this.isSelected,
    required this.isToday,
  });

  final Color phaseColor;
  final Color borderColor;
  final bool isPredicted;
  final bool isSelected;
  final bool isToday;

  @override
  Widget build(BuildContext context) {
    const sz = AppSizes.calendarDaySize;
    if (isSelected) {
      return SizedBox(
        width: sz,
        height: sz,
        child: CustomPaint(
            painter: _SelectedDayPainter(phaseColor: phaseColor)),
      );
    }
    if (isToday) {
      return _PulsingTodayCell(sz: sz, phaseColor: phaseColor);
    }
    if (phaseColor != Colors.transparent) {
      if (isPredicted) {
        return SizedBox(
          width: sz,
          height: sz,
          child: CustomPaint(
            painter: _PredictedDayPainter(
              fillColor: phaseColor,
              borderColor: borderColor,
            ),
          ),
        );
      }
      return SizedBox(
        width: sz,
        height: sz,
        child: CustomPaint(
            painter: _ConfirmedDayPainter(fillColor: phaseColor)),
      );
    }
    return const SizedBox(width: sz, height: sz);
  }
}

// ---------------------------------------------------------------------------
// _DotIndicator
// ---------------------------------------------------------------------------

class _DotIndicator extends StatelessWidget {
  const _DotIndicator({required this.hasPeriod, required this.hasSymptoms});

  final bool hasPeriod;
  final bool hasSymptoms;

  @override
  Widget build(BuildContext context) {
    if (!hasPeriod && !hasSymptoms) {
      return const SizedBox(height: AppSizes.symptomDotSize);
    }
    return Container(
      width: AppSizes.symptomDotSize,
      height: AppSizes.symptomDotSize,
      decoration: BoxDecoration(
        color: hasPeriod ? AppColors.menstrual : AppColors.textSecondary,
        shape: BoxShape.circle,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// CustomPainters
// ---------------------------------------------------------------------------

class _ConfirmedDayPainter extends CustomPainter {
  _ConfirmedDayPainter({required this.fillColor});
  final Color fillColor;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2 - 1,
      Paint()..color = fillColor,
    );
  }

  @override
  bool shouldRepaint(_ConfirmedDayPainter o) => o.fillColor != fillColor;
}

class _PredictedDayPainter extends CustomPainter {
  _PredictedDayPainter({required this.fillColor, required this.borderColor});
  final Color fillColor;
  final Color borderColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 2;
    canvas.drawCircle(center, radius, Paint()..color = fillColor);
    const pi = 3.141592653589793;
    const dashLen = 4.0;
    const gapLen = 3.0;
    final circumference = 2 * pi * radius;
    final dashCount = (circumference / (dashLen + gapLen)).floor();
    if (dashCount == 0) return;
    final angleStep = 2 * pi / dashCount;
    final dashAngle = angleStep * (dashLen / (dashLen + gapLen));
    final strokePaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    for (var i = 0; i < dashCount; i++) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        i * angleStep - pi / 2,
        dashAngle,
        false,
        strokePaint,
      );
    }
  }

  @override
  bool shouldRepaint(_PredictedDayPainter o) =>
      o.fillColor != fillColor || o.borderColor != borderColor;
}


// ---------------------------------------------------------------------------
// _PulsingTodayCell
// ---------------------------------------------------------------------------

/// Animated wrapper for the today cell that shows a subtle ring pulse.
///
/// Uses a single [AnimationController] ticking at 1.5s period with an
/// opacity sine from 0.5 to 1.0 -- cheap: no layout, no repaint cascade.
class _PulsingTodayCell extends StatefulWidget {
  const _PulsingTodayCell({required this.sz, required this.phaseColor});

  final double sz;
  final Color phaseColor;

  @override
  State<_PulsingTodayCell> createState() => _PulsingTodayCellState();
}

class _PulsingTodayCellState extends State<_PulsingTodayCell>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _opacity = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _opacity,
      builder: (_, __) => Opacity(
        opacity: _opacity.value,
        child: SizedBox(
          width: widget.sz,
          height: widget.sz,
          child: CustomPaint(
              painter: _TodayRingPainter(phaseColor: widget.phaseColor)),
        ),
      ),
    );
  }
}

class _TodayRingPainter extends CustomPainter {
  _TodayRingPainter({required this.phaseColor});
  final Color phaseColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 2;
    if (phaseColor != Colors.transparent) {
      canvas.drawCircle(center, radius, Paint()..color = phaseColor);
    }
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = AppColors.primary
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0,
    );
  }

  @override
  bool shouldRepaint(_TodayRingPainter o) => o.phaseColor != phaseColor;
}

class _SelectedDayPainter extends CustomPainter {
  _SelectedDayPainter({required this.phaseColor});
  final Color phaseColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 1;
    canvas.drawCircle(center, radius, Paint()..color = AppColors.primary);
    if (phaseColor != Colors.transparent) {
      canvas.drawCircle(
        center,
        radius,
        Paint()..color = phaseColor.withAlpha(51),
      );
    }
  }

  @override
  bool shouldRepaint(_SelectedDayPainter o) => o.phaseColor != phaseColor;
}
