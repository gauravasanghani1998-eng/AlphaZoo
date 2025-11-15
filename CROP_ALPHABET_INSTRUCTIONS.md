# 🎨 AlphaZoo - Crop Alphabet Image Instructions

## 📸 You Have 3 Easy Options

---

## ⭐ **Option 1: Browser Tool (RECOMMENDED - Easiest)**

### Steps:

1. **Open the HTML tool:**
   - Navigate to: `D:\Flutter_Project\AlphaZoo\tools\crop_alphabet_online.html`
   - Double-click to open in your web browser

2. **Upload your alphabet image:**
   - Drag and drop the image OR click to browse
   - The image with all 26 letters

3. **Click "Crop All Letters":**
   - Wait for automatic cropping (takes ~5 seconds)
   - You'll see a preview of all 26 letters

4. **Click "Download ZIP":**
   - A file named `alphabet_letters.zip` will download
   - Extract the ZIP file
   - You'll get: a.png, b.png, c.png, ... z.png

5. **Move to project:**
   ```
   Copy all 26 .png files to:
   D:\Flutter_Project\AlphaZoo\assets\images\
   ```

6. **Done!** Run your app:
   ```bash
   flutter run
   ```

---

## 🐍 **Option 2: Python Script (If you install Python)**

### Steps:

1. **Install Python:**
   - Download from: https://www.python.org/downloads/
   - During installation, check "Add Python to PATH"

2. **Install Pillow:**
   ```bash
   pip install Pillow
   ```

3. **Save your alphabet image as:**
   ```
   D:\Flutter_Project\AlphaZoo\alphabet_collection.png
   ```

4. **Run the script:**
   ```bash
   cd D:\Flutter_Project\AlphaZoo
   python tools/crop_alphabet_image.py
   ```

5. **Check results:**
   - All 26 images automatically saved to `assets/images/`

---

## ✂️ **Option 3: Manual Cropping (Using Image Editor)**

### Using Paint.NET (Free) or Photoshop:

1. **Download Paint.NET:** https://www.getpaint.net/ (if needed)

2. **Open your alphabet image**

3. **For each letter (A-Z):**
   - Use Rectangle Select tool
   - Select the letter area
   - Copy (Ctrl+C)
   - New image (Ctrl+N)
   - Paste (Ctrl+V)
   - Save as: `a.png`, `b.png`, etc.
   - Save to: `D:\Flutter_Project\AlphaZoo\assets\images\`

4. **Repeat for all 26 letters**

---

## 📋 **What You're Cropping**

Your image has this layout:

```
Row 1: A(apple)  B(ball)   C(cat)    D(dolphin) E(elephant) F(fish)    G(giraffe)
Row 2: H(house)  I(ice)    J(jar)    K(kite)    L(lemon)    M(monkey)  [empty]
Row 3: N(nest)   O(orange) P(panda)  [panda]    Q(queen)    R(rocket)  S(sun)
Row 4: T(tree)   U(umbrella) V(violin) W(whale)  X(xylophone) Y(yacht) Z(zebra)
```

---

## ✅ **Verification Checklist**

After cropping, verify you have:

- [ ] 26 PNG files (a.png through z.png)
- [ ] All files in lowercase names
- [ ] All files in: `assets/images/`
- [ ] Each file shows only ONE letter with its illustration
- [ ] Consistent size (roughly 500x500px each)

Check with:
```bash
dir D:\Flutter_Project\AlphaZoo\assets\images\*.png
```

You should see 26 files listed.

---

## 🚀 **After Cropping - Run Your App**

1. **Clean and rebuild:**
   ```bash
   flutter clean
   flutter pub get
   ```

2. **Run the app:**
   ```bash
   flutter run
   ```

3. **Test:**
   - All 26 letters should show with images
   - Tap any letter to see details
   - Images should look clear and centered

---

## 🆘 **Troubleshooting**

### "Images not showing in app"
```bash
# Make sure files are in correct location:
dir assets\images\a.png
dir assets\images\z.png

# Clean and rebuild:
flutter clean
flutter pub get
flutter run
```

### "HTML tool not working"
- Make sure you have internet connection (uses CDN for ZIP library)
- Try a different browser (Chrome recommended)
- Check browser console for errors (F12)

### "Wrong crops / cut off images"
- The grid might have different spacing
- Try adjusting manually with an image editor
- Or adjust the grid values in the Python script

---

## 📊 **Expected Results**

After successful cropping:

```
assets/images/
├── a.png (Apple with A)
├── b.png (Ball with B)
├── c.png (Cat with C)
├── d.png (Dolphin with D)
├── e.png (Elephant with E)
├── f.png (Fish with F)
├── g.png (Giraffe with G)
├── h.png (House/Gift with H)
├── i.png (Ice cream with I)
├── j.png (Jar with J)
├── k.png (Kite with K)
├── l.png (Lemon with L)
├── m.png (Monkey/Mango with M)
├── n.png (Nest with N)
├── o.png (Orange with O)
├── p.png (Panda with P)
├── q.png (Queen with Q)
├── r.png (Rocket with R)
├── s.png (Sun with S)
├── t.png (Tree with T)
├── u.png (Umbrella with U)
├── v.png (Violin with V)
├── w.png (Whale with W)
├── x.png (Xylophone with X)
├── y.png (Yacht with Y)
└── z.png (Zebra with Z)
```

---

## 🎉 **Success!**

Once you have all 26 images in `assets/images/`, your AlphaZoo app is complete!

Run `flutter run` and explore your beautiful alphabet learning app!

---

## 📞 **Need Help?**

- **HTML tool issues:** Check browser console (F12)
- **Python issues:** Make sure Python and Pillow are installed
- **Manual cropping:** See detailed guide in `tools/image_extractor_guide.md`

---

**Recommendation:** Use Option 1 (Browser Tool) - it's the fastest and doesn't require any installations!

