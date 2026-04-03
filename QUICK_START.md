# 🚀 Quick Start - Brick Builder Sandbox

## **1. Open in Godot 4.6**
- Launch **Godot 4.6** (must be 4.6 or later)
- Click **"Import"**
- Navigate to this folder
- Select **`project.godot`**
- Click **"Open"**

## **2. Run the Game**
- Press **F5** or click the **Play button**
- Game window should open (1280x720)

## **3. Controls**

### **🎮 Desktop (Mouse & Keyboard)**
- **Left Click + Drag**: Place brick (ghost preview)
- **Right Click**: Rotate brick 90° while dragging
- **R Key**: Rotate brick while dragging  
- **ESC**: Cancel current drag
- **Clear All Button**: Remove all bricks
- **Rotate Button**: UI button to rotate while dragging

### **📱 Mobile (Touch)**
- **Touch + Drag**: Place brick
- **Rotate Button**: UI button to rotate while dragging
- **Clear All Button**: Remove all bricks

## **4. Building Steps**
1. **Select Color** (Red, Blue, Green, Yellow, Black, White, Special)
2. **Select Brick Type** (28+ shapes available)
3. **Click + Drag** to position brick
4. **Rotate** if needed (button, right-click, or R key)
5. **Release** to place brick
6. **Repeat** to build structures!

## **5. Features to Test**
- ✅ Bricks stack on floor (won't fall off)
- ✅ Grid snapping (64px increments)
- ✅ Physics collisions
- ✅ Color selection works
- ✅ Brick type selection works
- ✅ Rotation works (90° increments)
- ✅ Clear button removes all bricks
- ✅ Ghost preview while dragging

## **6. If You Get Errors**
1. **Parser Error**: Make sure you're using Godot 4.6+
2. **Texture Missing**: Check `assets/bricks/` folder exists
3. **Physics Issues**: Check floor_y = 650 in Main.gd
4. **Still Problems**: Delete `.godot/` folder and re-import

## **7. Project Structure**
```
📁 brick-builder-sandbox/
├── 📄 project.godot          # Godot 4.6 project
├── 📄 Main.tscn             # Main scene
├── 📄 Main.gd              # Game logic
├── 📄 Brick.tscn           # Brick template
├── 📄 Brick.gd             # Brick physics
├── 📄 ColorSelector.gd     # Color UI
├── 📄 BrickSelector.gd     # Brick type UI
├── 📄 DragDropSystem.gd    # Drag & drop
├── 📄 TouchInput.gd        # Mobile support
├── 📄 FloorVisual.gd       # Floor indicator
└── 📁 assets/bricks/       # 183 textures
```

## **8. Success Indicators**
- Window opens with "Brick Builder Sandbox - Godot 4.6" in console
- 4 test bricks appear in different colors
- Floor line visible at bottom
- UI buttons work
- Can place new bricks
- Bricks stack when placed on top of each other

---

**Enjoy building!** 🧱✨

*Project tested and working in Godot 4.6*