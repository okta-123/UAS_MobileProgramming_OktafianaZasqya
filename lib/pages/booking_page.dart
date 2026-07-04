import 'package:flutter/material.dart';
import '../services/api_service.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  // Controller
  final TextEditingController namaController = TextEditingController();
  final TextEditingController noHpController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();

  final ApiService apiService = ApiService();

  // Spinner
  String? selectedLaundry;

  final List<String> jenisLaundry = [
    "Cuci Kering",
    "Cuci Setrika",
    "Laundry Express",
    "Cuci Sepatu",
  ];

  // Autocomplete
  final List<String> alamatList = [
    "Pamulang",
    "Ciputat",
    "Serpong",
    "BSD",
    "Bintaro",
    "Pondok Aren",
    "Depok",
    "Bogor",
  ];

  // Date & Time
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "Form Booking Laundry",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 30),

            // Nama
            TextField(
              controller: namaController,
              decoration: const InputDecoration(
                labelText: "Nama",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),

            const SizedBox(height: 20),

            // No HP
            TextField(
              controller: noHpController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "No HP",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
              ),
            ),

            const SizedBox(height: 20),

            // Autocomplete
            Autocomplete<String>(
              initialValue: TextEditingValue(text: alamatController.text),
              optionsBuilder: (TextEditingValue value) {
                if (value.text.isEmpty) {
                  return const Iterable<String>.empty();
                }

                return alamatList.where(
                  (item) =>
                      item.toLowerCase().contains(value.text.toLowerCase()),
                );
              },
              onSelected: (value) {
                alamatController.text = value;
              },
              fieldViewBuilder:
                  (
                    context,
                    textEditingController,
                    focusNode,
                    onEditingComplete,
                  ) {
                    textEditingController.text = alamatController.text;

                    textEditingController.addListener(() {
                      alamatController.text = textEditingController.text;
                    });

                    return TextField(
                      controller: textEditingController,
                      focusNode: focusNode,
                      decoration: const InputDecoration(
                        labelText: "Alamat",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.location_on),
                      ),
                    );
                  },
            ),

            const SizedBox(height: 20),

            // Jenis Laundry
            DropdownButtonFormField<String>(
              value: selectedLaundry,
              decoration: const InputDecoration(
                labelText: "Jenis Laundry",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.local_laundry_service),
              ),
              items: jenisLaundry.map((e) {
                return DropdownMenuItem(value: e, child: Text(e));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedLaundry = value;
                });
              },
            ),

            const SizedBox(height: 20),

            // Date Picker
            TextFormField(
              readOnly: true,
              decoration: InputDecoration(
                labelText: "Tanggal Booking",
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.calendar_today),
                hintText: selectedDate == null
                    ? "Pilih Tanggal"
                    : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
              ),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2030),
                );

                if (pickedDate != null) {
                  setState(() {
                    selectedDate = pickedDate;
                  });
                }
              },
            ),

            const SizedBox(height: 20),

            // Time Picker
            TextFormField(
              readOnly: true,
              decoration: InputDecoration(
                labelText: "Jam Booking",
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.access_time),
                hintText: selectedTime == null
                    ? "Pilih Jam"
                    : selectedTime!.format(context),
              ),
              onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );

                if (pickedTime != null) {
                  setState(() {
                    selectedTime = pickedTime;
                  });
                }
              },
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                child: const Text("SIMPAN BOOKING"),
                onPressed: () async {
                  if (namaController.text.isEmpty ||
                      noHpController.text.isEmpty ||
                      alamatController.text.isEmpty ||
                      selectedLaundry == null ||
                      selectedDate == null ||
                      selectedTime == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Lengkapi semua data terlebih dahulu!"),
                      ),
                    );
                    return;
                  }

                  bool berhasil = await apiService.simpanBooking(
                    nama: namaController.text,
                    noHp: noHpController.text,
                    jenisLaundry: selectedLaundry!,
                    alamat: alamatController.text,
                    tanggal:
                        "${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}",
                    jam:
                        "${selectedTime!.hour.toString().padLeft(2, '0')}:${selectedTime!.minute.toString().padLeft(2, '0')}:00",
                  );

                  if (berhasil) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Booking berhasil disimpan!"),
                        duration: Duration(seconds: 2),
                      ),
                    );

                    await Future.delayed(const Duration(seconds: 2));

                    if (!mounted) return;

                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Gagal menyimpan booking!")),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
