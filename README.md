## ============== TUGAS 7 ==============

### 1. Jelaskan apa itu widget tree pada Flutter dan bagaimana hubungan parent-child (induk-anak) bekerja antar widget

Dalam Flutter, widget tree adalah struktur yang menggambarkan bagaimana setiap widget saling terhubung dan membentuk tampilan aplikasi.
Setiap elemen seperti teks, tombol, atau ikon adalah bagian dari pohon widget ini.

Hubungan parent–child (induk–anak) berarti:

* Parent adalah widget yang membungkus widget lain dan mengatur tata letak atau perilakunya.
* Child adalah widget yang berada di dalam parent dan menampilkan isi tertentu.

Pada proyek saya, struktur widget-nya seperti ini:

```
Scaffold
 ├── AppBar
 └── Body (Padding)
      └── Column
           ├── Row → [InfoCard (NPM), InfoCard (Name), InfoCard (Class)]
           ├── Text ("Selamat datang di Kick n Cart")
           └── GridView → [_ActionCard (All Products), _ActionCard (My Products), _ActionCard (Create Product)]
```

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

```dart
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
```

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

```dart
ScaffoldMessenger.of(context)
  ..hideCurrentSnackBar()
  ..showSnackBar(
    SnackBar(content: Text(b.snackbarText)),
  );
```

Kode ini memberi tahu Flutter bahwa _ActionCard berada di dalam Scaffold, sehingga SnackBar bisa muncul pada halaman yang sesuai.
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

---

berikut versi yang sudah **tanpa format teks tambahan (tidak ada bold atau italic)**, tapi tetap rapi dan terstruktur:

---

## ============== TUGAS 8 ==============

### 1. Jelaskan perbedaan antara `Navigator.push()` dan `Navigator.pushReplacement()` pada Flutter. Dalam kasus apa sebaiknya masing-masing digunakan pada aplikasi Football Shop kamu?

Navigator.push() digunakan untuk menambahkan halaman baru di atas halaman yang sedang aktif tanpa menghapus halaman sebelumnya, sehingga pengguna masih bisa kembali ke halaman awal menggunakan tombol back.
Sedangkan Navigator.pushReplacement() akan mengganti halaman yang sedang aktif dengan halaman baru, dan halaman sebelumnya akan dihapus dari navigation stack.

Pada aplikasi ini, keduanya digunakan sesuai kebutuhan:

* Navigator.push() dipakai ketika membuka halaman sementara, seperti form tambah produk, agar pengguna bisa kembali ke halaman utama setelah selesai mengisi form.
* Navigator.pushReplacement() digunakan pada navigasi melalui Drawer, agar ketika berpindah ke halaman lain seperti “Tambah Produk” atau “Halaman Utama”, halaman sebelumnya tidak menumpuk di memori.

Jadi, push() digunakan untuk perpindahan halaman yang sifatnya sementara, sedangkan pushReplacement() lebih cocok untuk navigasi utama antar halaman agar aplikasi tetap ringan dan efisien.

---

### 2. Bagaimana kamu memanfaatkan hierarchy widget seperti `Scaffold`, `AppBar`, dan `Drawer` untuk membangun struktur halaman yang konsisten di seluruh aplikasi?

Ketiga widget tersebut berperan penting dalam menciptakan struktur halaman yang seragam di seluruh aplikasi:

* Scaffold digunakan sebagai struktur dasar yang menyediakan area untuk AppBar, Body, dan Drawer.
* AppBar menampilkan judul aplikasi “Kick n Cart” di bagian atas setiap halaman, dengan warna tema yang konsisten.
* Drawer menjadi navigasi utama yang berisi opsi seperti “Halaman Utama” dan “Tambah Produk” agar pengguna dapat berpindah antar halaman dengan mudah.

---

### 3. Dalam konteks desain antarmuka, apa kelebihan menggunakan layout widget seperti `Padding`, `SingleChildScrollView`, dan `ListView` saat menampilkan elemen-elemen form? Berikan contoh penggunaannya dari aplikasi kamu.

Ketiga widget ini membantu menata tampilan form agar lebih rapi, nyaman, dan mudah diakses di berbagai ukuran layar:

* Padding digunakan untuk memberi jarak antar elemen agar form tidak terlihat sempit dan lebih enak dilihat.
  Contohnya pada halaman Tambah Produk, setiap TextFormField diberi padding agar tidak menempel satu sama lain.
* SingleChildScrollView memungkinkan seluruh form bisa scroll ke bawah ketika layar tidak cukup menampilkan semua input.
  Hal ini penting agar field tetap bisa diisi meskipun keyboard muncul.
* ListView digunakan jika elemen form bersifat dinamis dan jumlahnya bisa bertambah. Namun pada proyek ini, elemen form bersifat statis, sehingga digunakan Column di dalam SingleChildScrollView.

Dengan kombinasi ini, tampilan form tetap responsif, tidak terpotong, dan nyaman digunakan baik di perangkat kecil maupun besar.

---

### 4. Bagaimana kamu menyesuaikan warna tema agar aplikasi Football Shop memiliki identitas visual yang konsisten dengan brand toko?

Penyesuaian warna tema dilakukan melalui properti ThemeData pada widget MaterialApp.
Warna utama toko ditetapkan menggunakan ColorScheme.fromSwatch(primarySwatch: Colors.blue) dengan tambahan secondary: Colors.blueAccent agar seluruh komponen seperti AppBar, Button, dan teks memiliki warna yang konsisten.

Contohnya dalam proyek:

```dart
theme: ThemeData(
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
      .copyWith(secondary: Colors.blueAccent),
  useMaterial3: true,
),
```

Dengan pengaturan ini, aplikasi Kick n Cart memiliki tampilan yang seragam.

## ============== TUGAS 9 ==============

### 1. Jelaskan mengapa kita perlu membuat model Dart saat mengambil/mengirim data JSON? Apa konsekuensinya jika langsung memetakan Map<String, dynamic> tanpa model (terkait validasi tipe, null-safety, maintainability)?

Pembuatan model Dart diperlukan agar data yang diterima dari backend memiliki struktur dan tipe yang jelas. Dengan model, proses konversi dari JSON ke objek Dart dan sebaliknya menjadi lebih aman, terprediksi, dan mudah dipelihara.

Jika hanya menggunakan `Map<String, dynamic>`:

* Validasi tipe menjadi tidak terjamin karena seluruh nilai bertipe dynamic.
* Potensi error meningkat, seperti salah penulisan key atau akses nilai null.
* Kode sulit dipelihara karena tidak ada standar struktur data yang konsisten.

Model membantu memastikan integritas data dan meningkatkan keterbacaan serta keberlanjutan proyek.

---

### 2. Apa fungsi package http dan CookieRequest dalam tugas ini? Jelaskan perbedaan peran http vs CookieRequest.

Package **http** digunakan untuk melakukan permintaan HTTP sederhana, seperti GET atau POST, tanpa pengelolaan sesi atau cookie secara otomatis.

Sementara itu, **CookieRequest** berfungsi menangani autentikasi berbasis sesi, termasuk menyimpan dan mengirim cookie secara otomatis dalam setiap permintaan. Hal ini diperlukan karena Django menggunakan mekanisme session-based authentication.

Perbedaan utama:

* **http** → komunikasi HTTP biasa, tidak menangani session.
* **CookieRequest** → komunikasi HTTP yang membutuhkan penyimpanan cookie untuk mempertahankan status login.

---

### 3. Jelaskan mengapa instance CookieRequest perlu untuk dibagikan ke semua komponen di aplikasi Flutter.

Karena autentikasi Django berbasis sesi, cookie harus konsisten di seluruh bagian aplikasi. Jika setiap komponen memiliki instance `CookieRequest` yang berbeda, maka cookie juga berbeda dan status login tidak akan dikenali.

Dengan membagikan satu instance melalui state management seperti Provider, seluruh halaman menggunakan sesi yang sama, sehingga proses autentikasi dapat berfungsi dengan benar.

---

### 4. Jelaskan konfigurasi konektivitas yang diperlukan agar Flutter dapat berkomunikasi dengan Django. Mengapa kita perlu menambahkan 10.0.2.2 pada ALLOWED_HOSTS, mengaktifkan CORS dan pengaturan SameSite/cookie, dan menambahkan izin akses internet di Android? Apa yang akan terjadi jika konfigurasi tersebut tidak dilakukan dengan benar?

Beberapa konfigurasi harus dilakukan agar Flutter dapat mengakses server Django:

* **Menambahkan `10.0.2.2` pada `ALLOWED_HOSTS`** karena emulator Android menggunakan alamat tersebut untuk mengakses localhost pada komputer host.
* **Mengaktifkan CORS** agar Django mengizinkan permintaan lintas-origin dari aplikasi Flutter.
* **Mengatur SameSite dan cookie** agar session cookie dapat dikirim dan diterima oleh Flutter.
* **Menambahkan izin akses internet** pada Android melalui manifest agar aplikasi dapat melakukan request jaringan.

Jika konfigurasi tersebut tidak tepat, permintaan dapat ditolak Django, cookie tidak diterapkan, atau aplikasi tidak dapat mengakses API sama sekali.

---

### 5. Jelaskan mekanisme pengiriman data mulai dari input hingga dapat ditampilkan pada Flutter.

Alurnya adalah sebagai berikut:

1. Pengguna mengisi data melalui formulir di Flutter.
2. Data dikirim ke Django melalui `http` atau `CookieRequest` dalam format JSON.
3. Django memproses data, melakukan validasi, dan menyimpan atau mengambil data dari basis data.
4. Django mengirim respons dalam bentuk JSON.
5. Flutter menerima JSON tersebut, mengubahnya menjadi objek Dart melalui model, lalu menampilkannya pada antarmuka.

---

### 6. Jelaskan mekanisme autentikasi dari login, register, hingga logout. Mulai dari input data akun pada Flutter ke Django hingga selesainya proses autentikasi oleh Django dan tampilnya menu pada Flutter.

* **Register:** Flutter mengirim data pendaftaran ke Django → Django membuat akun baru → Flutter menerima respons.
* **Login:** Flutter mengirim username dan password → Django memverifikasi → jika valid, Django mengembalikan cookie sesi → `CookieRequest` menyimpannya → Flutter menandai bahwa pengguna telah berhasil login.
* **Logout:** Flutter memanggil endpoint logout → Django menghapus sesi → cookie tidak lagi berlaku → Flutter mengembalikan tampilan ke kondisi tidak login.

Dengan adanya cookie, Flutter dapat mengakses resource yang membutuhkan autentikasi seperti item milik pengguna.

---

### 7. Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step! (bukan hanya sekadar mengikuti tutorial).

1. Menyediakan model Django untuk item sesuai kebutuhan, kemudian melakukan migrasi.
2. Membuat endpoint JSON untuk daftar item, detail item, dan endpoint khusus untuk item milik pengguna.
3. Menyiapkan endpoint register, login, dan logout.
4. Mengatur CORS, cookie, dan menambahkan `10.0.2.2` pada `ALLOWED_HOSTS`.
5. Men-deploy atau menjalankan Django pada server yang dapat diakses Flutter.
6. Membuat model Dart untuk item lengkap dengan method `fromJson` dan `toJson`.
7. Mengimplementasikan halaman register dan login pada Flutter.
8. Menggunakan Provider atau state management lain untuk membagikan instance `CookieRequest`.
9. Membuat halaman daftar item yang menampilkan data sesuai model.
10. Menambahkan fitur filter agar hanya item milik pengguna yang tampil.
11. Membuat halaman detail item yang diakses melalui card pada daftar item.
12. Menguji seluruh alur dari login hingga logout untuk memastikan semuanya berfungsi.