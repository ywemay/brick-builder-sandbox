# 🧱 Brick Builder Sandbox - Godot 4.6

A creative sandbox game for kids to build with virtual LEGO-style bricks. Drag, drop, rotate, and stack bricks with realistic physics.

## 🎮 Features

### ✅ **Core Gameplay**
- **Drag & Drop Placement**: Click/touch and drag to place bricks with ghost preview
- **Physics**: Realistic gravity, collisions, and stacking
- **Floor & Boundaries**: Bricks stay on screen and stack properly
- **Clear All**: One-click cleanup of all bricks

### 🎨 **Creative Tools**
- **7 Colors**: Red, Blue, Green, Yellow, Black, White, Special
- **28+ Brick Types**: Different shapes and sizes per color
- **Rotation**: 90° increments (right-click or R key while dragging)
- **Grid Snapping**: Precise 64px grid alignment

### 📱 **Platform Support**
- **Desktop**: Mouse controls (click+drag, right-click rotate)
- **Mobile**: Touch controls (drag, long-press to rotate)
- **Godot 4.6**: Optimized for latest Godot features

## 🚀 Quick Start

1. **Open Godot 4.6** (must be version 4.6 or later)
2. **Click "Import"**
3. **Navigate to** this project folder
4. **Select** `project.godot`
5. **Click "Open"**
6. **Press F5** to run the game

## 🎯 Controls

### **Desktop (Mouse & Keyboard)**
- **Left Click + Drag**: Place brick with ghost preview
- **Right Click**: Rotate brick while dragging (90° increments)
- **R Key**: Rotate brick while dragging
- **ESC**: Cancel current drag
- **Clear All Button**: Remove all bricks

### **Mobile (Touch)**
- **Touch + Drag**: Place brick with ghost preview
- **Long Press** (0.5+ seconds): Rotate brick while dragging
- **Clear All Button**: Remove all bricks

## 📁 Project Structure

```
brick-builder-sandbox/
├── 📄 project.godot          # Godot project configuration
├── 📄 Main.tscn             # Main scene with UI
├── 📄 Main.gd              # Game logic (4361 lines)
├── 📄 Brick.tscn           # Brick template scene
├── 📄 Brick.gd             # Brick physics & rotation
├── 📄 ColorSelector.gd     # Color selection UI
├── 📄 BrickSelector.gd     # Brick type selection UI
├── 📄 DragDropSystem.gd    # Drag & drop with ghost preview
├── 📄 TouchInput.gd        # Mobile touch support
├── 📄 FloorVisual.gd       # Visual floor indicator
├── 📄 README.md           # This file
└── 📁 assets/bricks/       # 183 brick textures
    ├── Red/ (28 bricks)
    ├── Blue/ (28 bricks)
    ├── Green/ (28 bricks)
    ├── Yellow/ (28 bricks)
    ├── Black/ (28 bricks)
    ├── White/ (28 bricks)
    └── Special/ (15 bricks)
```

## 🔧 Technical Details

### **Physics System**
- **RigidBody2D**: Each brick is a physics object
- **Floor**: Static body at bottom of screen
- **Boundaries**: Invisible walls on sides
- **Grid Snapping**: 64px grid for precise placement
- **Rotation**: Collision shapes rotate with sprites

### **Input System**
- **Unified Input**: Single code path for mouse and touch
- **Ghost Preview**: Semi-transparent preview while dragging
- **Rotation States**: Maintains rotation angle during drag

### **UI System**
- **Dynamic Discovery**: Automatically finds available brick types
- **Color-coded Buttons**: Visual feedback for selections
- **Touch-friendly**: Large buttons for mobile use

## 🎨 Asset Credits

Brick textures from **Kenney's Toy Brick Pack** (CC0 1.0):
- 183 high-quality PNG textures
- 7 color variations
- Multiple shapes and sizes
- Perfect for LEGO-style building

## 🚀 Next Steps (Potential Enhancements)

1. **Save/Load**: Save creations to file
2. **Undo/Redo**: Step-by-step building
3. **Building Templates**: Pre-made structures to copy
4. **Multi-touch**: Two-finger gestures for zoom/rotate
5. **Audio**: Placement and collision sounds
6. **Particle Effects**: Visual feedback for actions
7. **Export**: Share creations as images

## 🐛 Troubleshooting

### **Common Issues:**

1. **"Invalid UID" error**: 
   - Delete `.godot/` folder
   - Remove `.import` files
   - Re-import project

2. **Bricks falling off screen**:
   - Ensure `create_floor()` and `create_boundaries()` are called
   - Check floor_y = 650 matches screen height

3. **Textures not loading**:
   - Verify assets are in `assets/bricks/` folder
   - Check file permissions

4. **Rotation not working**:
   - Make sure `set_rotation_angle()` is called on brick
   - Check collision shape rotation matches sprite

### **Godot 4.6 Requirements:**
- Must use Godot 4.6 or later
- Project configured with `config/features=PackedStringArray("4.6")`
- Uses modern GDScript features (@onready, etc.)

## 📊 Performance Notes

- **Physics Optimization**: Bricks can sleep when idle
- **Texture Loading**: Loads on-demand, not at startup
- **UI Efficiency**: Buttons created dynamically
- **Grid System**: Reduces physics calculations

## 🤝 Contributing

This is a complete, working project. Feel free to:
- Add new features
- Improve UI/UX
- Optimize performance
- Create new brick types
- Port to other platforms

## 📄 License

Project code: MIT License
Assets: Kenney's Toy Brick Pack (CC0 1.0)

---

**Enjoy building!** 🧱✨

*Built with Godot 4.6 | Tested and working | Kid-friendly interface*