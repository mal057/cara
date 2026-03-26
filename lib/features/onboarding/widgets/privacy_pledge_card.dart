import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_typography.dart';

/// A single privacy pledge card displayed within the [OnboardingScreen] PageView.
///
/// Each card presents an icon, a headline, and a supporting body text.
/// When [isActive] becomes true, the three elements (icon, headline, body)
/// fade and slide in with a staggered delay to give a soft entrance feel.
class PrivacyPledgeCard extends StatefulWidget {
  const PrivacyPledgeCard({
    super.key,
    required this.icon,
    required this.headline,
    required this.body,
    this.isActive = false,
  });

  /// The icon displayed at the top of the card.
  final IconData icon;

  /// The primary heading text.
  final String headline;

  /// The supporting body text.
  final String body;

  /// Whether this card is the currently visible page. Controls the entrance
  /// animation — elements fade in with a staggered delay when set to true.
  final bool isActive;

  @override
  State<PrivacyPledgeCard> createState() => _PrivacyPledgeCardState();
}

class _PrivacyPledgeCardState extends State<PrivacyPledgeCard>
    with TickerProviderStateMixin {
  // Three separate animation controllers so each element can start at a
  // different offset, creating the staggered entrance effect.
  late final AnimationController _iconController;
  late final AnimationController _headlineController;
  late final AnimationController _bodyController;

  late final Animation<double> _iconFade;
  late final Animation<Offset> _iconSlide;

  late final Animation<double> _headlineFade;
  late final Animation<Offset> _headlineSlide;

  late final Animation<double> _bodyFade;
  late final Animation<Offset> _bodySlide;

  static const Duration _elementDuration =
      Duration(milliseconds: AppSizes.animSlow);

  // Delays between each element's entrance.
  static const Duration _headlineDelay = Duration(milliseconds: 80);
  static const Duration _bodyDelay = Duration(milliseconds: 160);

  @override
  void initState() {
    super.initState();

    _iconController = AnimationController(vsync: this, duration: _elementDuration);
    _headlineController =
        AnimationController(vsync: this, duration: _elementDuration);
    _bodyController =
        AnimationController(vsync: this, duration: _elementDuration);

    _iconFade = CurvedAnimation(
      parent: _iconController,
      curve: Curves.easeOut,
    );
    _iconSlide = Tween<Offset>(
      begin: const Offset(0.0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _iconController, curve: Curves.easeOut));

    _headlineFade = CurvedAnimation(
      parent: _headlineController,
      curve: Curves.easeOut,
    );
    _headlineSlide = Tween<Offset>(
      begin: const Offset(0.0, 0.08),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _headlineController, curve: Curves.easeOut));

    _bodyFade = CurvedAnimation(
      parent: _bodyController,
      curve: Curves.easeOut,
    );
    _bodySlide = Tween<Offset>(
      begin: const Offset(0.0, 0.08),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _bodyController, curve: Curves.easeOut));

    if (widget.isActive) {
      _playEntrance();
    }
  }

  @override
  void didUpdateWidget(PrivacyPledgeCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !oldWidget.isActive) {
      _resetAndPlay();
    } else if (!widget.isActive) {
      // Reset when card leaves view so it plays fresh on return.
      _iconController.reset();
      _headlineController.reset();
      _bodyController.reset();
    }
  }

  void _resetAndPlay() {
    _iconController.reset();
    _headlineController.reset();
    _bodyController.reset();
    _playEntrance();
  }

  Future<void> _playEntrance() async {
    if (!mounted) return;
    _iconController.forward();

    await Future.delayed(_headlineDelay);
    if (!mounted) return;
    _headlineController.forward();

    await Future.delayed(_bodyDelay);
    if (!mounted) return;
    _bodyController.forward();
  }

  @override
  void dispose() {
    _iconController.dispose();
    _headlineController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.space24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon in a 120dp circle with a radial gradient from the primary
          // color at low opacity at the centre fading to transparent at edge.
          FadeTransition(
            opacity: _iconFade,
            child: SlideTransition(
              position: _iconSlide,
              child: Semantics(
                label: widget.headline,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.primary.withAlpha(26), // ~10% opacity centre
                        AppColors.primary.withAlpha(0),  // transparent edge
                      ],
                      stops: const [0.0, 1.0],
                    ),
                  ),
                  child: Icon(
                    widget.icon,
                    size: 56,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: AppSizes.space40),

          // Headline — bold, centered, with gentle letter spacing.
          FadeTransition(
            opacity: _headlineFade,
            child: SlideTransition(
              position: _headlineSlide,
              child: Text(
                widget.headline,
                style: AppTypography.heading2.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          const SizedBox(height: AppSizes.space20),

          // Body — warm gray, centered, constrained width for comfortable
          // reading line length.
          FadeTransition(
            opacity: _bodyFade,
            child: SlideTransition(
              position: _bodySlide,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 280),
                child: Text(
                  widget.body,
                  style: AppTypography.body1.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
