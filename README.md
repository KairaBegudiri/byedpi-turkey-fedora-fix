# ByeDPI TR Fix

Linux için ByeDPI TR'nin düzenlenmiş versiyonu.

---

## **Dağıtım Durumları**  
### Aktif
| Dağıtım       | Durum                          |
|-------------|--------------------------------|
| Fedora 42      | Çalışıyor ✅                   |
| OpenSUSE      | ⚠️ Bu sürüm çalışıyor olsa da deneyseldir. ⚠️ |

### Yakın Vakitte Eklemeyi Planladıklarımız
| Dağıtım    | Durum       | Tarih |
|--------------|-------------|--------------|
| Arch Linux | Planlandı | 5 Ekim 2025, kararlı sürüm
| Gentoo      | Planlandı | X
| NixOS      | Planlandı | X 
| Mandriva | Planlandı | X

### Uzun Zaman Sonrası İçin Planlı
| İşletim Sistemi    | Durum       | Tarih |
|--------------|-------------|--------------|
| MacOS | Planlandı | kod tabanı baştan yapıldıktan sonrasına planlı
| FreeBSD | Planlandı | kod tabanı baştan yapıldıktan sonrasına planlı
| QUNICS | Planlandı | kod tabanı baştan yapıldıktan sonrasına planlı

### **Test Edilen ISS'ler**  
| Sağlayıcı    | Profil       | Durum |
|--------------|-------------|--------------|
| Türk Telekom | ``varsayilan-profil`` | Çalışıyor ✅
| SuperOnline  | ``varsayilan-profil`` | Çalışıyor ✅

---

## Yasal Uyarı
* Proje GPL-v3 olarak yeniden lisanslanmıştır. Yapacağınız fork ve çalışmaların bu lisansa uygun olduğundan emin olun.

* Bu uygulamanın kullanımından doğan her türlü yasal sorumluluk kullanan kişiye aittir. Uygulama yalnızca eğitim ve araştırma amaçları ile yazılmış ve düzenlenmiş olup; bu uygulamayı bu şartlar altında kullanmak ya da kullanmamak kullanıcının kendi seçimidir. Açık kaynak kodlarının paylaşıldığı bu platformdaki düzenlenmiş bu proje, bilgi paylaşımı ve kodlama eğitimi amaçları ile yazılmış ve düzenlenmiştir.

---

## Notlar

* **Resmi desteğimiz Fedora üzerinedir.**
  Orjinal projenin de Fedora desteği olsa da bu desteğin hiç stabil olmadığını ve epey sorunlu olduğunu fark ettik. Yapmış olduğumuz bu proje yalnızca Fedora'ya yöneliktir.
* **OpenSUSE/Gentoo/NixOS/OpenMandriva desteği**
Bu sürümler deneyseldir. Odak noktamız olmasalar da onları da destekliyoruz.

---

## Kurulum
GitHub üzerinden repo'yu uygun konuma klonlayın.
### Fedora
```bash
git clone https://github.com/KairaBegudiri/byedpi-turkey-fedora-fix
cd byedpi-turkey-fedora-fix
sudo sh curl.sh && sudo sh kurulum.sh
```
### SUSE Linux
```bash
git clone https://github.com/KairaBegudiri/byedpi-turkey-fedora-fix
cd byedpi-turkey-fedora-fix
sudo sh curl.sh && sudo sh kurulum_suse.sh
```
---

---

## Sık Karşılaşılan Sorunlar

* Henüz Fedora sürümü için hata ile karşılaşmadık.

* OpenSUSE (veya tabanlı bir dağıtım) kullanıyorsanız DNS ile ilgili sorun yaşama ihtimalinizden ötürü internete erişiminizi cihazınızda kaybetme şansınız var. Bu durumda aşağıdaki adımları takip edin:
```sh
su -
echo "nameserver 1.1.1.1" >> /etc/resolv.conf
exit
```
Bu adımlardan sonra rahatlıkla kullanmaya devam edebilirsiniz.

---

## Arkaplanda aşağıdaki araçları kullanır:

* [dnscrypt-proxy](https://github.com/DNSCrypt/dnscrypt-proxy)
* [byedpictl](https://github.com/maximilionus/byedpictl)
* [byedpi](https://github.com/hufrea/byedpi)
* [hev-socks5-tunnel](https://github.com/heiher/hev-socks5-tunnel)

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
  
