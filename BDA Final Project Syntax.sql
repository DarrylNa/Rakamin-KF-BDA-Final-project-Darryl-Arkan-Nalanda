-- Membuat atau menggantikan tabel `analysis_table` di dataset `kimia_farma`
CREATE OR REPLACE TABLE `rakamin-kf-big-data-analytics.kimia_farma.analysis_table` AS
SELECT
    -- Mengambil transaction_id dan tanggal transaksi
    ft.transaction_id,
    ft.date,
    
    -- Mengambil informasi cabang dari tabel kf_kantor_cabang
    kc.branch_id,
    kc.branch_name,
    kc.kota,
    kc.provinsi,
    kc.rating AS rating_cabang, -- Rating cabang (bukan transaksi)
    
    -- Mengambil informasi pelanggan dan produk dari tabel transaksi dan produk
    ft.customer_name,
    p.product_id,
    p.product_name,
    
    -- Harga awal sebelum diskon
    ft.price AS actual_price,
    ft.discount_percentage, -- Persentase diskon yang diberikan
    
    -- Menentukan persentase gross laba berdasarkan harga produk
    CASE 
        WHEN ft.price <= 50000 THEN 0.10
        WHEN ft.price > 50000 AND ft.price <= 100000 THEN 0.15
        WHEN ft.price > 100000 AND ft.price <= 300000 THEN 0.20
        WHEN ft.price > 300000 AND ft.price <= 500000 THEN 0.25
        ELSE 0.30
    END AS persentase_gross_laba,
    
    -- Menghitung nett sales setelah diskon diberikan
    ft.price * (1 - (ft.discount_percentage / 100)) AS nett_sales,
    
    -- Menghitung nett profit dengan mengalikan nett sales dengan persentase gross laba
    (ft.price * (1 - (ft.discount_percentage / 100))) * 
    CASE 
        WHEN ft.price <= 50000 THEN 0.10
        WHEN ft.price > 50000 AND ft.price <= 100000 THEN 0.15
        WHEN ft.price > 100000 AND ft.price <= 300000 THEN 0.20
        WHEN ft.price > 300000 AND ft.price <= 500000 THEN 0.25
        ELSE 0.30
    END AS nett_profit,

    -- Rating yang diberikan untuk transaksi tersebut
    ft.rating AS rating_transaksi

-- Mengambil data dari tabel transaksi sebagai tabel utama
FROM `rakamin-kf-big-data-analytics.kimia_farma.kf_final_transaction` ft

-- Melakukan LEFT JOIN dengan tabel produk berdasarkan product_id
LEFT JOIN `rakamin-kf-big-data-analytics.kimia_farma.kf_product` p 
    ON ft.product_id = p.product_id

-- Melakukan LEFT JOIN dengan tabel kantor cabang berdasarkan branch_id
LEFT JOIN `rakamin-kf-big-data-analytics.kimia_farma.kf_kantor_cabang` kc 
    ON ft.branch_id = kc.branch_id;
