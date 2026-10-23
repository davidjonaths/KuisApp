import 'package:flutter/material.dart';

import '../models/quiz_question.dart';
import '../models/quiz_topic.dart';

const quizTopics = <QuizTopic>[
  QuizTopic(
    id: 'general',
    title: 'Pengetahuan Umum',
    subtitle: 'Hal-hal seru di sekitar kita',
    icon: Icons.public_rounded,
    color: Color(0xFF6258E8),
    questions: [
      QuizQuestion(
        prompt: 'Apa ibu kota negara Jepang?',
        options: ['Seoul', 'Tokyo', 'Bangkok', 'Beijing'],
        answerIndex: 1,
        explanation: 'Tokyo adalah ibu kota sekaligus kota terpadat di Jepang.',
      ),
      QuizQuestion(
        prompt: 'Berapa jumlah warna pada pelangi?',
        options: ['Lima', 'Enam', 'Tujuh', 'Delapan'],
        answerIndex: 2,
        explanation: 'Pelangi umumnya dikenal memiliki tujuh warna.',
      ),
      QuizQuestion(
        prompt: 'Hewan darat tercepat di dunia adalah ...',
        options: ['Singa', 'Kuda', 'Cheetah', 'Rusa'],
        answerIndex: 2,
        explanation: 'Cheetah dapat berlari hingga sekitar 100 km/jam dalam jarak pendek.',
      ),
      QuizQuestion(
        prompt: 'Samudra terbesar di bumi bernama ...',
        options: ['Atlantik', 'Hindia', 'Arktik', 'Pasifik'],
        answerIndex: 3,
        explanation:
            'Samudra Pasifik mencakup lebih dari sepertiga permukaan bumi.',
      ),
      QuizQuestion(
        prompt: 'Hari Kemerdekaan Indonesia diperingati setiap ...',
        options: ['1 Juni', '17 Agustus', '28 Oktober', '10 November'],
        answerIndex: 1,
        explanation:
            'Proklamasi kemerdekaan Indonesia dibacakan pada 17 Agustus 1945.',
      ),
    ],
  ),
  QuizTopic(
    id: 'technology',
    title: 'Teknologi',
    subtitle: 'Dunia digital & inovasi',
    icon: Icons.memory_rounded,
    color: Color(0xFF168F83),
    questions: [
      QuizQuestion(
        prompt: 'Kepanjangan dari CPU adalah ...',
        options: [
          'Central Processing Unit',
          'Computer Personal Utility',
          'Core Program Upload',
          'Central Power Usage',
        ],
        answerIndex: 0,
        explanation:
            'CPU adalah unit utama yang memproses instruksi di komputer.',
      ),
      QuizQuestion(
        prompt: 'Bahasa yang umum digunakan untuk menata tampilan halaman web adalah ...',
        options: ['CSS', 'SQL', 'Bash', 'Dart'],
        answerIndex: 0,
        explanation: 'CSS (Cascading Style Sheets) mengatur gaya dan tata letak halaman web.',
      ),
      QuizQuestion(
        prompt: 'Apa fungsi utama RAM pada komputer?',
        options: [
          'Menyimpan data sementara',
          'Mencetak dokumen',
          'Menghubungkan ke listrik',
          'Mendinginkan prosesor',
        ],
        answerIndex: 0,
        explanation:
            'RAM menyimpan data sementara yang sedang digunakan aplikasi.',
      ),
      QuizQuestion(
        prompt: 'Simbol untuk bahasa pemrograman Dart adalah ...',
        options: ['Ular', 'Berang-berang', 'Lumba-lumba', 'Rubah'],
        answerIndex: 1,
        explanation: 'Maskot Dart adalah Dash, seekor berang-berang.',
      ),
      QuizQuestion(
        prompt: 'Kepanjangan URL adalah ...',
        options: [
          'Uniform Resource Locator',
          'Universal Reading Link',
          'United Route Language',
          'Unique Reference Line',
        ],
        answerIndex: 0,
        explanation: 'URL adalah alamat yang digunakan untuk menemukan sumber di internet.',
      ),
    ],
  ),
  QuizTopic(
    id: 'science',
    title: 'Sains & Alam',
    subtitle: 'Temukan keajaiban bumi',
    icon: Icons.eco_rounded,
    color: Color(0xFFE48B45),
    questions: [
      QuizQuestion(
        prompt: 'Planet yang dikenal sebagai Planet Merah adalah ...',
        options: ['Venus', 'Mars', 'Jupiter', 'Merkurius'],
        answerIndex: 1,
        explanation:
            'Permukaan Mars tampak merah karena kandungan oksida besi.',
      ),
      QuizQuestion(
        prompt: 'Tumbuhan menyerap gas apa saat fotosintesis?',
        options: ['Oksigen', 'Helium', 'Karbon dioksida', 'Hidrogen'],
        answerIndex: 2,
        explanation: 'Tumbuhan menggunakan karbon dioksida, air, dan cahaya untuk membuat makanan.',
      ),
      QuizQuestion(
        prompt: 'Organ tubuh yang memompa darah adalah ...',
        options: ['Paru-paru', 'Jantung', 'Lambung', 'Ginjal'],
        answerIndex: 1,
        explanation: 'Jantung memompa darah ke seluruh bagian tubuh.',
      ),
      QuizQuestion(
        prompt: 'Air murni membeku pada suhu ...',
        options: ['0°C', '10°C', '32°C', '100°C'],
        answerIndex: 0,
        explanation: 'Pada tekanan normal, air membeku pada suhu 0°C.',
      ),
      QuizQuestion(
        prompt: 'Sumber energi utama bagi bumi adalah ...',
        options: ['Bulan', 'Matahari', 'Angin', 'Batu bara'],
        answerIndex: 1,
        explanation: 'Cahaya dan panas Matahari menopang sebagian besar kehidupan di bumi.',
      ),
    ],
  ),
];
