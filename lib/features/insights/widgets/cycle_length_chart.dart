import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_typography.dart';
import '../../../data/models/cycle_model.dart';

/// Bar chart showing cycle length variation over the last 6 completed cycles.
class CycleLengthChart extends StatelessWidget {
  const CycleLengthChart({super.key, required this.completedCycles});

  final List<CycleModel> completedCycles;
  static const int _maxBars = 6;

  @override
  Widget build(BuildContext context) {
    final cycles = completedCycles.where((c) => c.cycleLength != null).toList();
    if (cycles.isEmpty) return _buildEmpty();
    final recent = cycles.length > _maxBars ? cycles.sublist(cycles.length - _maxBars) : cycles;
    final lengths = recent.map((c) => c.cycleLength!).toList();
    final maxLen = lengths.reduce((a, b) => a > b ? a : b);
    final minLen = lengths.reduce((a, b) => a < b ? a : b);
    return _buildCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Cycle Length History', style: AppTypography.heading3),
      const SizedBox(height: AppSizes.space4),
      Text('Last ${recent.length} cycles', style: AppTypography.caption.copyWith(color: AppColors.textSecondary)),
      const SizedBox(height: AppSizes.space16),
      SizedBox(height: 120, child: LayoutBuilder(
        builder: (context, constraints) => CustomPaint(
          size: Size(constraints.maxWidth, 120),
          painter: _CycleLengthPainter(lengths: lengths, maxLen: maxLen, minLen: minLen),
        ),
      )),
      const SizedBox(height: AppSizes.space8),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('Oldest', style: AppTypography.caption.copyWith(color: AppColors.textSecondary)),
        Text('Most recent', style: AppTypography.caption.copyWith(color: AppColors.textSecondary)),
      ]),
    ]));
  }

  Widget _buildEmpty() => _buildCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text('Cycle Length History', style: AppTypography.heading3),
    const SizedBox(height: AppSizes.space16),
    Text('Complete cycles will appear here as a bar chart.', style: AppTypography.body2.copyWith(color: AppColors.textSecondary)),
  ]));

  Widget _buildCard({required Widget child}) => Container(
    width: double.infinity, padding: const EdgeInsets.all(AppSizes.cardPadding),
    decoration: BoxDecoration(
      color: AppColors.surface, borderRadius: BorderRadius.circular(AppSizes.radiusCard),
      boxShadow: [BoxShadow(color: AppColors.textPrimary.withAlpha(13), blurRadius: 8, offset: const Offset(0, 2))],
    ),
    child: child,
  );
}

class _CycleLengthPainter extends CustomPainter {
  const _CycleLengthPainter({required this.lengths, required this.maxLen, required this.minLen});
  final List<int> lengths; final int maxLen; final int minLen;

  @override
  void paint(Canvas canvas, Size size) {
    if (lengths.isEmpty) return;
    final bp = Paint()..style = PaintingStyle.fill..color = AppColors.primary.withAlpha(204);
    final ap = Paint()..style = PaintingStyle.stroke..color = AppColors.secondary..strokeWidth = 1.5..strokeCap = StrokeCap.round;
    final n = lengths.length;
    final bw = (size.width - (n - 1) * 8.0) / n;
    final range = maxLen == minLen ? 1.0 : (maxLen - minLen).toDouble();
    final avg = lengths.reduce((a, b) => a + b) / lengths.length;
    final ch = size.height - 20;
    final avgY = size.height - ((avg - minLen) / range).clamp(0.0, 1.0) * ch;
    for (int i = 0; i < n; i++) {
      final frac = (lengths[i] - minLen) / range;
      final bh = frac.clamp(0.0, 1.0) * ch + 20;
      final x = i * (bw + 8.0);
      canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(x, size.height - bh, bw, bh), const Radius.circular(4)), bp);
      final lbl = lengths[i].toString();
      final tp = TextPainter(textDirection: TextDirection.ltr, text: TextSpan(text: lbl, style: const TextStyle(color: AppColors.textSecondary, fontSize: 10, fontWeight: FontWeight.w500)))..layout();
      tp.paint(canvas, Offset(x + (bw - tp.width) / 2, size.height - bh - 14));
    }
    canvas.drawLine(Offset(0, avgY), Offset(size.width, avgY), ap);
  }

  @override
  bool shouldRepaint(_CycleLengthPainter o) => o.lengths != lengths || o.maxLen != maxLen || o.minLen != minLen;
}
