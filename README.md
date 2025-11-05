## ============== TUGAS 7 ==============

### 1. Jelaskan apa itu widget tree pada Flutter dan bagaimana hubungan parent-child (induk-anak) bekerja antar widget

Dalam Flutter, widget tree adalah struktur yang menggambarkan bagaimana setiap widget saling terhubung dan membentuk tampilan aplikasi.
Setiap elemen seperti teks, tombol, atau ikon adalah bagian dari pohon widget ini.

Hubungan parent–child (induk–anak) berarti:

* Parent adalah widget yang membungkus widget lain dan mengatur tata letak atau perilakunya.
* Child adalah widget yang berada di dalam parent dan menampilkan isi tertentu.

Pada proyek saya, struktur widget nya seperti ini:

Scaffold
 ├── AppBar
 └── Body (Padding)
      └── Column
           ├── Row → [InfoCard (NPM), InfoCard (Name), InfoCard (Class)]
           ├── Text ("Selamat datang di Kick n Cart")
           └── GridView → [_ActionCard (All Products), _ActionCard (My Products), _ActionCard (Create Product)]

Contohnya:

* Scaffold menjadi induk dari AppBar dan Body.
* Column menata widget secara vertikal dari atas ke bawah.
* Row menampilkan tiga InfoCard secara horizontal.
* GridView berisi tiga tombol utama dengan warna dan ikon yang berbeda.

Dengan konsep ini, setiap widget di Flutter memiliki posisi dan peran dalam hierarki yang saling terhubung untuk membentuk satu tampilan utuh.

---

### 2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya

| Widget                          | Fungsi                                                                                   |
| ------------------------------- | ---------------------------------------------------------------------------------------- |
| **MaterialApp**                 | Sebagai pembungkus utama aplikasi. Mengatur tema, warna, dan halaman awal (home).        |
| **Scaffold**                    | Struktur utama halaman yang menyediakan area untuk AppBar, Body, dan SnackBar.           |
| **AppBar**                      | Menampilkan judul aplikasi “Kick n Cart” di bagian atas layar.                           |
| **Padding**                     | Memberi jarak di sekitar konten agar tidak menempel pada tepi layar.                     |
| **Column**                      | Menyusun widget secara vertikal dari atas ke bawah.                                      |
| **Row**                         | Menampilkan tiga InfoCard secara horizontal di dalam satu baris.                         |
| **Expanded**                    | Membagi ruang pada Row agar ketiga InfoCard memiliki ukuran seimbang.                    |
| **SizedBox**                    | Memberikan jarak antar elemen seperti antara kartu dan teks.                             |
| **Card**                        | Menampilkan informasi (NPM, Nama, Kelas) dalam tampilan berbentuk kartu dengan bayangan. |
| **Text**                        | Menampilkan teks seperti nama, NPM, kelas, dan teks sambutan.                            |
| **GridView.count**              | Menampilkan tiga tombol utama dalam bentuk grid dengan tiga kolom.                       |
| **Material**                    | Memberikan efek Material Design agar tombol memiliki efek bayangan dan interaktif.       |
| **InkWell**                     | Mendeteksi klik/tap pada tombol dan menampilkan efek gelombang (ripple).                 |
| **Icon**                        | Menampilkan ikon di atas teks pada setiap tombol.                                        |
| **SnackBar**                    | Menampilkan pesan singkat di bagian bawah layar ketika tombol ditekan.                   |
| **ScaffoldMessenger**           | Mengakses Scaffold terdekat untuk menampilkan SnackBar.                                  |
| **InfoCard** (custom)           | Widget buatan sendiri untuk menampilkan informasi mahasiswa.                             |
| **_ActionCard** (custom)        | Widget buatan sendiri untuk menampilkan tombol berwarna dengan ikon dan teks.            |
| **_ButtonSpec** (model class)   | Kelas untuk menyimpan data tombol seperti label, ikon, warna, dan pesan SnackBar.        |

---

### 3. Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini sering digunakan sebagai widget root

MaterialApp berfungsi sebagai titik awal aplikasi Flutter yang menggunakan desain Material Design.
Widget ini mengatur berbagai hal penting seperti tema, warna, navigasi, dan halaman awal aplikasi.

Contoh penggunaan di proyek saya:

MaterialApp(
  debugShowCheckedModeBanner: false,
  title: 'Kick n Cart',
  theme: ThemeData(
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
        .copyWith(secondary: Colors.blueAccent),
    useMaterial3: true,
  ),
  home: const MyHomePage(),
);

MaterialApp penting karena:

* Menentukan tampilan global aplikasi melalui tema dan warna.
* Menyediakan context untuk widget seperti Scaffold, AppBar, dan SnackBar.
* Mengatur navigasi antar halaman dalam aplikasi.

Tanpa MaterialApp, banyak widget Flutter tidak bisa berfungsi dengan benar karena tidak memiliki konteks global atau tema bawaan.

---

### 4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget. Kapan kamu memilih salah satunya

StatelessWidget adalah widget yang tidak memiliki state (data yang dapat berubah).
Tampilannya bersifat tetap dan tidak akan berubah selama aplikasi berjalan.
Contohnya pada proyek ini adalah MyHomePage, InfoCard, dan _ActionCard karena semuanya hanya menampilkan data tanpa perubahan nilai.

Sedangkan StatefulWidget adalah widget yang memiliki state dan dapat berubah sesuai interaksi pengguna atau data baru.
Contohnya seperti form input, counter, atau tampilan yang berubah secara dinamis dengan setState().

Dalam proyek saya, hanya digunakan StatelessWidget karena tampilan bersifat statis dan tidak memerlukan pembaruan data.

---

### 5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di metode build

BuildContext adalah objek yang menunjukkan posisi sebuah widget di dalam struktur widget tree.
Objek ini sangat penting karena memungkinkan widget untuk berinteraksi dengan lingkungan sekitarnya seperti tema, ukuran layar, atau komponen induk lainnya.

Dalam proyek saya, context digunakan untuk menampilkan pesan saat tombol ditekan menggunakan SnackBar, seperti berikut:

ScaffoldMessenger.of(context)
  ..hideCurrentSnackBar()
  ..showSnackBar(
    SnackBar(content: Text(b.snackbarText)),
  );

Kode ini memberi tau Flutter bahwa _ActionCard berada di dalam Scaffold, sehingga SnackBar bisa muncul pada halaman yang sesuai.
Secara singkat, BuildContext berfungsi sebagai penghubung antara widget dan struktur aplikasi di sekitarnya.

---

### 6. Jelaskan konsep "hot reload" di Flutter dan bagaimana bedanya dengan "hot restart"

Hot reload adalah fitur Flutter yang memungkinkan kita melihat perubahan kode secara langsung tanpa kehilangan data atau posisi tampilan.
Misalnya, jika kita mengubah teks atau warna tombol di proyek, hasilnya akan langsung muncul di emulator tanpa menjalankan ulang aplikasi.

Sedangkan hot restart menjalankan ulang seluruh aplikasi dari awal dan menghapus semua data atau state yang tersimpan.
Semua variabel dan tampilan akan kembali seperti semula, seolah aplikasi baru saja dibuka.

Perbedaan utamanya:

* Hot reload: cepat, mempertahankan data, cocok untuk perubahan tampilan kecil.
* Hot restart: memulai ulang sepenuhnya, digunakan untuk perubahan besar seperti menambah variabel atau mengubah struktur utama aplikasi.