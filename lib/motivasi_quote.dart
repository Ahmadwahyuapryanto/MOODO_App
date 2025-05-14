import 'dart:math';

class MotivasiQuote {
  final List<String> _motivationalQuotes = [
    'Setiap langkah kecil tetap membuat kemajuan.',
    'Jangan menyerah, terus maju!',
    'Kesuksesan dimulai dari niat yang kuat.',
    'Hari ini adalah kesempatan baru.',
    'Kerja keras akan membuahkan hasil.',
    'Percaya pada dirimu sendiri.',
    'Setiap usaha pasti ada hasilnya.',
    'Jangan takut gagal, itu bagian dari belajar.',
    'Semangat adalah kunci keberhasilan.',
    'Bersyukurlah atas setiap kemajuan kecil.',
  ];

  String _currentQuote = 'Setiap langkah kecil tetap membuat kemajuan.';

  String get currentQuote => _currentQuote;

  void showRandomQuote() {
    final random = Random();
    String newQuote;
    do {
      newQuote = _motivationalQuotes[random.nextInt(_motivationalQuotes.length)];
    } while (newQuote == _currentQuote);
    _currentQuote = newQuote;
  }
}