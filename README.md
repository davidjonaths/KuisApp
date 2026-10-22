# RuangKuis

Aplikasi kuis pilihan ganda Flutter untuk UTS Lab Praktikum Pemrograman Mobile.

## Identitas

- Nama: **David Jonathan Simanjuntak**
- NIM: **241401121**
- Lab: **Lab Pemrograman Mobile 1**

## Informasi aplikasi

**Nama aplikasi:** RuangKuis  
**Deskripsi:** Aplikasi kuis interaktif yang meminta nama pemain, menyediakan pilihan topik, memberikan umpan balik jawaban, dan menampilkan skor akhir.

### Fitur

- Tiga topik kuis lokal: Pengetahuan Umum, Teknologi, serta Sains & Alam.
- Lima soal pilihan ganda per topik, indikator progres, dan penjelasan jawaban.
- Skor, jumlah jawaban benar, persentase nilai, serta opsi untuk bermain kembali.
- Tinjau semua jawaban setelah kuis, lengkap dengan kunci jawaban dan penjelasan.
- Navigasi beranda → kuis → hasil; progres dikelola terpusat dan tetap ada saat rotasi atau kembali ke beranda.
- Mode terang/gelap.
- Tampilan adaptif untuk ponsel, tablet, dan browser.
- Widget antarmuka reusable, ilustrasi SVG lokal, dan font Manrope lokal.

## Menjalankan aplikasi

Pastikan Flutter SDK terpasang, lalu jalankan:

```bash
flutter pub get
flutter run
```

Untuk menjalankan versi web:

```bash
flutter run -d chrome
```

Untuk memeriksa analisis dan tes:

```bash
flutter analyze
flutter test
```

## Struktur utama

- `lib/app/`: pengelola state, scope, dan tema.
- `lib/data/`: bank soal dan topik.
- `lib/models/`: model soal dan topik.
- `lib/screens/`: halaman beranda, kuis, dan hasil.
- `lib/widgets/`: komponen UI yang dapat digunakan ulang.
- `assets/`: ilustrasi dan font aplikasi.

## Catatan GitHub

Repositori ini disiapkan untuk pengembangan bertahap dengan commit terpisah per fitur. Setelah identitas dilengkapi, buat repositori GitHub milik mahasiswa dan hubungkan sebagai remote sebelum push.
