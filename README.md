# Kimia Farma Business Performance Analysis (2020-2023)

**Repository ini dibuat untuk kepentingan penjelasan project akhir evaluasi kinerja bisnis Kimia Farma dan digunakan dalam program internship Big Data Analytics.**

## Deskripsi Proyek
Proyek ini bertujuan untuk menganalisis kinerja bisnis Kimia Farma dari tahun 2020 hingga 2023 menggunakan data transaksi, inventory, produk dan informasi cabang yang tersedia. Analisis ini dilakukan menggunakan **Google BigQuery** untuk mengelola dan mengolah data serta **Google Looker Studio** untuk visualisasi dan pembuatan dashboard.

## Dataset
Terdapat empat dataset utama yang diimpor ke dalam **Google BigQuery**:
1. `kf_final_transaction.csv` - Berisi data transaksi pelanggan.
2. `kf_inventory.csv` - Berisi data inventaris di setiap cabang.
3. `kf_kantor_cabang.csv` - Berisi data informasi cabang Kimia Farma.
4. `kf_product.csv` - Berisi data produk obat yang tersedia.

## Penjelasan Query SQL
1. **Menggabungkan Tabel:**
   - `kf_final_transaction` dikaitkan dengan `kf_product` berdasarkan `product_id`.
   - `kf_final_transaction` dikaitkan dengan `kf_kantor_cabang` berdasarkan `branch_id`.

2. **Perhitungan Persentase Laba:**
   - Berdasarkan harga produk, laba ditentukan dengan aturan berikut:
     - Harga ≤ 50.000 → Laba 10%
     - Harga > 50.000 - 100.000 → Laba 15%
     - Harga > 100.000 - 300.000 → Laba 20%
     - Harga > 300.000 - 500.000 → Laba 25%
     - Harga > 500.000 → Laba 30%

3. **Menghitung Nilai Nett:**
   - `nett_sales`: Harga setelah dikurangi diskon.
   - `nett_profit`: Keuntungan bersih berdasarkan `nett_sales` dikalikan dengan persentase laba.

## Visualisasi Dashboard
Setelah tabel analisis dibuat, langkah selanjutnya adalah membuat **dashboard di Google Looker Studio** untuk menyajikan data secara visual.
Link Dashboard: https://lookerstudio.google.com/reporting/28629f4a-4b2a-40b1-b958-388ef1207d7b




