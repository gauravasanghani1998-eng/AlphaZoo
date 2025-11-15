# How to Crop the Alphabet Collection Image

## Quick Start

### Step 1: Save the Uploaded Image

Save your alphabet collection image (the one with all 26 letters) as:
```
D:\Flutter_Project\AlphaZoo\alphabet_collection.png
```

### Step 2: Install Python Pillow (if not installed)

```bash
pip install Pillow
```

### Step 3: Run the Cropping Script

```bash
cd D:\Flutter_Project\AlphaZoo
python tools/crop_alphabet_image.py alphabet_collection.png
```

### Step 4: Verify

Check `assets/images/` folder - you should see:
- a.png
- b.png  
- c.png
- ... (all 26 letters)

## Alternative: Manual Method

If Python isn't available, see the detailed manual cropping guide in `tools/image_extractor_guide.md`.

## What the Script Does

1. Loads your alphabet collection image
2. Detects the 7x4 grid layout
3. Crops each letter section
4. Resizes to consistent 500x500px
5. Saves as a.png through z.png in assets/images/

## Grid Layout

The script expects this layout:
```
Row 1: A B C D E F G
Row 2: H I J K L M (space)
Row 3: N O P (Panda) Q R S  
Row 4: T U V W X Y Z
```

## Troubleshooting

**"Module not found: PIL"**
```bash
pip install Pillow
```

**"Input image not found"**
- Make sure you saved the image as `alphabet_collection.png` in the project root
- Or provide the full path: `python tools/crop_alphabet_image.py "C:\path\to\your\image.png"`

**Wrong crops**
- The grid layout might be different than expected
- Try manual cropping using GIMP or Photoshop
- See `tools/image_extractor_guide.md`

