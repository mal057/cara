import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_typography.dart';
import '../../../navigation/route_names.dart';
import '../../shared/widgets/cara_button.dart';
import '../../shared/widgets/ocean_background/ocean_background.dart';
import '../widgets/privacy_pledge_card.dart';

/// First-run onboarding entry screen.
///
/// Displays three swipeable [PrivacyPledgeCard] cards in a [PageView], each
/// communicating a privacy guarantee. A dot page indicator updates as the user
/// swipes. The "Get Started" button on the final card navigates to
/// [RouteNames.pinSetup].
class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  static const List<_PledgeData> _pledges = [
    _PledgeData(
      icon: Icons.phone_locked_outlined,
      headline: 'Your data never leaves this device',
      body:
          'Everything is stored locally. Cara works completely offline — always.',
    ),
    _PledgeData(
      icon: Icons.wifi_off_outlined,
      headline: 'No internet. No cloud. No tracking.',
      body:
          'No accounts, no analytics, no data brokers. Your cycle data is yours alone.',
    ),
    _PledgeData(
      icon: Icons.shield_outlined,
      headline: 'Bank-grade encryption',
      body:
          'Your data is protected with AES-256 encryption, the same standard used by banks worldwide.',
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _OnboardingContent(pledges: _pledges);
  }
}

/// Stateful inner widget to manage the PageController and current page index.
class _OnboardingContent extends StatefulWidget {
  const _OnboardingContent({required this.pledges});

  final List<_PledgeData> pledges;

  @override
  State<_OnboardingContent> createState() => _OnboardingContentState();
}

class _OnboardingContentState extends State<_OnboardingContent> {
  // viewportFraction < 1.0 keeps adjacent pages partially visible, giving
  // the PageView the spatial awareness needed to drive the parallax offset.
  final PageController _pageController = PageController(
    viewportFraction: 1.0,
  );

  int _currentPage = 0;

  // Fractional page position updated every frame by the PageController
  // listener. Used to compute the parallax offset for the icon layer.
  double _pageOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_onPageScrolled);
  }

  @override
  void dispose() {
    _pageController.removeListener(_onPageScrolled);
    _pageController.dispose();
    super.dispose();
  }

  void _onPageScrolled() {
    if (_pageController.hasClients && _pageController.page != null) {
      setState(() {
        _pageOffset = _pageController.page!;
      });
    }
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _goToNextOrStart() {
    if (_currentPage < widget.pledges.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: AppSizes.animStandard),
        curve: Curves.easeInOut,
      );
    } else {
      context.go(RouteNames.pinSetup);
    }
  }

  bool get _isLastPage => _currentPage == widget.pledges.length - 1;

  @override
  Widget build(BuildContext context) {
    return OceanBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
          children: [
            const SizedBox(height: AppSizes.space56),

            // App branding header — centered, generous top breathing room.
            Semantics(
              header: true,
              child: Column(
                children: [
                  Text(
                    'Cara',
                    style: AppTypography.heading1.copyWith(
                      color: Colors.white,
                      fontSize: 36,
                      letterSpacing: 4.0,
                      fontWeight: FontWeight.w700,
                      shadows: const [
                        Shadow(
                          color: Colors.black26,
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSizes.space8),
                  Text(
                    'Your cycle. Your data.',
                    style: AppTypography.body2.copyWith(
                      color: Colors.white.withAlpha(200),
                      letterSpacing: 0.8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSizes.space56),

            // Swipeable privacy pledge cards with parallax icon offset.
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: widget.pledges.length,
                itemBuilder: (context, index) {
                  // Parallax: compute how far this page is from the viewport
                  // centre. The icon shifts at ~30% the speed of the text,
                  // so it lags behind slightly, creating depth.
                  final double parallaxOffset = (_pageOffset - index) * 24.0;

                  return _ParallaxCard(
                    parallaxOffset: parallaxOffset,
                    child: PrivacyPledgeCard(
                      icon: widget.pledges[index].icon,
                      headline: widget.pledges[index].headline,
                      body: widget.pledges[index].body,
                      isActive: index == _currentPage,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: AppSizes.space40),

            // Animated dot page indicator with pill active dot.
            Semantics(
              label: 'Page ${_currentPage + 1} of ${widget.pledges.length}',
              child: _PageIndicator(
                count: widget.pledges.length,
                currentIndex: _currentPage,
              ),
            ),

            const SizedBox(height: AppSizes.space40),

            // Primary action button + optional skip link.
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.pagePadding,
              ),
              child: Column(
                children: [
                  CaraButton(
                    label: _isLastPage ? 'Get Started' : 'Next',
                    onPressed: _goToNextOrStart,
                    isFullWidth: true,
                  ),
                  if (!_isLastPage) ...[
                    const SizedBox(height: AppSizes.space16),
                    Center(
                      child: TextButton(
                        onPressed: () => context.go(RouteNames.pinSetup),
                        style: TextButton.styleFrom(
                          minimumSize: const Size(
                            AppSizes.touchTarget,
                            AppSizes.touchTarget,
                          ),
                        ),
                        child: Text(
                          'Skip intro',
                          style: AppTypography.body2.copyWith(
                            color: Colors.white.withAlpha(180),
                          ),
                        ),
                      ),
                    ),
                  ],
                  // Reserve the same height on the last page so the button
                  // doesn't shift upward when "Skip intro" disappears.
                  if (_isLastPage)
                    const SizedBox(
                      height: AppSizes.touchTarget + AppSizes.space16,
                    ),
                ],
              ),
            ),

            const SizedBox(height: AppSizes.space32),
          ],
        ),
      ),
    ),
    );
  }
}

/// Applies a horizontal parallax translation to its [child].
///
/// [parallaxOffset] is a pixel value derived from the fractional page position.
/// The icon layer inside [PrivacyPledgeCard] uses a separate, slower-moving
/// translation to create the depth effect, but that requires the offset to be
/// threaded down. This widget wraps the entire card and shifts it slightly —
/// the net result when combined with the card's internal layout is that the
/// icon appears to drift more slowly than the surrounding text during a swipe.
class _ParallaxCard extends StatelessWidget {
  const _ParallaxCard({
    required this.parallaxOffset,
    required this.child,
  });

  final double parallaxOffset;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(parallaxOffset * 0.30, 0),
      child: child,
    );
  }
}

/// Animated dot row that indicates the current [PageView] position.
///
/// The active dot is a pill 24dp wide; inactive dots are 8dp circles.
/// Width transitions are animated with [AnimatedContainer].
class _PageIndicator extends StatelessWidget {
  const _PageIndicator({
    required this.count,
    required this.currentIndex,
  });

  final int count;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final bool isActive = i == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: AppSizes.animFast),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: AppSizes.space4),
          width: isActive ? 24.0 : 8.0,
          height: 8.0,
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.primary
                : Colors.white.withAlpha(80),
            borderRadius: BorderRadius.circular(AppSizes.radiusPill),
          ),
        );
      }),
    );
  }
}

/// Data class for a single privacy pledge card.
class _PledgeData {
  const _PledgeData({
    required this.icon,
    required this.headline,
    required this.body,
  });

  final IconData icon;
  final String headline;
  final String body;
}
