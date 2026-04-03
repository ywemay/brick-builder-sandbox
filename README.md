# 🧱 Brick Builder Sandbox - Godot 4.6

A **kid-friendly** creative sandbox game for building with virtual LEGO-style bricks. Designed specifically for children with visual icons, simple controls, and fun interactions.

## 🎮 Features

### 👶 **Kid-Friendly Design**
- **Visual Brick Selector**: Scrollable panel with actual brick images (no text!)
- **Color Swatches**: Visual color buttons instead of text
- **Icon Buttons**: 🗑️ Clear, ↻ Rotate (easy for non-readers)
- **Fun Destruction**: Right-click bricks to make them 💥 explode!
- **Smart Interaction**: Click existing brick to MOVE it (not duplicate)

### ✅ **Core Gameplay**
- **Drag & Drop Placement**: Click/touch and drag to place bricks with ghost preview
- **Physics**: Realistic gravity, collisions, and stacking
- **Floor & Boundaries**: Bricks stay on screen and stack properly
- **Clear All**: One-click cleanup of all bricks

### 🎨 **Creative Tools**
- **7 Colors**: Red, Blue, Green, Yellow, Black, White, Special
- **28+ Brick Types**: Different shapes and sizes per color
- **Rotation**: 90° increments (button + right-click + R key)
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
- **Left Click + Drag**: Place new brick with ghost preview
- **Left Click on Brick**: Select and MOVE existing brick
- **Right Click on Brick**: 💥 Explode the brick!
- **Right Click (empty)**: Rotate ghost brick (90° increments)
- **R Key**: Rotate selected brick or ghost
- **ESC**: Cancel current operation
- **🗑️ Button**: Clear all bricks
- **↻ Button**: Rotate selected brick or ghost

### **Mobile (Touch)**
- **Touch + Drag**: Place new brick
- **Touch on Brick**: Select and MOVE existing brick
- **Long Press on Brick**: 💥 Explode the brick!
- **↻ Button**: Rotate selected brick
- **🗑️ Button**: Clear all bricks

## 📁 Project Structure

```
brick-builder-sandbox/
├── 📄 project.godot          # Godot project configuration
├── 📄 Main.tscn             # Main scene with kid-friendly UI
├── 📄 Main.gd              # Game logic with kid interactions
├── 📄 Brick.tscn           # Brick template scene
├── 📄 Brick.gd             # Brick physics & movement
├── 📄 VisualColorSelector.gd # Color swatches (no text)
├── 📄 VisualBrickSelector.gd # Brick images selector
├── 📄 DragDropSystem.gd    # Drag & drop with ghost preview
├── 📄 TouchInput.gd        # Mobile touch support
├── 📄 ExplosionEffect.gd   # 💥 Brick explosion particles
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

## 👶 Why Kid-Friendly Design Matters

This project was specifically designed for children who:
- **Can't read yet** → Uses images and icons instead of text
- **Need visual feedback** → Highlights selected bricks
- **Love destruction** → Right-click to 💥 explode bricks!
- **Make mistakes** → Click brick to move it (not duplicate)
- **Need simple UI** → Large buttons, clear icons

## 🚀 Next Steps (Potential Enhancements)

1. **Sound Effects**: Fun sounds for placement and explosions
2. **More Destruction**: Different explosion types
3. **Building Templates**: Pre-made structures kids can copy
4. **Color Mixing**: Combine colors for new effects
5. **Achievements**: "Built a tower!" badges
6. **Parent Controls**: Timer limits, save/load
7. **Export**: Share creations as images to show parents

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