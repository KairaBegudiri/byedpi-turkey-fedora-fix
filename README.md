# ByeDPI TR Fedora Fix

Linux için ByeDPI TR'nin Fedora'ya yönelik düzenlenmiş versiyonu.

Arkaplanda aşağıdaki araçları kullanır:

* [dnscrypt-proxy](https://github.com/DNSCrypt/dnscrypt-proxy)
* [byedpictl](https://github.com/maximilionus/byedpictl)
* [byedpi](https://github.com/hufrea/byedpi)
* [hev-socks5-tunnel](https://github.com/heiher/hev-socks5-tunnel)

---

### **Test Edilen Ortamlar**  
| Ortam       | Durum                          |
|-------------|--------------------------------|
| Fedora 42      | Çalışıyor ✅                   |
| OpenSUSE      | ⚠️Deneyseldir, bir çok hata ile karşılaşmanız olası⚠️                   |

### **Test Edilen ISS'ler**  
| Sağlayıcı    | Profil       | Durum |
|--------------|-------------|--------------|
| Türk Telekom | ``varsayilan-profil`` | Çalışıyor ✅
| SuperOnline  | ``varsayilan-profil`` | Çalışıyor ✅

---

## Yasal Uyarı
* Proje GPL-v3 olarak yeniden lisanslanmıştır.

* Bu uygulamanın kullanımından doğan her türlü yasal sorumluluk kullanan kişiye aittir. Uygulama yalnızca eğitim ve araştırma amaçları ile yazılmış ve düzenlenmiş olup; bu uygulamayı bu şartlar altında kullanmak ya da kullanmamak kullanıcının kendi seçimidir. Açık kaynak kodlarının paylaşıldığı bu platformdaki düzenlenmiş bu proje, bilgi paylaşımı ve kodlama eğitimi amaçları ile yazılmış ve düzenlenmiştir.

---

## Notlar

* **Yalnızca Fedora'yı destekler.**
  Orjinal projenin de Fedora desteği olsa da bu desteğin hiç stabil olmadığını ve epey sorunlu olduğunu fark ettik. Yapmış olduğumuz bu proje yalnızca Fedora'ya yöneliktir.

---

## Kurulum
GitHub üzerinden repo'yu uygun konuma klonlayın.
```bash
git clone https://github.com/KairaBegudiri/byedpi-turkey-fedora-fix
cd byedpi-turkey-fedora-fix
sudo sh curl.sh && sudo sh kurulum.sh
```

---

## Kaldırma
Daha önce klonlanmış konumdan ``kaldir.sh`` betiğini çalıştırın.
```bash
bash ~/.local/share/byedpi-turkey/kaldir.sh
```

Eğer kaldırma scripti çalışmazsa:

```bash
cd ~/.local/share/byedpi-turkey
sudo ./make.sh remove
```

---

## Sık Karşılaşılan Sorunlar

Henüz Fedora sürümü için hata ile karşılaşmadık.

OpenSUSE (veya tabanlı bir dağıtım) kullanıyorsanız DNS ile ilgili sorun yaşama ihtimalinizden ötürü internete erişiminizi cihazınızda kaybetme şansınız var. Bu durumda aşağıdaki adımları takip edin:
```sh
su -
echo "nameserver 1.1.1.1" >> /etc/resolv.conf
```
Bu adımlardan sonra rahatlıkla kullanmaya devam edebilirsiniz.

---

## Komut Satırı Kullanımı

`byedpictl` komutlarının tamamını kullanabilirsiniz:

```bash
byedpictl help
byedpictl tun start
byedpictl tun stop
byedpictl tun restart
byedpictl tun change [profil-ismi] # profil değiştirir
byedpictl tun status

byedpictl zenity   # grafik arayüzü açar
```

## Yeni Profil Ekleme

Yeni profiller eklemek için `/etc/byedpictl/profiles/` dizinine `.conf` uzantılı dosyalar ekleyebilirsiniz. Her profil dosyası aşağıdaki formatta olmalıdır:

```bash
CIADPI_DESYNC=(
    "--param1=value1" "--param2=value2" #...
)
```
  
