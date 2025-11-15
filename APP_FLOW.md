# AlphaZoo - Application Flow

Visual representation of the app's screen flow and navigation.

## 📱 Screen Flow Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                                                             │
│                    APP STARTS                               │
│                         ↓                                   │
│  ╔══════════════════════════════════════════════════════╗  │
│  ║                                                      ║  │
│  ║              SPLASH SCREEN                           ║  │
│  ║                                                      ║  │
│  ║  • App logo with scale/fade animation               ║  │
│  ║  • Optional Flame particle effects                  ║  │
│  ║  • Duration: 1.6 seconds                            ║  │
│  ║  • Auto-navigation to Home                          ║  │
│  ║                                                      ║  │
│  ╚══════════════════════════════════════════════════════╝  │
│                         ↓                                   │
│                    (Auto after 1.6s)                        │
│                         ↓                                   │
│  ╔══════════════════════════════════════════════════════╗  │
│  ║                                                      ║  │
│  ║               HOME SCREEN                            ║  │
│  ║                                                      ║  │
│  ║  ┌─────────────────────────────────────────────┐    ║  │
│  ║  │  Header                                     │    ║  │
│  ║  │  • App logo + "AlphaZoo"                    │    ║  │
│  ║  │  • Info button (→ About)                    │    ║  │
│  ║  └─────────────────────────────────────────────┘    ║  │
│  ║                                                      ║  │
│  ║  ┌─────────────────────────────────────────────┐    ║  │
│  ║  │  Title & Subtitle                           │    ║  │
│  ║  │  "Learn the Alphabet!"                      │    ║  │
│  ║  │  "Tap any letter to explore"                │    ║  │
│  ║  └─────────────────────────────────────────────┘    ║  │
│  ║                                                      ║  │
│  ║  ┌─────────────────────────────────────────────┐    ║  │
│  ║  │  Letter Grid (Responsive)                   │    ║  │
│  ║  │                                             │    ║  │
│  ║  │  ┌───┐ ┌───┐ ┌───┐ ┌───┐                   │    ║  │
│  ║  │  │ A │ │ B │ │ C │ │ D │  ...              │    ║  │
│  ║  │  └───┘ └───┘ └───┘ └───┘                   │    ║  │
│  ║  │  ┌───┐ ┌───┐ ┌───┐ ┌───┐                   │    ║  │
│  ║  │  │ E │ │ F │ │ G │ │ H │  ...              │    ║  │
│  ║  │  └───┘ └───┘ └───┘ └───┘                   │    ║  │
│  ║  │           ... (26 tiles total)              │    ║  │
│  ║  │                                             │    ║  │
│  ║  │  • Staggered entrance animations            │    ║  │
│  ║  │  • Tap scale animation                      │    ║  │
│  ║  │  • Hero tag for transitions                 │    ║  │
│  ║  │  • Tap tile → Detail Screen                 │    ║  │
│  ║  └─────────────────────────────────────────────┘    ║  │
│  ║                                                      ║  │
│  ╚══════════════════════════════════════════════════════╝  │
│              ↓                          ↓                   │
│       (Tap letter)              (Tap info icon)             │
│              ↓                          ↓                   │
│  ╔══════════════════╗        ╔════════════════════════╗    │
│  ║                  ║        ║                        ║    │
│  ║  DETAIL SCREEN   ║        ║    ABOUT SCREEN        ║    │
│  ║                  ║        ║                        ║    │
│  ║  ┌────────────┐  ║        ║  • App info            ║    │
│  ║  │ Header     │  ║        ║  • How to use          ║    │
│  ║  │ ← Letter A │  ║        ║  • Customization       ║    │
│  ║  └────────────┘  ║        ║  • Technology stack    ║    │
│  ║                  ║        ║  • Credits             ║    │
│  ║  ┌────────────┐  ║        ║  • Version info        ║    │
│  ║  │ Hero       │  ║        ║                        ║    │
│  ║  │  ╔═══╗     │  ║        ║  ← Back button         ║    │
│  ║  │  ║ A ║     │  ║        ║                        ║    │
│  ║  │  ╚═══╝     │  ║        ╚════════════════════════╝    │
│  ║  │ (Animated) │  ║                   ↓                  │
│  ║  └────────────┘  ║            (Tap back)                │
│  ║                  ║                   ↓                  │
│  ║  ┌────────────┐  ║         (Returns to Home)            │
│  ║  │ Image      │  ║                                      │
│  ║  │  [Apple]   │  ║                                      │
│  ║  │ (or icon)  │  ║                                      │
│  ║  └────────────┘  ║                                      │
│  ║                  ║                                      │
│  ║  ┌────────────┐  ║                                      │
│  ║  │ Word       │  ║                                      │
│  ║  │  "Apple"   │  ║                                      │
│  ║  └────────────┘  ║                                      │
│  ║                  ║                                      │
│  ║  ┌────────────┐  ║                                      │
│  ║  │Description │  ║                                      │
│  ║  │ "A is for  │  ║                                      │
│  ║  │  Apple..." │  ║                                      │
│  ║  └────────────┘  ║                                      │
│  ║                  ║                                      │
│  ║  ┌────────────┐  ║                                      │
│  ║  │ [Play 🔊]  │  ║                                      │
│  ║  │   Sound    │  ║                                      │
│  ║  └────────────┘  ║                                      │
│  ║                  ║                                      │
│  ║  ┌────────────┐  ║                                      │
│  ║  │[Prev][Next]│  ║                                      │
│  ║  └────────────┘  ║                                      │
│  ║                  ║                                      │
│  ║  ← Back          ║                                      │
│  ║                  ║                                      │
│  ╚══════════════════╝                                      │
│           ↓                                                │
│    (Tap back)                                              │
│           ↓                                                │
│  (Returns to Home with Hero animation)                     │
│                                                            │
└────────────────────────────────────────────────────────────┘
```

## 🎬 Animation Flow

### Splash → Home
```
Splash Screen
    ├─ Logo scales from 0.5 to 1.0 (elastic)
    ├─ Logo fades in (0 to 1)
    ├─ Particles float (optional Flame)
    └─ After 1.6s → Fade to Home Screen
```

### Home Screen
```
Home Screen
    ├─ Header fades in
    ├─ Grid tiles appear with stagger (30ms delay each)
    └─ On tap: tile scales down (0.9) then back to 1.0
```

### Home → Detail
```
Transition
    ├─ Letter tile (Hero animation to detail)
    ├─ Background fades to new screen
    └─ Content fades in + slides up
```

### Detail Screen
```
Detail Screen
    ├─ Hero letter appears (from home tile)
    ├─ Content fades in (0 to 1)
    ├─ Content slides up (offset 0.3 to 0)
    └─ Play button pulses when playing
```

### Navigation
```
Next/Previous
    ├─ Tap button → scale down
    ├─ Content fades out
    ├─ New letter data loads
    └─ Content fades in + slides up
```

## 🔄 User Interaction Flow

### Main User Journey

```
User opens app
    ↓
Sees splash screen (1.6s)
    ↓
Arrives at home screen
    ↓
Browses letter grid
    ↓
Taps a letter (e.g., "A")
    ↓
Sees letter details (Hero animation)
    ↓
Reads word ("Apple")
    ↓
Reads description
    ↓
Taps play button → Hears "A" sound
    ↓
Taps "Next" → Sees letter "B"
    ↓
Continues learning...
    ↓
Taps back → Returns to grid
    ↓
Taps info icon → Sees about screen
    ↓
Taps back → Returns to grid
```

## 📊 State Flow

### App State

```
├─ StatelessWidget: AlphaZooApp
│   └─ MaterialApp
│       └─ SplashScreen (StatefulWidget)
│           ├─ AnimationController (scale/fade)
│           └─ Timer (auto-navigation)
│               ↓
│           HomeScreen (StatefulWidget)
│           ├─ AnimationController (entrance)
│           ├─ Grid state (26 items)
│           └─ Navigation handlers
│               ↓
│           DetailScreen (StatefulWidget)
│           ├─ Current index (state)
│           ├─ AnimationControllers (content, scale)
│           ├─ AudioPlayer (state)
│           └─ Navigation handlers (prev/next)
```

## 🎯 Data Flow

```
AlphabetData (static)
    ├─ 26 AlphabetItem objects
    │   ├─ letter: String
    │   ├─ image: String (path)
    │   ├─ sound: String? (path)
    │   ├─ word: String
    │   └─ description: String
    ↓
Home Screen
    ├─ Displays all 26 items
    └─ Passes index to Detail
        ↓
    Detail Screen
        ├─ Gets item by index
        ├─ Displays letter info
        ├─ Plays audio (if available)
        └─ Navigates between items
```

## 🔊 Audio Flow

```
User taps Play button
    ↓
Check if sound file exists
    ├─ YES: Load audio file
    │   ├─ Update UI (isPlaying = true)
    │   ├─ Play audio
    │   ├─ Button pulses
    │   └─ On complete: isPlaying = false
    │
    └─ NO: Show SnackBar
        └─ "Sound file not available"
```

## 🖼 Image Loading Flow

```
Widget needs image
    ↓
Attempt to load from assets
    ├─ SUCCESS: Display image
    │
    └─ ERROR: Show fallback
        └─ Display icon placeholder
```

## 🎨 Theme Flow

```
App starts
    ↓
Loads AppColors
    ├─ Primary colors
    ├─ Letter color palette (10 colors)
    └─ Shadow colors
    ↓
Loads AppTextStyles
    ├─ Downloads Google Fonts
    │   ├─ Fredoka (headings)
    │   └─ Baloo 2 (body)
    └─ Applies to theme
    ↓
MaterialApp theme applied
    └─ All screens use theme
```

## 📱 Responsive Flow

```
Screen size detected
    ↓
Responsive utilities calculate:
    ├─ Grid columns (3-6)
    ├─ Grid spacing (12-20)
    ├─ Card radius (16-24)
    ├─ Horizontal padding (16-48)
    └─ Vertical padding (16-24)
    ↓
UI adapts automatically
```

## ⚠️ Error Handling Flow

```
Asset loading
    ├─ Image fails
    │   └─ Show placeholder icon
    │
    ├─ Sound fails
    │   ├─ Disable play button
    │   └─ Show SnackBar on tap
    │
    └─ Lottie/Flame fails
        └─ Use fallback animations
```

## 🔄 Component Relationships

```
AlphaZooApp
├─ SplashScreen
│   └─ SplashFlameGame (optional)
│       └─ FloatingParticle (20x)
│
├─ HomeScreen
│   ├─ AlphabetTile (26x)
│   └─ AboutScreen (modal)
│
└─ DetailScreen
    ├─ BigLetterWidget
    ├─ PlayButton
    └─ Navigation buttons
```

## 🎮 Animation Controllers

```
SplashScreen
├─ _controller (scale + fade)
└─ Timer (navigation)

HomeScreen
└─ _animationController (entrance)

DetailScreen
├─ _contentController (fade + slide)
└─ _scaleController (button press)

AlphabetTile
└─ _scaleController (tap animation)

PlayButton
└─ _pulseController (playing animation)
```

## 📋 Navigation Stack

```
[SplashScreen] → (replaces)
[HomeScreen] → (pushes)
[DetailScreen] ← (pops)
[HomeScreen] → (pushes)
[AboutScreen] ← (pops)
[HomeScreen]
```

## 🎯 Success Path

```
1. App launches successfully
2. Splash plays smoothly (60 FPS)
3. Home loads all 26 tiles
4. User taps letter
5. Hero animation is smooth
6. Detail screen shows content
7. Play button plays sound
8. Next/Prev navigation works
9. Back button returns to home
10. About screen accessible
```

## 📝 Notes

- All animations target 60 FPS
- Hero tags must be unique per letter
- Audio player is disposed properly
- State is reset on navigation
- Memory is managed efficiently
- Errors are handled gracefully
- App never crashes on missing assets

---

**This flow ensures a smooth, intuitive user experience for kids learning the alphabet!**

