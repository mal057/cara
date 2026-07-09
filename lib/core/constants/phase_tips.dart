import '../enums/cycle_phase.dart';

/// Curated wellness tips for each cycle phase.
///
/// Tips rotate daily: pick [kPhaseTips][phase][dayInPhase % tips.length].
/// All tips are non-medical, general wellness language only.
const Map<CyclePhase, List<String>> kPhaseTips = {
  CyclePhase.menstrual: [
    'Rest is productive. Your body is doing important work right now.',
    'Warm foods and herbal teas can help ease discomfort.',
    'Light stretching or gentle yoga may relieve cramps.',
    'Honor your need for solitude and quiet reflection today.',
    'Stay hydrated — iron-rich foods can support your energy levels.',
    'This is a good time for journaling and setting intentions.',
    'Cozy up with a heating pad if you need some comfort.',
  ],
  CyclePhase.follicular: [
    'Energy tends to rise during this phase — great time to start something new.',
    'Your brain may feel sharper now. Tackle creative or analytical tasks.',
    'Social energy often increases — plan time with people you enjoy.',
    'A good phase for trying new foods or recipes.',
    'Your body is rebuilding — nourishing foods support this process.',
    'Motivation often peaks here. Make the most of it.',
    'Physical workouts may feel easier and more rewarding this week.',
  ],
  CyclePhase.ovulatory: [
    'Communication often feels easier around this time.',
    'You may notice increased confidence — lean into it.',
    'A great time for important conversations or presentations.',
    'Social energy is often at its peak during ovulation.',
    'Your body is working hard — stay well-nourished and hydrated.',
    'Creative energy tends to peak in this phase.',
    'High-intensity workouts may feel particularly satisfying now.',
  ],
  CyclePhase.luteal: [
    'It is okay to slow down and turn inward.',
    'Cravings for comfort foods are normal — nourish yourself kindly.',
    'Gentle movement like walking or swimming can ease PMS symptoms.',
    'Magnesium-rich foods (dark chocolate, nuts, leafy greens) may help.',
    'Prioritise sleep — your body needs extra rest right now.',
    'Reducing caffeine and sugar can help stabilise your mood.',
    'This is a great time for finishing projects rather than starting new ones.',
    'Warmth and self-compassion go a long way during this phase.',
  ],
};
