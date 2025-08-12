## Dokumentasi Fungsi (Penjelasan di luar kode)

Catatan: Dokumen ini menjelaskan fungsi-fungsi utama pada aplikasi secara ringkas, jelas, dan mudah dipahami tanpa menambahkan komentar di dalam file kode.

---

### lib/main.dart
- **main()**: Titik masuk aplikasi; menjalankan `runApp(MyApp())`.
- **MyApp.build(BuildContext)**: Mengonfigurasi `MaterialApp` (Material 3, tema global) dan menampilkan `WelcomeScreen` sebagai halaman awal.

---

### lib/models/student.dart
- **enum Gender**: Enumerasi jenis kelamin (`male`, `female`).
- **extension GenderLabel.label**: Mengembalikan label ramah pengguna ("Laki-laki"/"Perempuan").
- **class Student**: Model immutable untuk data mahasiswa dengan `nama`, `nim`, `jurusan`, `gender`.
- **Student.toJson()**: Mengubah `Student` menjadi `Map` agar bisa diserialisasi (disimpan di local storage).
- **Student.fromJson(Map)**: Membuat `Student` dari `Map` (membaca dari local storage) dan mengonversi teks gender ke enum.

---

### lib/repositories/student_repository.dart
- **class StudentRepository**: Abstraksi penyimpanan lokal menggunakan `SharedPreferences` (kunci `students_v1`).
- **loadStudents() -> Future<List<Student>>**: Membaca string JSON dari storage, decode, dan mengembalikan list `Student` (kosong bila belum ada data).
- **saveStudents(List<Student>)**: Mengubah list `Student` ke JSON lalu menyimpannya ke storage.

---

### lib/welcome_screen.dart
- **WelcomeScreen.build(BuildContext)**: Halaman sambutan dengan gradien, judul, tagline, tombol "Mulai" ke `FormPage` (replace) dan tombol "Tim" ke `TeamPage` (push).

---

### lib/team_page.dart
- **TeamPage._members**: Daftar nama anggota tim (konstan).
- **TeamPage.build(BuildContext)**: Menampilkan daftar anggota dalam `ListView.separated` dengan `Card` dan avatar inisial.
- **_initials(String) -> String**: Menghasilkan inisial dari nama untuk ditampilkan pada `CircleAvatar`.

---

### lib/FormPage.dart
- **State fields**: `_repository` (akses storage), `_students` (data saat ini), `_searchController` (input pencarian), `_searchQuery` (nilai pencarian), `_isLoading` (indikator loading), `_selectedGenderFilter` (filter gender aktif).
- **initState()**: Memanggil `_loadStudents()` saat pertama kali untuk memuat data dari storage/seeder.
- **dispose()**: Membebaskan `_searchController` untuk mencegah memory leak.
- **_loadStudents()**: Memuat data dari repository; jika kosong, isi dengan seeder default lalu simpan; update state loading.
- **_saveStudents()**: Menyimpan `_students` saat ada perubahan (tambah/edit/hapus).
- **build(BuildContext)**: 
  - AppBar: tombol back ke `WelcomeScreen`, tombol add (buka form), search bar, dan filter gender.
  - Body: loading indicator saat memuat; daftar mahasiswa terfilter beserta kartu counter total/ditampilkan.
- **_filterStudents() -> List<Student>**: Mengembalikan list yang telah difilter berdasarkan NIM dan gender.
- **_genderChips() -> Widget**: UI chip untuk memilih filter gender (Semua/Laki-laki/Perempuan).
- **_deleteStudent(Student)**: Menghapus item dari list, menampilkan `SnackBar` dengan aksi undo, dan menyimpan perubahan.
- **class Mahasiswa**: Item tampilan satu mahasiswa dengan avatar inisial, info singkat, aksi edit/hapus, dan navigasi ke detail.
- **Mahasiswa._initials(String) -> String**: Menghasilkan inisial nama untuk avatar.

---

### lib/form_biodata.dart
- **class BiodataForm (props)**: `initial` (data untuk mode edit), `existingNims` (cek unik NIM saat validasi).
- **State fields**: `_formKey` (validasi form), controller untuk `nama/nim/jurusan`, `_selectedGender` (nilai gender).
- **initState()**: Jika `initial` ada, isi field dengan nilai awal (mode edit).
- **dispose()**: Membebaskan seluruh controller.
- **build(BuildContext)**: Form input nama, NIM, jurusan, gender, dan tombol simpan/perbarui.
- **_textboxNama() -> TextFormField**: Input `Nama` dengan validasi wajib diisi.
- **_textboxNim() -> TextFormField**: Input `NIM` dengan validasi wajib diisi dan harus unik (cek `existingNims`).
- **_textboxJurusan() -> TextFormField**: Input `Jurusan` dengan validasi wajib diisi.
- **_genderSelector() -> Widget**: Pilihan gender menggunakan dua `RadioListTile`.
- **_tombolSimpan() -> ElevatedButton**: Validasi form; jika valid, membuat `Student` dan `Navigator.pop(context, student)` (mengembalikan hasil ke pemanggil).

---

### lib/Detail_Biodata.dart
- **FormDetail.build(BuildContext)**: Menampilkan kartu detail mahasiswa dengan avatar (Hero), nama, NIM, dan chip untuk jurusan/gender.
- **_row(String, String) -> Widget**: Utilitas baris label-nilai (dipakai untuk format sederhana).
- **_initials(String) -> String**: Menghasilkan inisial nama untuk avatar.


