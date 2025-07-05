#!/bin/bash

THEME_NAME="2zs-theme"
PLYMOUTH_DIR="/usr/share/plymouth/themes/$THEME_NAME"
DESKTOP_DIR="$HOME/Desktop"

echo "🔥 Installing WHITE ✠ ANGEL Plymouth Theme 🔥"

# 1. إنشاء مجلد الثيم
sudo mkdir -p "$PLYMOUTH_DIR"

# 2. نسخ الصور
sudo cp "$DESKTOP_DIR/logo1.png" "$PLYMOUTH_DIR/"
sudo cp "$DESKTOP_DIR/logo2.png" "$PLYMOUTH_DIR/"

# 3. إنشاء ملف .plymouth
cat <<EOF | sudo tee "$PLYMOUTH_DIR/$THEME_NAME.plymouth" > /dev/null
[Plymouth Theme]
Name=WHITE ANGEL
Description=DarkWeb Custom Boot Theme
ModuleName=script

[script]
ImageDir=$PLYMOUTH_DIR
ScriptFile=$PLYMOUTH_DIR/$THEME_NAME.script
EOF

# 4. إنشاء ملف .script
cat <<'EOF' | sudo tee "$PLYMOUTH_DIR/$THEME_NAME.script" > /dev/null
logo1 = Image("logo1.png");

Window.SetBackgroundTopColor(0.0, 0.0, 0.0);
Window.SetBackgroundBottomColor(0.0, 0.0, 0.0);

logo1.SetPosition(Window.GetWidth()/2 - logo1.GetWidth()/2, Window.GetHeight()/2 - logo1.GetHeight()/2);
logo1.Show();
Sleep(2);
logo1.Hide();

title = Text("𝐖𝐇𝐈𝐓𝐄 ✠ 𝐀𝐍𝐆𝐄𝐋");
title.SetFont("DejaVu Sans 24");
title.SetPosition(Window.GetWidth()/2 - title.GetWidth()/2, Window.GetHeight()/2 - 50);
title.Show();

subtitle = Text("𝐑𝐈𝐒𝐈𝐍𝐆 𝐅𝐑𝐎𝐌 𝐒𝐈𝐋𝐄𝐍𝐂𝐄. 𝐂𝐎𝐌𝐌𝐀𝐍𝐃𝐈𝐍𝐆 𝐄𝐕𝐄𝐑𝐘𝐓𝐇𝐈𝐍𝐆");
subtitle.SetFont("DejaVu Sans 14");
subtitle.SetColor(0.6, 0.6, 0.6);
subtitle.SetPosition(Window.GetWidth()/2 - subtitle.GetWidth()/2, Window.GetHeight()/2 + 20);
subtitle.Show();

for (i = 0; i < 120; i++) {
    phase = Math.Sin(i / 5.0);
    r = 0.4 + 0.2 * phase;
    g = 0.3 + 0.2 * phase;
    b = 0.6 + 0.2 * phase;
    title.SetColor(r, g, b);
    Sleep(0.03);
}
EOF

# 5. تفعيل الثيم
sudo plymouth-set-default-theme -R "$THEME_NAME"

# 6. إعادة بناء initramfs
sudo mkinitcpio -P

echo "✅ تم تثبيت وتفعيل واجهة الإقلاع WHITE ✠ ANGEL"
echo "🎯 أعد تشغيل جهازك الآن للاستمتاع بالواجهة الجديدة!"