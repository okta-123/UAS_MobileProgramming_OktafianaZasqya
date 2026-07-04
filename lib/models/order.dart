class Order {
  final String nama;
  final String noHp;
  final String alamat;
  final String jenisLaundry;
  final String tanggal;
  final String jam;

  Order({
    required this.nama,
    required this.noHp,
    required this.alamat,
    required this.jenisLaundry,
    required this.tanggal,
    required this.jam,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      nama: json['nama'],
      noHp: json['no_hp'],
      alamat: json['alamat'],
      jenisLaundry: json['jenis_laundry'],
      tanggal: json['tanggal'],
      jam: json['jam'],
    );
  }
}