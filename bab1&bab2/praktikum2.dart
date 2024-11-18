// Enum untuk kategori produk
enum KategoriProduk { DataManagement, NetworkAutomation }

// Kelas ProdukDigital
class ProdukDigital {
  String namaProduk;
  double harga;
  KategoriProduk kategori;

  ProdukDigital(this.namaProduk, this.harga, this.kategori);

  // Metode untuk menerapkan diskon
  void terapkanDiskon() {
    if (kategori == KategoriProduk.NetworkAutomation && harga > 200000) {
      harga *= 0.85; // Diskon 15%
      if (harga < 200000) harga = 200000; // Batas harga minimal setelah diskon
    }
  }
}

// Enum untuk peran karyawan
enum Peran { Developer, NetworkEngineer, Manager }

// Mixin untuk Kinerja karyawan
mixin Kinerja {
  int produktivitas = 100;

  void tingkatkanProduktivitas(int nilai) {
    if (produktivitas + nilai <= 100) produktivitas += nilai;
  }

  void kurangiProduktivitas(int nilai) {
    if (produktivitas - nilai >= 0) produktivitas -= nilai;
  }
}

// Kelas abstrak Karyawan
abstract class Karyawan {
  String nama;
  int umur;
  Peran peran;

  Karyawan(this.nama, {required this.umur, required this.peran});

  void bekerja(); // Metode abstrak
}

// KaryawanTetap sebagai subclass dari Karyawan
class KaryawanTetap extends Karyawan with Kinerja {
  KaryawanTetap(String nama, {required int umur, required Peran peran})
      : super(nama, umur: umur, peran: peran);

  @override
  void bekerja() {
    print("Karyawan tetap $nama sedang bekerja.");
  }
}

// KaryawanKontrak sebagai subclass dari Karyawan
class KaryawanKontrak extends Karyawan with Kinerja {
  KaryawanKontrak(String nama, {required int umur, required Peran peran})
      : super(nama, umur: umur, peran: peran);

  @override
  void bekerja() {
    print("Karyawan kontrak $nama sedang bekerja pada proyek.");
  }
}

// Enum untuk fase proyek
enum FaseProyek { Perencanaan, Pengembangan, Evaluasi }

// Kelas Proyek dengan fase dan jumlah hari
class Proyek {
  FaseProyek fase = FaseProyek.Perencanaan;
  int jumlahHari = 0;
  int jumlahKaryawanAktif = 0;

  // Metode untuk melanjutkan ke fase proyek berikutnya
  void lanjutkanFase() {
    if (fase == FaseProyek.Perencanaan && jumlahKaryawanAktif >= 5) {
      fase = FaseProyek.Pengembangan;
    } else if (fase == FaseProyek.Pengembangan && jumlahHari > 45) {
      fase = FaseProyek.Evaluasi;
    }
  }
}

// Kelas Perusahaan untuk mengelola karyawan aktif dan non-aktif
class Perusahaan {
  List<Karyawan> karyawanAktif = [];
  List<Karyawan> karyawanNonAktif = [];
  static const int batasKaryawan = 20;

  // Metode untuk menambah karyawan jika batas belum tercapai
  void tambahkanKaryawan(Karyawan karyawan) {
    if (karyawanAktif.length < batasKaryawan) {
      karyawanAktif.add(karyawan);
    } else {
      print("Batas karyawan aktif tercapai. Tidak bisa menambah karyawan.");
    }
  }

  // Metode untuk mengubah status karyawan menjadi non-aktif
  void karyawanResign(Karyawan karyawan) {
    karyawanAktif.remove(karyawan);
    karyawanNonAktif.add(karyawan);
  }
}

void main() {
  // Membuat objek perusahaan
  Perusahaan perusahaan = Perusahaan();

  // Menambah karyawan tetap
  KaryawanTetap karyawan1 =
      KaryawanTetap("Alice", umur: 30, peran: Peran.Manager);
  perusahaan.tambahkanKaryawan(karyawan1);

  // Menambah karyawan kontrak
  KaryawanKontrak karyawan2 =
      KaryawanKontrak("Bob", umur: 25, peran: Peran.Developer);
  perusahaan.tambahkanKaryawan(karyawan2);

  // Karyawan kontrak berhenti
  perusahaan.karyawanResign(karyawan2);

  // Membuat produk dan menerapkan diskon
  ProdukDigital produk = ProdukDigital(
      "Sistem Otomasi Jaringan", 250000, KategoriProduk.NetworkAutomation);
  produk.terapkanDiskon();
  print("Harga setelah diskon: ${produk.harga}");

  // Menampilkan fase proyek
  Proyek proyek = Proyek();
  proyek.jumlahKaryawanAktif = 5; // Contoh kondisi untuk lanjutkan fase
  proyek.lanjutkanFase();
  print("Fase proyek saat ini: ${proyek.fase}");
}
 