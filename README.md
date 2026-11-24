# 26-27-Veritaban-Projesi
-Grup Üyeleri-
1. İbrahim Kaya (Takım Kaptanı) - 455151
2. Kaan Yıldırım - 455143

-Kullanılan Teknolojiler-
1. MySQL
2. Nodejs

-SQL Betiği-
Bu betik, otel yönetim sistemi için E-R diyagramına uygun tabloları oluşturur.
Tabloloar, foreign key bağımlılıklarına göre sıralı oluşturulur: önce bağımsız tablolar(personel, kullanici, misafir, ek_hizmet, islem_log), sonra bunlara bağlı tablolar.
oda_tipi-sezon_fiyatı ve oda-temizlik_kaydi çiftleri birbirine FK ile bağlı olduğu için, önce biri eksik bağlantıyla oluşturulup diğer tablo kurulduktan sonra eksik FK ALTER TABLE ile ekleniyor.
SET FOREIGN_KEY CHECKS bu yüzden geçici olarak kapatıp açılıyor.

Ana tablolar: 
oda/oda_tipi/sezon_fiyati (oda ile fiyatlandırma),
rezervasyon, konaklama (fiili giriş-çıkış),
temizlik_kaydi, odeme, ek_hizmet/konaklama_hizmeti
