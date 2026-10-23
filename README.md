<div align="center">
  <img src="assets/images/quiz_hero.svg" alt="Ilustrasi RuangKuis" width="340">

  # RuangKuis

  **Kuis singkat, wawasan baru.**

  Aplikasi kuis pilihan ganda lintas platform, dibuat dengan Flutter untuk UTS
  Lab Praktikum Pemrograman Mobile.
</div>

<br>

## Profil Mahasiswa

| Keterangan | Detail |
| --- | --- |
| Nama | David Jonathan Simanjuntak |
| NIM | 241401121 |
| Lab | Lab Pemrograman Mobile 1 |

## Tentang Aplikasi

RuangKuis mengajak pemain menguji pengetahuan melalui kuis lokal yang ringan
dan interaktif. Masukkan nama, pilih topik, jawab pertanyaan, lalu lihat skor
beserta pembahasan untuk setiap soal.

## Fitur

- **Tiga topik kuis:** Pengetahuan Umum, Teknologi, dan Sains & Alam.
- **Soal diacak per sesi:** urutan soal diacak ketika sesi kuis dimulai.
- **Progres dan skor langsung:** lihat perjalanan kuis dan jumlah jawaban benar.
- **Pembahasan jawaban:** tinjau pilihan, kunci jawaban, dan penjelasan setelah
  menyelesaikan kuis.
- **Progres tersimpan selama sesi:** jawaban tetap tersedia saat kembali ke
  kuis atau membuka halaman hasil dan tinjauan.
- **Light dan Dark Mode:** pilih tampilan sesuai kenyamanan.
- **Tampilan adaptif:** mendukung ukuran layar ponsel, tablet, dan browser.
- **Aset lokal:** ilustrasi SVG dan font Manrope disertakan di proyek.

## Tampilan

Ilustrasi lokal aplikasi:

![Ilustrasi RuangKuis](assets/images/quiz_hero.svg)

## Teknologi

- Flutter dan Dart
- Material 3
- State terpusat dengan `ChangeNotifier` dan `InheritedNotifier`
- Font Manrope dan ilustrasi SVG lokal

## Menjalankan Proyek

Pastikan Flutter SDK sudah terpasang, kemudian dari direktori proyek jalankan:

```bash
flutter pub get
flutter run
```

Untuk menjalankan aplikasi di browser Chrome:

```bash
flutter run -d chrome
```

## Pemeriksaan Kualitas

```bash
flutter analyze
flutter test
```

## Struktur Direktori

```text
lib/
├── app/        # Pengelola state, scope, dan tema
├── data/       # Bank soal dan topik kuis
├── models/     # Model pertanyaan dan topik
├── screens/    # Halaman beranda, kuis, hasil, dan tinjauan
└── widgets/    # Komponen UI reusable
assets/
├── fonts/      # Font Manrope dan lisensinya
└── images/     # Ilustrasi aplikasi
test/           # Tes controller dan alur aplikasi
```
