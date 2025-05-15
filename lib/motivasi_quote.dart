import 'dart:math';

class MotivasiQuote {
  final List<String> _motivationalQuotes = [
    'Setiap langkah kecil tetap membuat kemajuan.',
    'Mulai dulu, biar stres-nya punya alasan.',
    'Kesuksesan dimulai dari niat yang kuat.',
    'Kamu tidak perlu menyelesaikan semuanya sekaligus. Cukup mulai, dan biarkan semangat mengikuti.',
    'Kerja keras akan membuahkan hasil.',
    'Tugas mungkin berat, tapi kamu lebih kuat. Buktiin!, Percaya pada dirimu sendiri.',
    'Tugas memang berat... tapi IPK lebih berat kalau diabaikan.',
    'Jangan takut gagal, itu bagian dari belajar.',
    'Semangat adalah kunci keberhasilan.',
    'Bersyukurlah atas setiap kemajuan kecil.',
    'Tugasmu menunggu, bukan untuk ditinggal ngopi terus.',
    'Tugas nggak bakal selesai kalau cuma dilihatin, Tunda boleh, tapi jangan lupa kembali.',
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