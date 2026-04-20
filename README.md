# Mini Katalog Uygulaması (Flutter)

Bu proje, Flutter temel eğitim haftası kapsamında geliştirilen **“Mini Katalog Uygulaması”** örneğidir. Amaç; widget yapısı, sayfa geçişleri (Navigator), veri modelleme (JSON), listeleme (GridView) ve basit state yönetimi (Sepet simülasyonu) konularını **ek paket kullanmadan** öğretmektir.

## Özellikler

- **Ekranlar**
  - **Ana Sayfa**: banner + “Ürünleri Gör”
  - **Ürün Liste**: `GridView` + arama (isim/kategori)
  - **Ürün Detay**: Route arguments ile ürün detayı
  - **Sepet**: seçilen ürünler, adet arttır/azalt, sil, toplam tutar (simülasyon)
- **Navigasyon**
  - Named routes + `RouteSettings.arguments`
- **Veri**
  - Önce demo API denenir: `https://wantapi.com/products.php`
  - Başarısız olursa lokal seed JSON kullanılır: `assets/data/products_seed.json`
- **Görsel**
  - Ürün görselleri **asset** olarak tutulur (emulatorda internet sorunu olsa bile görünür)

## Kullanılan Teknolojiler

- Flutter (Material)
- Dart
- Paket: **Yok** (ekstra paket kullanılmadı)
  - HTTP için Dart `HttpClient` kullanıldı

## Proje Yapısı (Özet)

```
lib/
  main.dart
  src/
    app/            # MaterialApp + routes
    models/         # Product modeli (fromJson/toJson)
    services/       # HttpClient ile demo API
    repositories/   # API + seed JSON fallback
    state/          # CartController + CatalogController
    ui/
      screens/      # home, product_list, product_detail, cart
      widgets/      # product_card, product_image
assets/
  data/products_seed.json
  images/ (banner + product_*.jpg)
```

## Kurulum ve Çalıştırma

Bu repo bir Flutter projesidir.

```bash
flutter pub get
flutter run
```

> Not: Android emulatorda görsellerin güncellenmesi için bazen **Hot Restart** gerekebilir.

## Sepet Mantığı (Simülasyon)

- Sepet state’i `CartController` içinde tutulur.
- Yapı: **`Map<int, int>`** → `productId -> adet`
- Sepet ekranında adet arttır/azalt, kaldır ve toplam tutar hesaplanır.

## Eğitim Hedefleri

- Stateless/Stateful widget mantığını kavrama
- Sayfalar arası geçiş (`Navigator.push/pop`, named routes)
- JSON/model sınıfı (`fromJson/toJson`)
- `GridView` ile kart tabanlı listeleme
- Basit state güncelleme örneği (Sepet simülasyonu)

## Veri Kaynakları (Eğitim/Demo)

- Banner görseli: `assets/images/banner.png` (orijinal kaynak: `https://wantapi.com/assets/banner.png`)
- Demo ürün verisi: `https://wantapi.com/products.php` (opsiyonel, eğitim amaçlı)

## Ekran Görüntüsü

İstersen buraya kendi ekran görüntülerini ekleyebilirsin:

```
assets/screenshots/
  home.png
  products.png
  detail.png
  cart.png
```

## Lisans

Eğitim/demonstrasyon amaçlı örnek projedir.
