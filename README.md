برای نصب و تنظیم منوی جهانی در Arch با XFCE:

1. نصب پکیج‌های لازم:
```bash
yay -S vala-panel-appmenu-xfce xfce4-appmenu-plugin
```

2. افزودن این خطوط به ~/.profile:
```bash
if [ "$XDG_CURRENT_DESKTOP" = "XFCE" ]; then
    export UBUNTU_MENUPROXY=1
    export GTK_MODULES=appmenu-gtk-module
fi
```

3. نصب ماژول‌های GTK:
```bash
sudo pacman -S appmenu-gtk-module
```

4. به پنل XFCE برید:
- راست کلیک روی پنل
- Add New Items
- جستجوی "Global Menu"
- اضافه کردن به پنل

5. سیستم رو ریستارت کنید

حالا باید منوی برنامه‌ها در پنل بالا نمایش داده بشه.

اگر برخی برنامه‌ها کار نکردند:
```bash
yay -S appmenu-gtk-module-git
```
