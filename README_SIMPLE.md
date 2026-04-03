# 🧱 Brick Builder Sandbox

A creative sandbox game for kids to build with virtual LEGO-style bricks. Drag, drop, rotate, and stack bricks with realistic physics in Godot 4.6.

## 🎮 Features

- **7 Colors**: Red, Blue, Green, Yellow, Black, White, Special
- **28+ Brick Types**: Different shapes and sizes per color
- **Drag & Drop**: Ghost preview with smooth dragging
- **Grid Snapping**: 64px grid for precise placement
- **Rotation**: 90° increments (button + right-click + R key)
- **Touch Support**: Mobile-friendly controls
- **Physics**: Realistic gravity, collisions, and stacking
- **Clear All**: One-button cleanup

## 🚀 Quick Start

1. **Clone the repository:**
   ```bash
   git clone https://github.com/ywemay/brick-builder-sandbox.git
   cd brick-builder-sandbox
   ```

2. **Open in Godot 4.6:**
   - Launch Godot 4.6 (must be 4.6 or later)
   - Click "Import"
   - Navigate to the project folder
   - Select `project.godot`
   - Click "Open"

3. **Run the game:**
   - Press **F5** or click the **Play button**
   - Start building!

## 🎯 Controls

### **Desktop (Mouse & Keyboard)**
- **Left Click + Drag**: Place brick (ghost preview)
- **Right Click**: Rotate brick 90° while dragging
- **R Key**: Rotate brick while dragging  
- **ESC**: Cancel current drag
- **Clear All Button**: Remove all bricks
- **Rotate Button**: UI button to rotate while dragging

### **Mobile (Touch)**
- **Touch + Drag**: Place brick
- **Rotate Button**: UI button to rotate while dragging
- **Clear All Button**: Remove all bricks

## 📁 Project Structure

```
brick-builder-sandbox/
├── project.godot          # Godot 4.6 project configuration
├── Main.tscn             # Main scene with UI
├── Main.gd              # Game logic
├── Brick.tscn           # Brick template scene
├── Brick.gd             # Brick physics & rotation
├── ColorSelector.gd     # Color selection UI
├── BrickSelector.gd     # Brick type selection UI
├── DragDropSystem.gd    # Drag & drop with ghost preview
├── TouchInput.gd        # Mobile touch support
├── FloorVisual.gd       # Visual floor indicator
├── README.md           # Detailed documentation
├── QUICK_START.md      # Quick start guide
└── assets/bricks/       # 183 brick textures (Kenney's Toy Brick Pack)
```

## 🎨 Asset Credits

Brick textures from **Kenney's Toy Brick Pack** (CC0 1.0):
- 183 high-quality PNG textures
- 7 color variations
- Multiple shapes and sizes
- Perfect for LEGO-style building

## 📄 License

Project code: MIT License  
Assets: Kenney's Toy Brick Pack (CC0 1.0)

## 🤝 Contributing

Feel free to:
- Add new features
- Improve UI/UX
- Optimize performance
- Create new brick types
- Port to other platforms

## 🐛 Issues

If you encounter any issues:
1. Make sure you're using **Godot 4.6** or later
2. Check the console for error messages
3. Delete `.godot/` folder and re-import if needed

---

**Enjoy building!** 🧱✨

*Built with Godot 4.6 | Tested and working | Kid-friendly interface*