فایل اسکریپت `fix-resolution.sh` رو با این محتوا بسازید:

```bash
#!/bin/bash

# نصب درایورهای مورد نیاز
sudo pacman -S --noconfirm xf86-video-intel intel-media-driver

# ایجاد فایل تنظیمات اینتل
sudo tee /etc/X11/xorg.conf.d/20-intel.conf << 'EOF'
Section "Device"
    Identifier  "Intel Graphics"
    Driver      "intel"
    Option      "TearFree" "true"
    Option      "DRI" "3"
EndSection

Section "Monitor"
    Identifier "Monitor0"
    Modeline "1600x740_60.00" 99.50 1600 1696 1864 2128 740 743 753 789 -hsync +vsync
EndSection

Section "Screen"
    Identifier "Screen0"
    Monitor "Monitor0"
    DefaultDepth 24
    SubSection "Display"
        Modes "1600x740"
    EndSubSection
EndSection
EOF

# ویرایش گراب
sudo sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT=".*"/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash i915.modeset=1 video=1600x740"/' /etc/default/grub

# آپدیت گراب
sudo grub-mkconfig -o /boot/grub/grub.cfg

# ایجاد اسکریپت xrandr
sudo tee /usr/local/bin/set-resolution << 'EOF'
#!/bin/bash
xrandr --newmode "1600x740_60.00" 99.50 1600 1696 1864 2128 740 743 753 789 -hsync +vsync
output=$(xrandr | grep " connected" | cut -d " " -f1)
xrandr --addmode $output "1600x740_60.00"
xrandr --output $output --mode "1600x740_60.00"
EOF

# دادن دسترسی اجرا به اسکریپت
sudo chmod +x /usr/local/bin/set-resolution

# اضافه کردن اسکریپت به استارتاپ
mkdir -p ~/.config/autostart
cat << EOF > ~/.config/autostart/set-resolution.desktop
[Desktop Entry]
Type=Application
Name=Set Resolution
Exec=/usr/local/bin/set-resolution
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
EOF

echo "تنظیمات انجام شد. لطفا سیستم را ریستارت کنید."
```

برای اجرا:
1. فایل رو با این دستور بسازید:
```bash
nano fix-resolution.sh
```

2. محتوای بالا رو کپی کنید داخلش

3. دسترسی اجرا بدید:
```bash
chmod +x fix-resolution.sh
```

4. اجرا کنید:
```bash
./fix-resolution.sh
```

5. سیستم رو ریستارت کنید

این اسکریپت:
- درایورها رو نصب میکنه
- فایل‌های تنظیمات رو میسازه
- گراب رو آپدیت میکنه
- یک اسکریپت برای تنظیم رزولوشن میسازه
- اون رو به استارتاپ اضافه میکنه

بعد از ریستارت، رزولوشن باید درست شده باشه.