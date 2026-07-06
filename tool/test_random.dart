import 'dart:math';
void main() {
  for (int i = 0; i < 7; i++) {
    final now = DateTime(2026, 7, 1 + i);
    final seed = now.year * 10000 + now.month * 100 + now.day;
    final random = Random(seed);
    final channel = random.nextInt(5);
    final video = random.nextInt(4);
    print('Day ${now.day}: channel=$channel, video=$video');
  }
}
