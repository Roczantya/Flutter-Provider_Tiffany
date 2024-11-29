
---

# **Manajemen State di Flutter: Local State dan Global State**  

Repositori ini mendemonstrasikan dua pendekatan dalam manajemen state di Flutter, yaitu **Local State Management** dan **Global State Management**. Teknik ini digunakan untuk mengelola data aplikasi dan perilaku UI secara efisien.  

---

## **1. Local State Management**  

### **Apa itu Local State?**  
Local state adalah data yang dikelola langsung di dalam widget. Teknik ini cocok untuk mengelola data yang hanya relevan dengan widget tertentu atau bagian kecil dari UI.  

### **Kelebihan:**  
- Mudah diimplementasikan.  
- Cocok untuk komponen UI yang terisolasi.  

### **Kekurangan:**  
- Tidak mudah untuk berbagi state antar widget.  
- Kurang skalabel untuk aplikasi yang kompleks.  

### **Contoh Kode:**  

```dart
import 'package:flutter/material.dart';

class LocalCounter extends StatefulWidget {
  @override
  _LocalCounterState createState() => _LocalCounterState();
}

class _LocalCounterState extends State<LocalCounter> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Counter: $_counter'),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _counter++;
            });
          },
          child: Text('Increment'),
        ),
      ],
    );
  }
}
```  

---

## **2. Global State Management**  

### **Apa itu Global State?**  
Global state adalah state yang dapat diakses oleh beberapa widget di seluruh aplikasi. Teknik ini digunakan pada aplikasi kompleks di mana data harus konsisten antar layar atau komponen.  

### **Kelebihan:**  
- State dapat diakses dari mana saja dalam aplikasi.  
- Cocok untuk aplikasi berskala besar.  

### **Kekurangan:**  
- Membutuhkan konfigurasi tambahan.  
- Dapat menambah kompleksitas jika tidak dikelola dengan baik.  

### **Implementasi dengan `Provider`:**  

#### **Kelas Global State**  

```dart
import 'package:flutter/material.dart';

class Counter {
  int value;
  Color color;
  String label;

  Counter({this.value = 0, this.color = Colors.blue, this.label = 'Counter'});
}

class GlobalState extends ChangeNotifier {
  final List<Counter> counters = [];

  void addCounter() {
    counters.add(Counter());
    notifyListeners();
  }

  void removeCounter(int index) {
    counters.removeAt(index);
    notifyListeners();
  }

  void incrementCounter(int index) {
    counters[index].value++;
    notifyListeners();
  }

  void decrementCounter(int index) {
    if (counters[index].value > 0) {
      counters[index].value--;
      notifyListeners();
    }
  }

  void updateCounterLabel(int index, String newLabel) {
    counters[index].label = newLabel;
    notifyListeners();
  }

  void updateCounterColor(int index, Color newColor) {
    counters[index].color = newColor;
    notifyListeners();
  }
}
```  

#### **Menggunakan Global State di UI**  

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final globalState = context.watch<GlobalState>();

    return ListView.builder(
      itemCount: globalState.counters.length,
      itemBuilder: (context, index) {
        final counter = globalState.counters[index];
        return ListTile(
          title: Text(counter.label),
          subtitle: Text('Value: ${counter.value}'),
          trailing: IconButton(
            icon: Icon(Icons.add),
            onPressed: () => globalState.incrementCounter(index),
          ),
        );
      },
    );
  }
}
```  

---

## **3. Perbedaan Utama**  

| Fitur                       | Local State                        | Global State                        |  
|-----------------------------|-------------------------------------|-------------------------------------|  
| **Ruang Lingkup**           | Terbatas pada widget tertentu.     | Dapat diakses seluruh aplikasi.     |  
| **Kompleksitas**            | Mudah diimplementasikan.           | Membutuhkan pengaturan tambahan.    |  
| **Skalabilitas**            | Tidak cocok untuk aplikasi besar.  | Cocok untuk aplikasi kompleks.      |  
| **Kasus Penggunaan Terbaik**| Komponen UI terisolasi.            | Aplikasi dengan data bersama.       |  

---

## **4. Cara Menjalankan**  

### **Langkah 1: Clone Repositori**  
```bash  
git clone https://github.com/your-repo/flutter-state-management.git  
```  

### **Langkah 2: Install Dependencies**  
```bash  
flutter pub get  
```  

### **Langkah 3: Jalankan Aplikasi**  
```bash  
flutter run  
```  

---

## **5. Kesimpulan**  

Proyek ini menunjukkan cara mengelola state di Flutter menggunakan **Local State Management** untuk widget yang sederhana dan **Global State Management** untuk aplikasi besar yang saling terhubung. Dengan memahami pendekatan ini, Anda dapat membangun aplikasi yang lebih kokoh dan mudah dikelola.  

--- 

