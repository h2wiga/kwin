#!/bin/bash

# نصب بسته‌های مورد نیاز
sudo pacman -S --noconfirm xfce4 xfce4-goodies kwin plank picom alacritty zsh neofetch lolcat ttf-jetbrains-mono

# نصب yay اگر نصب نیست
if ! command -v yay &> /dev/null; then
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
    rm -rf yay
fi

# نصب تم WhiteSur از AUR
yay -S --noconfirm whitesur-gtk-theme whitesur-icon-theme whitesur-cursor-theme

# نصب Oh My Zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# نصب پلاگین‌های ZSH
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# تنظیم ZSH به عنوان شل پیش‌فرض
chsh -s $(which zsh)

# کانفیگ ZSH
cat > ~/.zshrc << 'EOL'
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh
EOL

# کانفیگ Alacritty
mkdir -p ~/.config/alacritty
cat > ~/.config/alacritty/alacritty.yml << 'EOL'
font:
  normal:
    family: JetBrains Mono
    style: Regular
  bold:
    family: JetBrains Mono
    style: Bold
  size: 12.0
EOL

# کانفیگ Picom
mkdir -p ~/.config/picom
cat > ~/.config/picom/picom.conf << 'EOL'
backend = "glx";
vsync = true;
shadow = true;
shadow-radius = 7;
shadow-offset-x = -7;
shadow-offset-y = -7;
shadow-opacity = 0.7;
fading = true;
fade-delta = 4;
fade-in-step = 0.03;
fade-out-step = 0.03;
EOL

# تنظیم اتوستارت برای Plank و Picom
mkdir -p ~/.config/autostart
cat > ~/.config/autostart/plank.desktop << 'EOL'
[Desktop Entry]
Type=Application
Name=Plank
Exec=plank
EOL

cat > ~/.config/autostart/picom.desktop << 'EOL'
[Desktop Entry]
Type=Application
Name=Picom
Exec=picom
EOL

# تنظیم KWin به عنوان مدیر پنجره
echo "kwin" > ~/.xprofile

# اعمال تم WhiteSur
xfconf-query -c xsettings -p /Net/ThemeName -s "WhiteSur-dark"
xfconf-query -c xsettings -p /Net/IconThemeName -s "WhiteSur-dark"
xfconf-query -c xfwm4 -p /general/theme -s "WhiteSur-dark"

# تنظیمات Plank
cat > ~/.config/plank/dock1/settings << 'EOL'
[PlankDockPreferences]
Theme=WhiteSur
IconSize=48
ZoomEnabled=true
EOL

echo "نصب و پیکربندی کامل شد. لطفاً سیستم را ریستارت کنید."