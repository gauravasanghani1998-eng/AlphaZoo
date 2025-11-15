"""
AlphaZoo - Alphabet Image Cropper
Automatically crops the 26-letter grid image into individual letter files
"""

from PIL import Image
import os
import sys

def crop_alphabet_grid(input_image_path, output_dir):
    """
    Crop a grid image of 26 alphabet letters into individual files.
    
    Args:
        input_image_path: Path to the source image
        output_dir: Directory to save cropped images
    """
    
    print(f"Loading image: {input_image_path}")
    
    # Load the image
    img = Image.open(input_image_path)
    width, height = img.size
    print(f"Image size: {width}x{height}")
    
    # The grid appears to be 7 columns x 4 rows (28 cells, using 26)
    # Row 1: A B C D E F G (7 letters)
    # Row 2: H I J K L M (6 letters, but 7 cells with last empty)
    # Row 3: N O P Panda Q R S (7 letters)
    # Row 4: T U V W X Y Z (7 letters)
    
    cols = 7
    rows = 4
    
    cell_width = width // cols
    cell_height = height // rows
    
    print(f"Grid: {cols} columns x {rows} rows")
    print(f"Cell size: {cell_width}x{cell_height}")
    
    # Letter positions in the grid (row, col)
    # 0-indexed, reading left to right, top to bottom
    letter_positions = {
        'a': (0, 0), 'b': (0, 1), 'c': (0, 2), 'd': (0, 3), 
        'e': (0, 4), 'f': (0, 5), 'g': (0, 6),
        'h': (1, 0), 'i': (1, 1), 'j': (1, 2), 'k': (1, 3), 
        'l': (1, 4), 'm': (1, 5),
        'n': (2, 0), 'o': (2, 1), 'p': (2, 2), 'q': (2, 4), 
        'r': (2, 5), 's': (2, 6),
        't': (3, 0), 'u': (3, 1), 'v': (3, 2), 'w': (3, 3), 
        'x': (3, 4), 'y': (3, 5), 'z': (3, 6),
    }
    
    # Create output directory if it doesn't exist
    os.makedirs(output_dir, exist_ok=True)
    
    letters = 'abcdefghijklmnopqrstuvwxyz'
    cropped_count = 0
    
    for letter in letters:
        if letter in letter_positions:
            row, col = letter_positions[letter]
            
            # Calculate crop boundaries with some padding adjustment
            left = col * cell_width
            top = row * cell_height
            right = left + cell_width
            bottom = top + cell_height
            
            # Crop the region
            cropped = img.crop((left, top, right, bottom))
            
            # Optionally trim whitespace (add margin back)
            # This ensures clean crops
            cropped = cropped.crop(cropped.getbbox() or (0, 0, cell_width, cell_height))
            
            # Resize to consistent size (500x500 for Flutter)
            target_size = (500, 500)
            
            # Create a new image with padding to maintain aspect ratio
            cropped.thumbnail(target_size, Image.Resampling.LANCZOS)
            
            # Create white background
            new_img = Image.new('RGB', target_size, 'white')
            
            # Paste cropped image centered
            x_offset = (target_size[0] - cropped.width) // 2
            y_offset = (target_size[1] - cropped.height) // 2
            new_img.paste(cropped, (x_offset, y_offset))
            
            # Save as PNG
            output_path = os.path.join(output_dir, f'{letter}.png')
            new_img.save(output_path, 'PNG', quality=95)
            
            print(f"✓ Saved: {letter}.png ({cropped.width}x{cropped.height} -> 500x500)")
            cropped_count += 1
        else:
            print(f"✗ Skipped: {letter} (position not defined)")
    
    print(f"\n✅ Successfully cropped {cropped_count}/26 letters!")
    print(f"📁 Saved to: {output_dir}")
    
    return cropped_count

def main():
    # Get the script directory
    script_dir = os.path.dirname(os.path.abspath(__file__))
    project_root = os.path.dirname(script_dir)
    
    # Default paths
    input_image = os.path.join(project_root, 'alphabet_collection.png')
    output_dir = os.path.join(project_root, 'assets', 'images')
    
    # Check if custom input path provided
    if len(sys.argv) > 1:
        input_image = sys.argv[1]
    
    if len(sys.argv) > 2:
        output_dir = sys.argv[2]
    
    # Check if input image exists
    if not os.path.exists(input_image):
        print(f"❌ Error: Input image not found: {input_image}")
        print(f"\nUsage: python {sys.argv[0]} <input_image> [output_dir]")
        print(f"Example: python {sys.argv[0]} alphabet_collection.png assets/images/")
        sys.exit(1)
    
    # Crop the images
    try:
        count = crop_alphabet_grid(input_image, output_dir)
        
        if count == 26:
            print("\n🎉 All done! Your AlphaZoo app now has all letter images!")
        else:
            print(f"\n⚠️  Warning: Only {count}/26 letters were cropped. Check the grid layout.")
        
    except Exception as e:
        print(f"\n❌ Error occurred: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)

if __name__ == '__main__':
    main()

