#!/bin/bash

set -euo pipefail

echo "=== ByeDPI Fedora Kurulum Betiği Başlatıldı ==="

sudo pkill -f hev-socks5-tunnel 2>/dev/null || true
echo "Tünel Boşaltıldı"

INSTALL_CMD="dnf install -y"

echo ">>> Gerekli paketler kuruluyor..."
sudo $INSTALL_CMD dnscrypt-proxy zenity

select_profile() {
  echo
  echo "Mevcut profiller:"
  local profile_files=()
  if [[ -d "profiles" ]] && [[ -n "$(ls profiles/*.conf 2>/dev/null)" ]]; then
    profile_files=(profiles/*.conf)
  fi

  if [[ ${#profile_files[@]} -eq 0 ]]; then
    echo "Varsayılan profil kullanılacak."
    selected_profile="varsayilan-profil"
    return
  fi

  local i=1
  for file in "${profile_files[@]}"; do
    echo "$i - $(basename "$file" .conf)"
    ((i++))
  done

  read -p "Bir profil seçiniz (1-${#profile_files[@]}): " selected_index
  if [[ "$selected_index" =~ ^[0-9]+$ && $selected_index -ge 1 && $selected_index -le ${#profile_files[@]} ]]; then
    selected_profile=$(basename "${profile_files[$((selected_index-1))]}" .conf)
  else
    echo "Geçersiz seçim. Varsayılan profil kullanılacak."
    selected_profile="varsayilan-profil"
  fi
}

apply_profile() {
  local profil_dosyasi="profiles/${selected_profile}.conf"
  local hedef_dosya="src/conf/desync.conf"

  if [[ -f "$profil_dosyasi" ]]; then
    cp "$profil_dosyasi" "$hedef_dosya"
    echo "Profil başarıyla uygulandı: $selected_profile"
  else
    echo "Varsayılan profil uygulanıyor..."
    cat > "$hedef_dosya" <<'EOF'
CIADPI_DESYNC=(
    "--tlsrec=1+s"
)
EOF
  fi
}

setup_dnscrypt() {
  echo ">>> dnscrypt-proxy ayarlanıyor..."
  sudo cp configs/dnscrypt-proxy.toml /etc/dnscrypt-proxy/dnscrypt-proxy.toml
  sudo systemctl enable --now dnscrypt-proxy.service
}

set_nm_dns_none() {
  local DNS_NONE="/etc/NetworkManager/conf.d/90-dns-none.conf"
  echo ">>> NetworkManager dns=none ayarlanıyor..."
  sudo tee "$DNS_NONE" >/dev/null <<'EOF'
[main]
dns=none
EOF
}

update_resolvconf() {
  echo ">>> resolv.conf güncelleniyor..."
  sudo cp /etc/resolv.conf /etc/resolv.conf.bak || true
  sudo cp configs/resolv.conf /etc/resolv.conf
}

set_active_dns() {
  if command -v nmcli &> /dev/null; then
    aktif_ag=$(nmcli -t -f NAME connection show --active | head -n1)
    if [[ -n "$aktif_ag" ]]; then
      nmcli connection modify "$aktif_ag" ipv4.dns "127.0.0.1"
      nmcli connection modify "$aktif_ag" ipv4.ignore-auto-dns yes
      nmcli connection down "$aktif_ag" 2>/dev/null || true
      sleep 1
      nmcli connection up "$aktif_ag"
    fi
  fi
}

install_byedpi() {
  echo ">>> byedpi kuruluyor..."
  sudo bash make.sh install
}

activate_byedpi() {
  if command -v byedpictl &> /dev/null; then
    sudo byedpictl tun start
    echo "byedpictl başarıyla başlatıldı."
  fi
}

select_profile
apply_profile
setup_dnscrypt
set_nm_dns_none
update_resolvconf
install_byedpi
set_active_dns
activate_byedpi

echo "=== ByeDPI TR Fedora üzerinde başarıyla kuruldu ==="
