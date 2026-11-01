SET FOREIGN_KEY_CHECKS = 0;

-- 1. Hiçbir bağımlılığı olmayan ana tablolar önce oluşturulur
CREATE TABLE personel (
    personel_id INT PRIMARY KEY AUTO_INCREMENT,
    ad VARCHAR(50),
    soyad VARCHAR(50),
    gorev VARCHAR(50),
    ise_giris DATE
);

CREATE TABLE kullanici (
    giris_bilgileri VARCHAR(50) PRIMARY KEY,
    rol VARCHAR(50),
    iliskili_kisi VARCHAR(50)
);

CREATE TABLE misafir (
    ad VARCHAR(50),
    soyad VARCHAR(50),
    `TC/pasaport` VARCHAR(50) PRIMARY KEY,
    telefon VARCHAR(10),
    email VARCHAR(50) UNIQUE,
    dtarih DATE
);

CREATE TABLE ek_hizmet (
    hizmet_id INT PRIMARY KEY AUTO_INCREMENT,
    hizmet_adi VARCHAR(50) UNIQUE,
    birim_fiyat INT
);

CREATE TABLE islem_log (
    islem_id INT PRIMARY KEY AUTO_INCREMENT,
    tablo_adi VARCHAR(50),
    islem VARCHAR(50)
);

-- 2. Diğer ara ve bağımlı tablolar sırayla gelir
CREATE TABLE sezon_fiyati (
    temel_fiyat INT PRIMARY KEY,
    tip_adi VARCHAR(50),
    kapasite INT,
    aciklama VARCHAR(50)
);

CREATE TABLE oda_tipi (
    tip_adi VARCHAR(50) PRIMARY KEY,
    kapasite INT,
    aciklama VARCHAR(50),
    temel_fiyat INT,
    FOREIGN KEY (temel_fiyat) REFERENCES sezon_fiyati(temel_fiyat)
);

-- (sezon_fiyati ve oda_tipi karşılıklı bağ için ALTER ile de bağlanabilir ama bu sıra kurtarır)
ALTER TABLE sezon_fiyati ADD FOREIGN KEY (tip_adi) REFERENCES oda_tipi(tip_adi);

CREATE TABLE oda (
    oda_no INT PRIMARY KEY,
    tip_adi VARCHAR(50),
    durum INT,
    kat INT,
    FOREIGN KEY (tip_adi) REFERENCES oda_tipi(tip_adi)
);

CREATE TABLE rezervasyon (
    rezervasyon_id INT PRIMARY KEY AUTO_INCREMENT,
    kisi_sayisi INT,
    misafir_adisoyadi VARCHAR(50),
    oda_tipi VARCHAR(50),
    olusturma_tarihi DATE,
    giris_tarihi DATE,
    cikis_tarihi DATE,
    durum CHAR
);

CREATE TABLE konaklama (
    konaklama_id INT PRIMARY KEY AUTO_INCREMENT,
    personel_id INT,
    gercek_giris DATE,
    gercek_cikis DATE,
    FOREIGN KEY (personel_id) REFERENCES personel(personel_id)
);

CREATE TABLE temizlik_kaydi (
    temizlik_id INT PRIMARY KEY AUTO_INCREMENT,
    personel_id INT,
    oda_no INT,
    durum BOOLEAN,
    tarih DATE,
    FOREIGN KEY (personel_id) REFERENCES personel(personel_id),
    FOREIGN KEY (oda_no) REFERENCES oda(oda_no)
);

-- Oda tablosundaki durum sütunu temizlik_kaydi'na bağlandığı için FK sonradan eklenir
ALTER TABLE oda ADD FOREIGN KEY (durum) REFERENCES temizlik_kaydi(temizlik_id);

CREATE TABLE odeme (
    dekont_no VARCHAR(50) PRIMARY KEY,
    tarih DATE,
    konaklama_id INT,
    tutar INT,
    odeme_turu VARCHAR(50),
    FOREIGN KEY (konaklama_id) REFERENCES konaklama(konaklama_id)
);

CREATE TABLE konaklama_hizmeti (
    kayit_id INT PRIMARY KEY AUTO_INCREMENT,
    konaklama_id INT,
    hizmet_adi VARCHAR(50),
    adet INT,
    tarih DATE,
    FOREIGN KEY (konaklama_id) REFERENCES konaklama(konaklama_id),
    FOREIGN KEY (hizmet_adi) REFERENCES ek_hizmet(hizmet_adi)
);

SET FOREIGN_KEY_CHECKS = 1;