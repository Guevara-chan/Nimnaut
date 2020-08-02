{.pragma: NAUT, cdecl, dynlib: when sizeof(int)==32: "ne32.dll" else: "ne64.dll".}
# Adapted to Nim in 2*20 by Victoria A. Guevara:
# ------------------------------------------------------------------------------------
# Nautilus Engine (OpenGl 2D Engine)
# ------------------------------------------------------------------------------------
# Version: 1.070
# Author: Mijikai
# ------------------------------------------------------------------------------------
# Copyright 2020 by Mijikai all rights reserved
# ------------------------------------------------------------------------------------


const NAUTILUS_VERSION = 0x1070
type constants = enum
    NAUTILUS_WINDOW_NORMAL
    NAUTILUS_WINDOW_SIZEABLE
    NAUTILUS_WINDOW_POPUP
    NAUTILUS_WINDOW_SCREEN

type NAUTILUS_SIZE_STRUCT* = object
    x*: float32
    y*: float32
    cx*: float32
    cy*: float32

type NAUTILUS_TEXTURE_STRUCT* = object
    Object*: int
    size*: NAUTILUS_SIZE_STRUCT

type NAUTILUS_WINDOW* = ref object
    # *- Get window hwnd | returns the window handle
    Hwnd*: proc(self: ptr NAUTILUS_WINDOW): int {.cdecl.}
    # *- Get window width | returns client width
    Width*: proc(self: ptr NAUTILUS_WINDOW): int {.cdecl.}
    # *- Get window height | returns client height
    Height*: proc(self: ptr NAUTILUS_WINDOW): int {.cdecl.}
    # *- Get window icon (pointer to a icon in memory / needs to be *.icon) | returns true/false
    Icon*: proc(self: ptr NAUTILUS_WINDOW, Icon: pointer): int {.cdecl.}
    # *- Toggle fullscreen mode / [optional] Code = #VK_ keycode - if this key is pressed in fullscreen the window gets restored | returns true/false - fullscreen yes/no
    Screen*: proc(self: ptr NAUTILUS_WINDOW, Code = 0): int {.cdecl.}
    # *- Fullscreen mode active? | returns true/false
    ScreenMode*: proc(self: ptr NAUTILUS_WINDOW): int {.cdecl.}
    # *- Change the window title or append text to it | if the function fails the return value is zero
    Title*: proc(self: ptr NAUTILUS_WINDOW, Title: WideCString, Append = false.int): int {.cdecl.}
    # *- Hides the cursor (client area) | returns nothing
    CursorHide*: proc(self: ptr NAUTILUS_WINDOW, Flag = true.int): int {.cdecl.}
    # *- Clips the mouse cursor - the mouse cursor cant leave the window (client area) | returns nothing
    CursorClip*: proc(self: ptr NAUTILUS_WINDOW, Flag = true.int): int {.cdecl.}
    # *- Create a event timer (the timer attempts to get the highest possible resolution) - a event is fired if the set milliseconds have elapsed - point *Fps to a integer to get frames per second - point *Delta to a float to get the deltatime | returns true/false
    TimerCreate*: proc(self: ptr NAUTILUS_WINDOW, Fps = 0, Delta = 0, Milliseconds = 20): int {.cdecl.}
    # *- Checks for the timer event (does not wait) | returns true/false
    TimerEvent*: proc(self: ptr NAUTILUS_WINDOW): int {.cdecl.}
    # *- Waits for a timer event | returns true/false
    TimerWait*: proc(self: ptr NAUTILUS_WINDOW): int {.cdecl.}
    # *- Check for timer errors | returns true/false
    TimerError*: proc(self: ptr NAUTILUS_WINDOW): int {.cdecl.}
    # *- Process all window events | returns true/false - returns if the application wants to close
    PollEvents*: proc(self: ptr NAUTILUS_WINDOW): int {.cdecl.}
    # *- Can keyboard input be processed? | returns true/false
    KeyState*: proc(self: ptr NAUTILUS_WINDOW): int {.cdecl.}
    # *- Is the key pressed?(#VK_ kecode) | retuens true/false
    KeyDown*: proc(self: ptr NAUTILUS_WINDOW, Code: int): int {.cdecl.}
    # *- Is the key not pressed? (#VK_ kecode) | retuens true/false
    KeyUp*: proc(self: ptr NAUTILUS_WINDOW, Code: int): int {.cdecl.}
    # *- Was the key pressed? (#VK_ kecode) | retuens true/false
    KeyPushed*: proc(self: ptr NAUTILUS_WINDOW, Code: int): int {.cdecl.}
    # *- What was the last pressed chr? - point *Code to a integer to get the chr code | returns the chr code or nothing
    KeyChr*: proc(self: ptr NAUTILUS_WINDOW, Code: pointer): int {.cdecl.}
    # *- Is the mouse inside the client area? | returns true/false
    MouseState*: proc(self: ptr NAUTILUS_WINDOW): int {.cdecl.}
    # *- Returns the mouse position - point *PosX and *PosX to integers to get the position | reurns the mouse state
    MousePosition*: proc(self: ptr NAUTILUS_WINDOW, PosX: pointer, PosY: pointer): int {.cdecl.}
    # *- Was the mousewheel turned? - point *Pos to a integer to get the wheel position | returns the wheel position
    MouseWheel*: proc(self: ptr NAUTILUS_WINDOW, Pos: pointer): int {.cdecl.}
    # *- Is the left mouse button pressed? (ALL MOUSE FUNCTIONS WILL WORK CORRECTLY EVEN IF THE MOUSE BUTTONS ARE SWAPPED!) | returns true/false
    MouseLeftDown*: proc(self: ptr NAUTILUS_WINDOW): int {.cdecl.}
    # *- Is the left mouse button not pressed? | returns true/false
    MouseLeftUp*: proc(self: ptr NAUTILUS_WINDOW): int {.cdecl.}
    # *- Was the left mouse button pressed? | retuens true/false
    MouseLeftPushed*: proc(self: ptr NAUTILUS_WINDOW): int {.cdecl.}
    # *- Was there a left double click? | returns true/false
    MouseLeftDbl*: proc(self: ptr NAUTILUS_WINDOW): int {.cdecl.}
    # *- Is the right mouse button pressed? | returns true/false
    MouseRightDown*: proc(self: ptr NAUTILUS_WINDOW): int {.cdecl.}
    # *- Is the right mouse button not pressed? | returns true/false
    MouseRightUp*: proc(self: ptr NAUTILUS_WINDOW): int {.cdecl.}
    # *- Was the right mouse button pressed? | retuens true/false
    MouseRightPushed*: proc(self: ptr NAUTILUS_WINDOW): int {.cdecl.}
    # *- Was there a right double click? | returns true/false
    MouseRightDbl*: proc(self: ptr NAUTILUS_WINDOW): int {.cdecl.}
    # *- Install a window callback - CallbackProc(*window,hWnd.i,Message.i,wParam.i,lParam.i,*CustomParameter) | returns nothing
    Callback*: proc(self: ptr NAUTILUS_WINDOW, Callback: pointer, Parameter: pointer): int {.cdecl.}
    # *- Issues a close request | returns nothing
    Close*: proc(self: ptr NAUTILUS_WINDOW) {.cdecl.}
    # *- Waits for a exit/close messahe - (this function is needed if *Fps and *Delta of the timer should be processed) | returns true/false
    Exit*: proc(self: ptr NAUTILUS_WINDOW): int {.cdecl.}
    # *- Releases the window | returns nothing
    Release*: proc(self: ptr NAUTILUS_WINDOW) {.cdecl.}
proc hwnd*(self: ptr NAUTILUS_WINDOW): int {.inline discardable.} = self.Hwnd(self)
proc width*(self: ptr NAUTILUS_WINDOW): int {.inline discardable.} = self.Width(self)
proc height*(self: ptr NAUTILUS_WINDOW): int {.inline discardable.} = self.Height(self)
proc icon*(self: ptr NAUTILUS_WINDOW, Icon: pointer): int {.inline discardable.} = self.Icon(self, Icon)
proc screen*(self: ptr NAUTILUS_WINDOW, Code = 0): int {.inline discardable.} = self.Screen(self, Code)
proc screenMode*(self: ptr NAUTILUS_WINDOW): int {.inline discardable.} = self.ScreenMode(self)
proc title*(self: ptr NAUTILUS_WINDOW, Title: WideCString, Append = false.int): int {.inline discardable.} = self.Title(self, Title, Append)
proc cursorHide*(self: ptr NAUTILUS_WINDOW, Flag = true.int): int {.inline discardable.} = self.CursorHide(self, Flag)
proc cursorClip*(self: ptr NAUTILUS_WINDOW, Flag = true.int): int {.inline discardable.} = self.CursorClip(self, Flag)
proc timerCreate*(self: ptr NAUTILUS_WINDOW, Fps = 0, Delta = 0, Milliseconds = 20): int {.inline discardable.} = self.TimerCreate(self, Fps, Delta, Milliseconds)
proc timerEvent*(self: ptr NAUTILUS_WINDOW): int {.inline discardable.} = self.TimerEvent(self)
proc timerWait*(self: ptr NAUTILUS_WINDOW): int {.inline discardable.} = self.TimerWait(self)
proc timerError*(self: ptr NAUTILUS_WINDOW): int {.inline discardable.} = self.TimerError(self)
proc pollEvents*(self: ptr NAUTILUS_WINDOW): int {.inline discardable.} = self.PollEvents(self)
proc keyState*(self: ptr NAUTILUS_WINDOW): int {.inline discardable.} = self.KeyState(self)
proc keyDown*(self: ptr NAUTILUS_WINDOW, Code: int): int {.inline discardable.} = self.KeyDown(self, Code)
proc keyUp*(self: ptr NAUTILUS_WINDOW, Code: int): int {.inline discardable.} = self.KeyUp(self, Code)
proc keyPushed*(self: ptr NAUTILUS_WINDOW, Code: int): int {.inline discardable.} = self.KeyPushed(self, Code)
proc keyChr*(self: ptr NAUTILUS_WINDOW, Code: pointer): int {.inline discardable.} = self.KeyChr(self, Code)
proc mouseState*(self: ptr NAUTILUS_WINDOW): int {.inline discardable.} = self.MouseState(self)
proc mousePosition*(self: ptr NAUTILUS_WINDOW, PosX: pointer, PosY: pointer): int {.inline discardable.} = self.MousePosition(self, PosX, PosY)
proc mouseWheel*(self: ptr NAUTILUS_WINDOW, Pos: pointer): int {.inline discardable.} = self.MouseWheel(self, Pos)
proc mouseLeftDown*(self: ptr NAUTILUS_WINDOW): int {.inline discardable.} = self.MouseLeftDown(self)
proc mouseLeftUp*(self: ptr NAUTILUS_WINDOW): int {.inline discardable.} = self.MouseLeftUp(self)
proc mouseLeftPushed*(self: ptr NAUTILUS_WINDOW): int {.inline discardable.} = self.MouseLeftPushed(self)
proc mouseLeftDbl*(self: ptr NAUTILUS_WINDOW): int {.inline discardable.} = self.MouseLeftDbl(self)
proc mouseRightDown*(self: ptr NAUTILUS_WINDOW): int {.inline discardable.} = self.MouseRightDown(self)
proc mouseRightUp*(self: ptr NAUTILUS_WINDOW): int {.inline discardable.} = self.MouseRightUp(self)
proc mouseRightPushed*(self: ptr NAUTILUS_WINDOW): int {.inline discardable.} = self.MouseRightPushed(self)
proc mouseRightDbl*(self: ptr NAUTILUS_WINDOW): int {.inline discardable.} = self.MouseRightDbl(self)
proc callback*(self: ptr NAUTILUS_WINDOW, Callback: pointer, Parameter: pointer): int {.inline discardable.} = self.Callback(self, Callback, Parameter)
proc close*(self: ptr NAUTILUS_WINDOW) {.inline discardable.} = self.Close(self)
proc exit*(self: ptr NAUTILUS_WINDOW): int {.inline discardable.} = self.Exit(self)
proc release*(self: ptr NAUTILUS_WINDOW) {.inline discardable.} = self.Release(self)
type NAUTILUS_FONT* = ref object
    # *- Get the font spacing (distcance between chrs) - point *Spacing to a float | returns nothing
    Spacing*: proc(self: ptr NAUTILUS_FONT, Spacing: ptr[float32]): int {.cdecl.}
    # *- Set the font spacing (distcance between chrs) | returns nothing
    SpacingChange*: proc(self: ptr NAUTILUS_FONT, Spacing = 0): int {.cdecl.}
    # *- Release the font | returns nothing
    Release*: proc(self: ptr NAUTILUS_FONT) {.cdecl.}
proc spacing*(self: ptr NAUTILUS_FONT, Spacing: ptr[float32]): int {.inline discardable.} = self.Spacing(self, Spacing)
proc spacingChange*(self: ptr NAUTILUS_FONT, Spacing = 0): int {.inline discardable.} = self.SpacingChange(self, Spacing)
proc release*(self: ptr NAUTILUS_FONT) {.inline discardable.} = self.Release(self)
type NAUTILUS_ANIMATION* = ref object
    # *- Activates the animation (ANIMATIONS ARE PROCESSED WITH A CALL TO NAUTILUS_ENGINE\RenderUpdate()) | returns nothing
    Active*: proc(self: ptr NAUTILUS_ANIMATION) {.cdecl.}
    # *- If this flag is set the animation is only run once  | returns nothing
    Once*: proc(self: ptr NAUTILUS_ANIMATION, Flag = true.int): int {.cdecl.}
    # *- Where should the animation start (frame aka tile index) - if Start is -1 nothing gets changed and the current frame start postition is returned | othwise returns true/false
    FrameStart*: proc(self: ptr NAUTILUS_ANIMATION, Start = -1): int {.cdecl.}
    # *- Where should the animation end (frame aka tile index) - if Stop is -1 nothing gets changed and the current frame stop postition is returned | othwise returns true/false
    FrameStop*: proc(self: ptr NAUTILUS_ANIMATION, Stop = -1): int {.cdecl.}
    # *- Set the current postition of the animation (frame aka tile index) - if Pos is -1 nothing gets changed and the current frame postition is returned | othwise returns true/false
    FramePos*: proc(self: ptr NAUTILUS_ANIMATION, Pos = -1): int {.cdecl.}
    # *- Get the current position/frame of the animation | returns the frame pos
    Frame*: proc(self: ptr NAUTILUS_ANIMATION): int {.cdecl.}
    # *- How many frames does the animation have? | returns frame count
    FrameCount*: proc(self: ptr NAUTILUS_ANIMATION): int {.cdecl.}
    # *- Reports the current frame position - point *Output to an integer (set this once and it will auto update) | returns nothing
    FrameOutput*: proc(self: ptr NAUTILUS_ANIMATION, Output: pointer): int {.cdecl.}
    # *- Release the animation | returns nothing
    Release*: proc(self: ptr NAUTILUS_ANIMATION) {.cdecl.}
proc active*(self: ptr NAUTILUS_ANIMATION) {.inline discardable.} = self.Active(self)
proc once*(self: ptr NAUTILUS_ANIMATION, Flag = true.int): int {.inline discardable.} = self.Once(self, Flag)
proc frameStart*(self: ptr NAUTILUS_ANIMATION, Start = -1): int {.inline discardable.} = self.FrameStart(self, Start)
proc frameStop*(self: ptr NAUTILUS_ANIMATION, Stop = -1): int {.inline discardable.} = self.FrameStop(self, Stop)
proc framePos*(self: ptr NAUTILUS_ANIMATION, Pos = -1): int {.inline discardable.} = self.FramePos(self, Pos)
proc frame*(self: ptr NAUTILUS_ANIMATION): int {.inline discardable.} = self.Frame(self)
proc frameCount*(self: ptr NAUTILUS_ANIMATION): int {.inline discardable.} = self.FrameCount(self)
proc frameOutput*(self: ptr NAUTILUS_ANIMATION, Output: pointer): int {.inline discardable.} = self.FrameOutput(self, Output)
proc release*(self: ptr NAUTILUS_ANIMATION) {.inline discardable.} = self.Release(self)
type NAUTILUS_TILE* = ref object
    # *- How many tiles? | returns tile count
    Count*: proc(self: ptr NAUTILUS_TILE): int {.cdecl.}
    # *- Get tile size - point *Width and *Height to floats | returns nothing
    SizeGet*: proc(self: ptr NAUTILUS_TILE, Width: pointer, Height: pointer): int {.cdecl.}
    # *- Set size (resize the tile - this affects all functions below!) (THERE CAN BE ARTEFACTS INTRIDUCED THROUGH ANY SIZE FUNCTION - USE WITH CARE) | returns nothing
    SizeSet*: proc(self: ptr NAUTILUS_TILE, Width: float32, Height: float32): int {.cdecl.}
    # *- Resets the original size | returns nothing
    SizeReset*: proc(self: ptr NAUTILUS_TILE) {.cdecl.}
    Draw*: proc(self: ptr NAUTILUS_TILE, Index: int, Animation: pointer, X: float32, Y: float32, Center = false.int, Alpha = 0xff, Tint = 0xffffff, Angle = 0): int {.cdecl.}
    DrawMod*: proc(self: ptr NAUTILUS_TILE, Index: int, Animation: pointer, X: float32, Y: float32, Width = 0, Height = 0, Center = false.int, Alpha = 0xff, Tint = 0xffffff, Angle = 0): int {.cdecl.}
    DrawMap*: proc(self: ptr NAUTILUS_TILE, Index: int, Animation: pointer, X1: float32, Y1: float32, X2: float32, Y2: float32, X3: float32, Y3: float32, X4: float32, Y4: float32, Alpha = 0xff, Tint = 0xffffff): int {.cdecl.}
    Blend*: proc(self: ptr NAUTILUS_TILE, Index: int, Animation: pointer, X: float32, Y: float32, Center = false.int, Tint = 0xffffff, Angle = 0): int {.cdecl.}
    BlendMod*: proc(self: ptr NAUTILUS_TILE, Index: int, Animation: pointer, X: float32, Y: float32, Width = 0, Height = 0, Center = false.int, Tint = 0xffffff, Angle = 0): int {.cdecl.}
    BlendMap*: proc(self: ptr NAUTILUS_TILE, Index: int, Animation: pointer, X1: float32, Y1: float32, X2: float32, Y2: float32, X3: float32, Y3: float32, X4: float32, Y4: float32, Tint = 0xffffff): int {.cdecl.}
    DrawText*: proc(self: ptr NAUTILUS_TILE, Font: pointer, X: float32, Y: float32, Text: WideCString, CenterX = false.int, CenterY = false.int, Alpha = 0xff, Tint = 0xffffff, Angle = 0): int {.cdecl.}
    DrawTextMod*: proc(self: ptr NAUTILUS_TILE, Font: pointer, X: float32, Y: float32, Text: WideCString, Width = 0, Height = 0, CenterX = false.int, CenterY = false.int, Alpha = 0xff, Tint = 0xffffff, Angle = 0): int {.cdecl.}
    BlendText*: proc(self: ptr NAUTILUS_TILE, Font: pointer, X: float32, Y: float32, Text: WideCString, CenterX = false.int, CenterY = false.int, Tint = 0xffffff, Angle = 0): int {.cdecl.}
    BlendTextMod*: proc(self: ptr NAUTILUS_TILE, Font: pointer, X: float32, Y: float32, Text: WideCString, Width = 0, Height = 0, CenterX = false.int, CenterY = false.int, Tint = 0xffffff, Angle = 0): int {.cdecl.}
    LayerDraw*: proc(self: ptr NAUTILUS_TILE, Layer: int, Index: int, Animation: pointer, X: float32, Y: float32, Center = false.int, Alpha = 0xff, Tint = 0xffffff, Angle = 0): int {.cdecl.}
    # *- LAYER FUNCTIONS WILL DISPATCH THE RENDER COMMANDS TO A LAYER (there are 10 layers 0 - 9 which can be used in succession) - (LAYERS ARE PROCESSED WITH A CALL TO NAUTILUS_ENGINE\RenderLayer()) 
    LayerDrawMod*: proc(self: ptr NAUTILUS_TILE): int {.cdecl.}
    LayerDrawMap*: proc(self: ptr NAUTILUS_TILE, Layer: int, Index: int, Animation: pointer, X1: float32, Y1: float32, X2: float32, Y2: float32, X3: float32, Y3: float32, X4: float32, Y4: float32, Alpha = 0xff, Tint = 0xffffff): int {.cdecl.}
    LayerBlend*: proc(self: ptr NAUTILUS_TILE, Layer: int, Index: int, Animation: pointer, X: float32, Y: float32, Center = false.int, Tint = 0xffffff, Angle = 0): int {.cdecl.}
    LayerBlendMod*: proc(self: ptr NAUTILUS_TILE, Layer: int, Index: int, Animation: pointer, X: float32, Y: float32, Width = 0, Height = 0, Center = false.int, Tint = 0xffffff, Angle = 0): int {.cdecl.}
    LayerBlendMap*: proc(self: ptr NAUTILUS_TILE, Layer: int, Index: int, Animation: pointer, X1: float32, Y1: float32, X2: float32, Y2: float32, X3: float32, Y3: float32, X4: float32, Y4: float32, Tint = 0xffffff): int {.cdecl.}
    LayerDrawText*: proc(self: ptr NAUTILUS_TILE, Layer: int, Font: pointer, X: float32, Y: float32, Text: WideCString, CenterX = false.int, CenterY = false.int, Alpha = 0xff, Tint = 0xffffff, Angle = 0): int {.cdecl.}
    LayerDrawTextMod*: proc(self: ptr NAUTILUS_TILE, Layer: int, Font: pointer, X: float32, Y: float32, Text: WideCString, Width = 0, Height = 0, CenterX = false.int, CenterY = false.int, Alpha = 0xff, Tint = 0xffffff, Angle = 0): int {.cdecl.}
    LayerBlendText*: proc(self: ptr NAUTILUS_TILE, Layer: int, Font: pointer, X: float32, Y: float32, Text: WideCString, CenterX = false.int, CenterY = false.int, Tint = 0xffffff, Angle = 0): int {.cdecl.}
    LayerBlendTextMod*: proc(self: ptr NAUTILUS_TILE, Layer: int, Font: pointer, X: float32, Y: float32, Text: WideCString, Width = 0, Height = 0, CenterX = false.int, CenterY = false.int, Tint = 0xffffff, Angle = 0): int {.cdecl.}
    Release*: proc(self: ptr NAUTILUS_TILE): int {.cdecl.}
proc count*(self: ptr NAUTILUS_TILE): int {.inline discardable.} = self.Count(self)
proc sizeGet*(self: ptr NAUTILUS_TILE, Width: pointer, Height: pointer): int {.inline discardable.} = self.SizeGet(self, Width, Height)
proc sizeSet*(self: ptr NAUTILUS_TILE, Width: float32, Height: float32): int {.inline discardable.} = self.SizeSet(self, Width, Height)
proc sizeReset*(self: ptr NAUTILUS_TILE) {.inline discardable.} = self.SizeReset(self)
proc draw*(self: ptr NAUTILUS_TILE, Index: int, Animation: pointer, X: float32, Y: float32, Center = false.int, Alpha = 0xff, Tint = 0xffffff, Angle = 0): int {.inline discardable.} = self.Draw(self, Index, Animation, X, Y, Center, Alpha, Tint, Angle)
proc drawMod*(self: ptr NAUTILUS_TILE, Index: int, Animation: pointer, X: float32, Y: float32, Width = 0, Height = 0, Center = false.int, Alpha = 0xff, Tint = 0xffffff, Angle = 0): int {.inline discardable.} = self.DrawMod(self, Index, Animation, X, Y, Width, Height, Center, Alpha, Tint, Angle)
proc drawMap*(self: ptr NAUTILUS_TILE, Index: int, Animation: pointer, X1: float32, Y1: float32, X2: float32, Y2: float32, X3: float32, Y3: float32, X4: float32, Y4: float32, Alpha = 0xff, Tint = 0xffffff): int {.inline discardable.} = self.DrawMap(self, Index, Animation, X1, Y1, X2, Y2, X3, Y3, X4, Y4, Alpha, Tint)
proc blend*(self: ptr NAUTILUS_TILE, Index: int, Animation: pointer, X: float32, Y: float32, Center = false.int, Tint = 0xffffff, Angle = 0): int {.inline discardable.} = self.Blend(self, Index, Animation, X, Y, Center, Tint, Angle)
proc blendMod*(self: ptr NAUTILUS_TILE, Index: int, Animation: pointer, X: float32, Y: float32, Width = 0, Height = 0, Center = false.int, Tint = 0xffffff, Angle = 0): int {.inline discardable.} = self.BlendMod(self, Index, Animation, X, Y, Width, Height, Center, Tint, Angle)
proc blendMap*(self: ptr NAUTILUS_TILE, Index: int, Animation: pointer, X1: float32, Y1: float32, X2: float32, Y2: float32, X3: float32, Y3: float32, X4: float32, Y4: float32, Tint = 0xffffff): int {.inline discardable.} = self.BlendMap(self, Index, Animation, X1, Y1, X2, Y2, X3, Y3, X4, Y4, Tint)
proc drawText*(self: ptr NAUTILUS_TILE, Font: pointer, X: float32, Y: float32, Text: WideCString, CenterX = false.int, CenterY = false.int, Alpha = 0xff, Tint = 0xffffff, Angle = 0): int {.inline discardable.} = self.DrawText(self, Font, X, Y, Text, CenterX, CenterY, Alpha, Tint, Angle)
proc drawTextMod*(self: ptr NAUTILUS_TILE, Font: pointer, X: float32, Y: float32, Text: WideCString, Width = 0, Height = 0, CenterX = false.int, CenterY = false.int, Alpha = 0xff, Tint = 0xffffff, Angle = 0): int {.inline discardable.} = self.DrawTextMod(self, Font, X, Y, Text, Width, Height, CenterX, CenterY, Alpha, Tint, Angle)
proc blendText*(self: ptr NAUTILUS_TILE, Font: pointer, X: float32, Y: float32, Text: WideCString, CenterX = false.int, CenterY = false.int, Tint = 0xffffff, Angle = 0): int {.inline discardable.} = self.BlendText(self, Font, X, Y, Text, CenterX, CenterY, Tint, Angle)
proc blendTextMod*(self: ptr NAUTILUS_TILE, Font: pointer, X: float32, Y: float32, Text: WideCString, Width = 0, Height = 0, CenterX = false.int, CenterY = false.int, Tint = 0xffffff, Angle = 0): int {.inline discardable.} = self.BlendTextMod(self, Font, X, Y, Text, Width, Height, CenterX, CenterY, Tint, Angle)
proc layerDraw*(self: ptr NAUTILUS_TILE, Layer: int, Index: int, Animation: pointer, X: float32, Y: float32, Center = false.int, Alpha = 0xff, Tint = 0xffffff, Angle = 0): int {.inline discardable.} = self.LayerDraw(self, Layer, Index, Animation, X, Y, Center, Alpha, Tint, Angle)
proc layerDrawMod*(self: ptr NAUTILUS_TILE): int {.inline discardable.} = self.LayerDrawMod(self)
proc layerDrawMap*(self: ptr NAUTILUS_TILE, Layer: int, Index: int, Animation: pointer, X1: float32, Y1: float32, X2: float32, Y2: float32, X3: float32, Y3: float32, X4: float32, Y4: float32, Alpha = 0xff, Tint = 0xffffff): int {.inline discardable.} = self.LayerDrawMap(self, Layer, Index, Animation, X1, Y1, X2, Y2, X3, Y3, X4, Y4, Alpha, Tint)
proc layerBlend*(self: ptr NAUTILUS_TILE, Layer: int, Index: int, Animation: pointer, X: float32, Y: float32, Center = false.int, Tint = 0xffffff, Angle = 0): int {.inline discardable.} = self.LayerBlend(self, Layer, Index, Animation, X, Y, Center, Tint, Angle)
proc layerBlendMod*(self: ptr NAUTILUS_TILE, Layer: int, Index: int, Animation: pointer, X: float32, Y: float32, Width = 0, Height = 0, Center = false.int, Tint = 0xffffff, Angle = 0): int {.inline discardable.} = self.LayerBlendMod(self, Layer, Index, Animation, X, Y, Width, Height, Center, Tint, Angle)
proc layerBlendMap*(self: ptr NAUTILUS_TILE, Layer: int, Index: int, Animation: pointer, X1: float32, Y1: float32, X2: float32, Y2: float32, X3: float32, Y3: float32, X4: float32, Y4: float32, Tint = 0xffffff): int {.inline discardable.} = self.LayerBlendMap(self, Layer, Index, Animation, X1, Y1, X2, Y2, X3, Y3, X4, Y4, Tint)
proc layerDrawText*(self: ptr NAUTILUS_TILE, Layer: int, Font: pointer, X: float32, Y: float32, Text: WideCString, CenterX = false.int, CenterY = false.int, Alpha = 0xff, Tint = 0xffffff, Angle = 0): int {.inline discardable.} = self.LayerDrawText(self, Layer, Font, X, Y, Text, CenterX, CenterY, Alpha, Tint, Angle)
proc layerDrawTextMod*(self: ptr NAUTILUS_TILE, Layer: int, Font: pointer, X: float32, Y: float32, Text: WideCString, Width = 0, Height = 0, CenterX = false.int, CenterY = false.int, Alpha = 0xff, Tint = 0xffffff, Angle = 0): int {.inline discardable.} = self.LayerDrawTextMod(self, Layer, Font, X, Y, Text, Width, Height, CenterX, CenterY, Alpha, Tint, Angle)
proc layerBlendText*(self: ptr NAUTILUS_TILE, Layer: int, Font: pointer, X: float32, Y: float32, Text: WideCString, CenterX = false.int, CenterY = false.int, Tint = 0xffffff, Angle = 0): int {.inline discardable.} = self.LayerBlendText(self, Layer, Font, X, Y, Text, CenterX, CenterY, Tint, Angle)
proc layerBlendTextMod*(self: ptr NAUTILUS_TILE, Layer: int, Font: pointer, X: float32, Y: float32, Text: WideCString, Width = 0, Height = 0, CenterX = false.int, CenterY = false.int, Tint = 0xffffff, Angle = 0): int {.inline discardable.} = self.LayerBlendTextMod(self, Layer, Font, X, Y, Text, Width, Height, CenterX, CenterY, Tint, Angle)
proc release*(self: ptr NAUTILUS_TILE): int {.inline discardable.} = self.Release(self)
type NAUTILUS_TEXTURE* = ref object
    # *- Get tile size - point *Width and *Height to floats | returns nothing
    SizeGet*: proc(self: ptr NAUTILUS_TEXTURE, Width: pointer, Height: pointer): int {.cdecl.}
    # *- Get tile size - point *Width and *Height to floats | returns nothing
    SizeSet*: proc(self: ptr NAUTILUS_TEXTURE, Width: float32, Height: float32): int {.cdecl.}
    SizeReset*: proc(self: ptr NAUTILUS_TEXTURE): int {.cdecl.}
    Draw*: proc(self: ptr NAUTILUS_TEXTURE, X: float32, Y: float32, Center = false.int, Alpha = 0xff, Tint = 0xffffff, Angle = 0): int {.cdecl.}
    DrawMod*: proc(self: ptr NAUTILUS_TEXTURE, X: float32, Y: float32, Width = 0, Height = 0, Center = false.int, Alpha = 0xff, Tint = 0xffffff, Angle = 0): int {.cdecl.}
    DrawMap*: proc(self: ptr NAUTILUS_TEXTURE, X1: float32, Y1: float32, X2: float32, Y2: float32, X3: float32, Y3: float32, X4: float32, Y4: float32, Alpha = 0xff, Tint = 0xffffff): int {.cdecl.}
    Blend*: proc(self: ptr NAUTILUS_TEXTURE, X: float32, Y: float32, Center = false.int, Tint = 0xffffff, Angle = 0): int {.cdecl.}
    BlendMod*: proc(self: ptr NAUTILUS_TEXTURE, X: float32, Y: float32, Width = 0, Height = 0, Center = false.int, Tint = 0xffffff, Angle = 0): int {.cdecl.}
    BlendMap*: proc(self: ptr NAUTILUS_TEXTURE, X1: float32, Y1: float32, X2: float32, Y2: float32, X3: float32, Y3: float32, X4: float32, Y4: float32, Tint = 0xffffff): int {.cdecl.}
    LayerDraw*: proc(self: ptr NAUTILUS_TEXTURE, Layer: int, X: float32, Y: float32, Center = false.int, Alpha = 0xff, Tint = 0xffffff, Angle = 0): int {.cdecl.}
    LayerDrawMod*: proc(self: ptr NAUTILUS_TEXTURE, Layer: int, X: float32, Y: float32, Width = 0, Height = 0, Center = false.int, Alpha = 0xff, Tint = 0xffffff, Angle = 0): int {.cdecl.}
    LayerDrawMap*: proc(self: ptr NAUTILUS_TEXTURE, Layer: int, X1: float32, Y1: float32, X2: float32, Y2: float32, X3: float32, Y3: float32, X4: float32, Y4: float32, Alpha = 0xff, Tint = 0xffffff): int {.cdecl.}
    LayerBlend*: proc(self: ptr NAUTILUS_TEXTURE, Layer: int, X: float32, Y: float32, Center = false.int, Tint = 0xffffff, Angle = 0): int {.cdecl.}
    LayerBlendMod*: proc(self: ptr NAUTILUS_TEXTURE, Layer: int, X: float32, Y: float32, Width = 0, Height = 0, Center = false.int, Tint = 0xffffff, Angle = 0): int {.cdecl.}
    LayerBlendMap*: proc(self: ptr NAUTILUS_TEXTURE, Layer: int, X1: float32, Y1: float32, X2: float32, Y2: float32, X3: float32, Y3: float32, X4: float32, Y4: float32, Tint = 0xffffff): int {.cdecl.}
    # *- Creates a tile | returns a tile or false
    CreateTile*: proc(self: ptr NAUTILUS_TEXTURE, CountX: int, CountY: int, X: int, Y: int, Width: int, Height: int, OffsetX = 0, OffsetY = 0): int {.cdecl.}
    Release*: proc(self: ptr NAUTILUS_TEXTURE): int {.cdecl.}
proc sizeGet*(self: ptr NAUTILUS_TEXTURE, Width: pointer, Height: pointer): int {.inline discardable.} = self.SizeGet(self, Width, Height)
proc sizeSet*(self: ptr NAUTILUS_TEXTURE, Width: float32, Height: float32): int {.inline discardable.} = self.SizeSet(self, Width, Height)
proc sizeReset*(self: ptr NAUTILUS_TEXTURE): int {.inline discardable.} = self.SizeReset(self)
proc draw*(self: ptr NAUTILUS_TEXTURE, X: float32, Y: float32, Center = false.int, Alpha = 0xff, Tint = 0xffffff, Angle = 0): int {.inline discardable.} = self.Draw(self, X, Y, Center, Alpha, Tint, Angle)
proc drawMod*(self: ptr NAUTILUS_TEXTURE, X: float32, Y: float32, Width = 0, Height = 0, Center = false.int, Alpha = 0xff, Tint = 0xffffff, Angle = 0): int {.inline discardable.} = self.DrawMod(self, X, Y, Width, Height, Center, Alpha, Tint, Angle)
proc drawMap*(self: ptr NAUTILUS_TEXTURE, X1: float32, Y1: float32, X2: float32, Y2: float32, X3: float32, Y3: float32, X4: float32, Y4: float32, Alpha = 0xff, Tint = 0xffffff): int {.inline discardable.} = self.DrawMap(self, X1, Y1, X2, Y2, X3, Y3, X4, Y4, Alpha, Tint)
proc blend*(self: ptr NAUTILUS_TEXTURE, X: float32, Y: float32, Center = false.int, Tint = 0xffffff, Angle = 0): int {.inline discardable.} = self.Blend(self, X, Y, Center, Tint, Angle)
proc blendMod*(self: ptr NAUTILUS_TEXTURE, X: float32, Y: float32, Width = 0, Height = 0, Center = false.int, Tint = 0xffffff, Angle = 0): int {.inline discardable.} = self.BlendMod(self, X, Y, Width, Height, Center, Tint, Angle)
proc blendMap*(self: ptr NAUTILUS_TEXTURE, X1: float32, Y1: float32, X2: float32, Y2: float32, X3: float32, Y3: float32, X4: float32, Y4: float32, Tint = 0xffffff): int {.inline discardable.} = self.BlendMap(self, X1, Y1, X2, Y2, X3, Y3, X4, Y4, Tint)
proc layerDraw*(self: ptr NAUTILUS_TEXTURE, Layer: int, X: float32, Y: float32, Center = false.int, Alpha = 0xff, Tint = 0xffffff, Angle = 0): int {.inline discardable.} = self.LayerDraw(self, Layer, X, Y, Center, Alpha, Tint, Angle)
proc layerDrawMod*(self: ptr NAUTILUS_TEXTURE, Layer: int, X: float32, Y: float32, Width = 0, Height = 0, Center = false.int, Alpha = 0xff, Tint = 0xffffff, Angle = 0): int {.inline discardable.} = self.LayerDrawMod(self, Layer, X, Y, Width, Height, Center, Alpha, Tint, Angle)
proc layerDrawMap*(self: ptr NAUTILUS_TEXTURE, Layer: int, X1: float32, Y1: float32, X2: float32, Y2: float32, X3: float32, Y3: float32, X4: float32, Y4: float32, Alpha = 0xff, Tint = 0xffffff): int {.inline discardable.} = self.LayerDrawMap(self, Layer, X1, Y1, X2, Y2, X3, Y3, X4, Y4, Alpha, Tint)
proc layerBlend*(self: ptr NAUTILUS_TEXTURE, Layer: int, X: float32, Y: float32, Center = false.int, Tint = 0xffffff, Angle = 0): int {.inline discardable.} = self.LayerBlend(self, Layer, X, Y, Center, Tint, Angle)
proc layerBlendMod*(self: ptr NAUTILUS_TEXTURE, Layer: int, X: float32, Y: float32, Width = 0, Height = 0, Center = false.int, Tint = 0xffffff, Angle = 0): int {.inline discardable.} = self.LayerBlendMod(self, Layer, X, Y, Width, Height, Center, Tint, Angle)
proc layerBlendMap*(self: ptr NAUTILUS_TEXTURE, Layer: int, X1: float32, Y1: float32, X2: float32, Y2: float32, X3: float32, Y3: float32, X4: float32, Y4: float32, Tint = 0xffffff): int {.inline discardable.} = self.LayerBlendMap(self, Layer, X1, Y1, X2, Y2, X3, Y3, X4, Y4, Tint)
proc createTile*(self: ptr NAUTILUS_TEXTURE, CountX: int, CountY: int, X: int, Y: int, Width: int, Height: int, OffsetX = 0, OffsetY = 0): int {.inline discardable.} = self.CreateTile(self, CountX, CountY, X, Y, Width, Height, OffsetX, OffsetY)
proc release*(self: ptr NAUTILUS_TEXTURE): int {.inline discardable.} = self.Release(self)
type NAUTILUS_ENGINE* = ref object
    # *- Is vsync enabled? | returns true/false
    RenderVSync*: proc(self: ptr NAUTILUS_ENGINE): int {.cdecl.}
    # *- Enable/disable vsync if possible | returns true/false
    RenderVSyncMode*: proc(self: ptr NAUTILUS_ENGINE, Flag = false.int): int {.cdecl.}
    # *- If the flag is set the render will keep the aspect ratio (this affects RenderViewport() which should be called on a resize event) | returns nothing
    RenderAspect*: proc(self: ptr NAUTILUS_ENGINE) {.cdecl.}
    # *- Get the render size (render surface) - point *Width and *Height to integers | returns nothing           
    RenderSize*: proc(self: ptr NAUTILUS_ENGINE, Width: pointer, Height: pointer): int {.cdecl.}
    # *- You can change the render size (render surface) | returns true/false (calls RenderViewport() internally so no seperate call to it is needed)
    RenderResize*: proc(self: ptr NAUTILUS_ENGINE): int {.cdecl.}
    # *- Adjusts the viewport accordingly if the host window is resized | returns true/false
    RenderViewport*: proc(self: ptr NAUTILUS_ENGINE): int {.cdecl.}
    # *- This will enable/disable bilinear filtering for all textures loaded after this call | returns nothing (use with care as there can be artefacts)
    RenderFilter*: proc(self: ptr NAUTILUS_ENGINE, Flag = true.int): int {.cdecl.}
    # *- Set the render color (ALL COLORS REPRESENTED/HANDLED AS RGB/ARGB!) | returns nothing
    RenderColor*: proc(self: ptr NAUTILUS_ENGINE, Color = 0): int {.cdecl.}
    # *- This will clip/scissor a area - nothing will be rendered outside this area | returns nothing
    RenderClip*: proc(self: ptr NAUTILUS_ENGINE, X: float32, Y: float32, Width: float32, Height: float32): int {.cdecl.}
    # *- This will unclip a previously clipped area | returns nothing
    RenderUnclip*: proc(self: ptr NAUTILUS_ENGINE) {.cdecl.}
    # *- Push the render matrix onto the stack | returns nothing
    RenderPush*: proc(self: ptr NAUTILUS_ENGINE) {.cdecl.}
    # *- Pops the render matrix from the stack | returns nothing
    RenderPop*: proc(self: ptr NAUTILUS_ENGINE) {.cdecl.}
    # *- Rotates the render surface (matix function) | returns nothing
    RenderRotate*: proc(self: ptr NAUTILUS_ENGINE, Angle: float32): int {.cdecl.}
    # *- Scales the render surface (matix function) | returns nothing
    RenderScale*: proc(self: ptr NAUTILUS_ENGINE, X: float32, Y: float32): int {.cdecl.}
    # *- Translates the render surface (matix function) | returns nothing
    RenderTranslate*: proc(self: ptr NAUTILUS_ENGINE, X: float32, Y: float32): int {.cdecl.}
    # *- Resets all matrix operations | returns nothing
    RenderReset*: proc(self: ptr NAUTILUS_ENGINE) {.cdecl.}
    # *- Enables texture mode (the engine expects this to be on by default!) - to ease the use of custom opengl code | returns nothing
    RenderTextureMode*: proc(self: ptr NAUTILUS_ENGINE) {.cdecl.}
    # *- Disable texture mode - to ease the use of custom opengl code | returns nothing
    RenderPrimitiveMode*: proc(self: ptr NAUTILUS_ENGINE) {.cdecl.}
    # *- Begins rendering - render only after this call | returns nothing
    RenderBegin*: proc(self: ptr NAUTILUS_ENGINE) {.cdecl.}
    # *- Ends rendering | returns nothing
    RenderEnd*: proc(self: ptr NAUTILUS_ENGINE) {.cdecl.}
    # *- Renders all layers (can be used in sucession) | returns nothing
    RenderLayer*: proc(self: ptr NAUTILUS_ENGINE) {.cdecl.}
    # *- This funtion processes all animations (call once every frame) | returns nothing
    RenderUpdate*: proc(self: ptr NAUTILUS_ENGINE) {.cdecl.}
    # *- Returns the mouse position (takes in window mouse coordinates that will be mapped to surface coordinates) - point | returns nothing
    RenderMouse*: proc(self: ptr NAUTILUS_ENGINE, X: int, Y: int, OutX: pointer, OutY: pointer): int {.cdecl.}
    # *- Get default font interfaces - point *Texture *Tile and *Font to interfaces | returns nothing
    DrawTextObject*: proc(self: ptr NAUTILUS_ENGINE, Texture = 0, Tile = 0, Font = 0): int {.cdecl.}
    DrawTextSize*: proc(self: ptr NAUTILUS_ENGINE, Width: pointer, Height: pointer): int {.cdecl.}
    DrawTextResize*: proc(self: ptr NAUTILUS_ENGINE, Width: float32, Height: float32): float32 {.cdecl.}
    DrawTextResetSize*: proc(self: ptr NAUTILUS_ENGINE): int {.cdecl.}
    DrawTextSpacingGet*: proc(self: ptr NAUTILUS_ENGINE, Spacing: pointer): int {.cdecl.}
    DrawTextSpacingSet*: proc(self: ptr NAUTILUS_ENGINE, Spacing: float32): int {.cdecl.}
    DrawText*: proc(self: ptr NAUTILUS_ENGINE, X: float32, Y: float32, Text: WideCString, CenterX = false.int, CenterY = false.int, Alpha = 0xff, Tint = 0xffffff, Angle = 0): int {.cdecl.}
    DrawTextMod*: proc(self: ptr NAUTILUS_ENGINE, X: float32, Y: float32, Text: WideCString, Width: float32, Height: float32, CenterX = false.int, CenterY = false.int, Alpha = 0xff, Tint = 0xffffff, Angle = 0): int {.cdecl.}
    DrawPointSize*: proc(self: ptr NAUTILUS_ENGINE, Size = 1): int {.cdecl.}
    DrawLineSize*: proc(self: ptr NAUTILUS_ENGINE, Size = 1): int {.cdecl.}
    DrawPoint*: proc(self: ptr NAUTILUS_ENGINE, X: float32, Y: float32, Color = 0xffffffff): int {.cdecl.}
    DrawLine*: proc(self: ptr NAUTILUS_ENGINE, X1: float32, Y1: float32, X2: float32, Y2: float32, Color = 0xffffffff): int {.cdecl.}
    DrawTriangle*: proc(self: ptr NAUTILUS_ENGINE, X: float32, Y: float32, Width: float32, Height: float32, Fill = false.int, Color = 0xffffffff): int {.cdecl.}
    DrawBox*: proc(self: ptr NAUTILUS_ENGINE, X: float32, Y: float32, Width: float32, Height: float32, Center = false.int, Fill = false.int, Color = 0xffffffff): int {.cdecl.}
    DrawRhombus*: proc(self: ptr NAUTILUS_ENGINE, X: float32, Y: float32, Width: float32, Height: float32, Center = false.int, Fill = false.int, Color = 0xffffffff): int {.cdecl.}
    DrawCircle*: proc(self: ptr NAUTILUS_ENGINE, X: float32, Y: float32, Radius: float32, Skip = 0, Fill = false.int, Color = 0xffffffff): int {.cdecl.}
    LayerDrawPointSize*: proc(self: ptr NAUTILUS_ENGINE, Layer: int, Size = 1): int {.cdecl.}
    LayerDrawLineSize*: proc(self: ptr NAUTILUS_ENGINE, Layer: int, Size = 1): int {.cdecl.}
    LayerDrawPoint*: proc(self: ptr NAUTILUS_ENGINE, Layer: int, X: float32, Y: float32, Color = 0xffffffff): int {.cdecl.}
    LayerDrawLine*: proc(self: ptr NAUTILUS_ENGINE, Layer: int, X1: float32, Y1: float32, X2: float32, Y2: float32, Color = 0xffffffff): int {.cdecl.}
    LayerDrawTriangle*: proc(self: ptr NAUTILUS_ENGINE, Layer: int, X: float32, Y: float32, Width: float32, Height: float32, Fill = false.int, Color = 0xffffffff): int {.cdecl.}
    LayerDrawBox*: proc(self: ptr NAUTILUS_ENGINE, Layer: int, X: float32, Y: float32, Width: float32, Height: float32, Center = false.int, Fill = false.int, Color = 0xffffffff): int {.cdecl.}
    LayerDrawRhombus*: proc(self: ptr NAUTILUS_ENGINE, Layer: int, X: float32, Y: float32, Width: float32, Height: float32, Center = false.int, Fill = false.int, Color = 0xffffffff): int {.cdecl.}
    LayerDrawCircle*: proc(self: ptr NAUTILUS_ENGINE, Layer: int, X: float32, Y: float32, Radius: float32, Skip = 0, Fill = false.int, Color = 0xffffffff): int {.cdecl.}
    LayerClip*: proc(self: ptr NAUTILUS_ENGINE, Layer: int, X: float32, Y: float32, Width: float32, Height: float32): int {.cdecl.}
    LayerUnclip*: proc(self: ptr NAUTILUS_ENGINE, Layer: int): int {.cdecl.}
    LayerPush*: proc(self: ptr NAUTILUS_ENGINE, Layer: int): int {.cdecl.}
    LayerPop*: proc(self: ptr NAUTILUS_ENGINE, Layer: int): int {.cdecl.}
    LayerRotate*: proc(self: ptr NAUTILUS_ENGINE, Layer: int, Angle: float32): int {.cdecl.}
    LayerScale*: proc(self: ptr NAUTILUS_ENGINE, Layer: int, X: float32, Y: float32): int {.cdecl.}
    LayerTranslate*: proc(self: ptr NAUTILUS_ENGINE, Layer: int, X: float32, Y: float32): int {.cdecl.}
    LayerReset*: proc(self: ptr NAUTILUS_ENGINE, Layer: int): int {.cdecl.}
    # *- register one or mutliple callbacks in a layer - (all callbacks are reset once the layer is rendered)
    LayerCallback*: proc(self: ptr NAUTILUS_ENGINE, Layer: int, Function: pointer, Paramater: pointer): int {.cdecl.}
    CreateTexture*: proc(self: ptr NAUTILUS_ENGINE, Buffer: pointer, File = ""): int {.cdecl.}
    CreateAnimation*: proc(self: ptr NAUTILUS_ENGINE, Start: int, Stop: int, Cycle: int, Active = true.int, Once = false.int): int {.cdecl.}
    CreateFont*: proc(self: ptr NAUTILUS_ENGINE, Offset = 0, Layout = "", Spacing = 0): int {.cdecl.}
    Release*: proc(self: ptr NAUTILUS_ENGINE): int {.cdecl.}
proc renderVSync*(self: ptr NAUTILUS_ENGINE): int {.inline discardable.} = self.RenderVSync(self)
proc renderVSyncMode*(self: ptr NAUTILUS_ENGINE, Flag = false.int): int {.inline discardable.} = self.RenderVSyncMode(self, Flag)
proc renderAspect*(self: ptr NAUTILUS_ENGINE) {.inline discardable.} = self.RenderAspect(self)
proc renderSize*(self: ptr NAUTILUS_ENGINE, Width: pointer, Height: pointer): int {.inline discardable.} = self.RenderSize(self, Width, Height)
proc renderResize*(self: ptr NAUTILUS_ENGINE): int {.inline discardable.} = self.RenderResize(self)
proc renderViewport*(self: ptr NAUTILUS_ENGINE): int {.inline discardable.} = self.RenderViewport(self)
proc renderFilter*(self: ptr NAUTILUS_ENGINE, Flag = true.int): int {.inline discardable.} = self.RenderFilter(self, Flag)
proc renderColor*(self: ptr NAUTILUS_ENGINE, Color = 0): int {.inline discardable.} = self.RenderColor(self, Color)
proc renderClip*(self: ptr NAUTILUS_ENGINE, X: float32, Y: float32, Width: float32, Height: float32): int {.inline discardable.} = self.RenderClip(self, X, Y, Width, Height)
proc renderUnclip*(self: ptr NAUTILUS_ENGINE) {.inline discardable.} = self.RenderUnclip(self)
proc renderPush*(self: ptr NAUTILUS_ENGINE) {.inline discardable.} = self.RenderPush(self)
proc renderPop*(self: ptr NAUTILUS_ENGINE) {.inline discardable.} = self.RenderPop(self)
proc renderRotate*(self: ptr NAUTILUS_ENGINE, Angle: float32): int {.inline discardable.} = self.RenderRotate(self, Angle)
proc renderScale*(self: ptr NAUTILUS_ENGINE, X: float32, Y: float32): int {.inline discardable.} = self.RenderScale(self, X, Y)
proc renderTranslate*(self: ptr NAUTILUS_ENGINE, X: float32, Y: float32): int {.inline discardable.} = self.RenderTranslate(self, X, Y)
proc renderReset*(self: ptr NAUTILUS_ENGINE) {.inline discardable.} = self.RenderReset(self)
proc renderTextureMode*(self: ptr NAUTILUS_ENGINE) {.inline discardable.} = self.RenderTextureMode(self)
proc renderPrimitiveMode*(self: ptr NAUTILUS_ENGINE) {.inline discardable.} = self.RenderPrimitiveMode(self)
proc renderBegin*(self: ptr NAUTILUS_ENGINE) {.inline discardable.} = self.RenderBegin(self)
proc renderEnd*(self: ptr NAUTILUS_ENGINE) {.inline discardable.} = self.RenderEnd(self)
proc renderLayer*(self: ptr NAUTILUS_ENGINE) {.inline discardable.} = self.RenderLayer(self)
proc renderUpdate*(self: ptr NAUTILUS_ENGINE) {.inline discardable.} = self.RenderUpdate(self)
proc renderMouse*(self: ptr NAUTILUS_ENGINE, X: int, Y: int, OutX: pointer, OutY: pointer): int {.inline discardable.} = self.RenderMouse(self, X, Y, OutX, OutY)
proc drawTextObject*(self: ptr NAUTILUS_ENGINE, Texture = 0, Tile = 0, Font = 0): int {.inline discardable.} = self.DrawTextObject(self, Texture, Tile, Font)
proc drawTextSize*(self: ptr NAUTILUS_ENGINE, Width: pointer, Height: pointer): int {.inline discardable.} = self.DrawTextSize(self, Width, Height)
proc drawTextResize*(self: ptr NAUTILUS_ENGINE, Width: float32, Height: float32): float32 {.inline discardable.} = self.DrawTextResize(self, Width, Height)
proc drawTextResetSize*(self: ptr NAUTILUS_ENGINE): int {.inline discardable.} = self.DrawTextResetSize(self)
proc drawTextSpacingGet*(self: ptr NAUTILUS_ENGINE, Spacing: pointer): int {.inline discardable.} = self.DrawTextSpacingGet(self, Spacing)
proc drawTextSpacingSet*(self: ptr NAUTILUS_ENGINE, Spacing: float32): int {.inline discardable.} = self.DrawTextSpacingSet(self, Spacing)
proc drawText*(self: ptr NAUTILUS_ENGINE, X: float32, Y: float32, Text: WideCString, CenterX = false.int, CenterY = false.int, Alpha = 0xff, Tint = 0xffffff, Angle = 0): int {.inline discardable.} = self.DrawText(self, X, Y, Text, CenterX, CenterY, Alpha, Tint, Angle)
proc drawTextMod*(self: ptr NAUTILUS_ENGINE, X: float32, Y: float32, Text: WideCString, Width: float32, Height: float32, CenterX = false.int, CenterY = false.int, Alpha = 0xff, Tint = 0xffffff, Angle = 0): int {.inline discardable.} = self.DrawTextMod(self, X, Y, Text, Width, Height, CenterX, CenterY, Alpha, Tint, Angle)
proc drawPointSize*(self: ptr NAUTILUS_ENGINE, Size = 1): int {.inline discardable.} = self.DrawPointSize(self, Size)
proc drawLineSize*(self: ptr NAUTILUS_ENGINE, Size = 1): int {.inline discardable.} = self.DrawLineSize(self, Size)
proc drawPoint*(self: ptr NAUTILUS_ENGINE, X: float32, Y: float32, Color = 0xffffffff): int {.inline discardable.} = self.DrawPoint(self, X, Y, Color)
proc drawLine*(self: ptr NAUTILUS_ENGINE, X1: float32, Y1: float32, X2: float32, Y2: float32, Color = 0xffffffff): int {.inline discardable.} = self.DrawLine(self, X1, Y1, X2, Y2, Color)
proc drawTriangle*(self: ptr NAUTILUS_ENGINE, X: float32, Y: float32, Width: float32, Height: float32, Fill = false.int, Color = 0xffffffff): int {.inline discardable.} = self.DrawTriangle(self, X, Y, Width, Height, Fill, Color)
proc drawBox*(self: ptr NAUTILUS_ENGINE, X: float32, Y: float32, Width: float32, Height: float32, Center = false.int, Fill = false.int, Color = 0xffffffff): int {.inline discardable.} = self.DrawBox(self, X, Y, Width, Height, Center, Fill, Color)
proc drawRhombus*(self: ptr NAUTILUS_ENGINE, X: float32, Y: float32, Width: float32, Height: float32, Center = false.int, Fill = false.int, Color = 0xffffffff): int {.inline discardable.} = self.DrawRhombus(self, X, Y, Width, Height, Center, Fill, Color)
proc drawCircle*(self: ptr NAUTILUS_ENGINE, X: float32, Y: float32, Radius: float32, Skip = 0, Fill = false.int, Color = 0xffffffff): int {.inline discardable.} = self.DrawCircle(self, X, Y, Radius, Skip, Fill, Color)
proc layerDrawPointSize*(self: ptr NAUTILUS_ENGINE, Layer: int, Size = 1): int {.inline discardable.} = self.LayerDrawPointSize(self, Layer, Size)
proc layerDrawLineSize*(self: ptr NAUTILUS_ENGINE, Layer: int, Size = 1): int {.inline discardable.} = self.LayerDrawLineSize(self, Layer, Size)
proc layerDrawPoint*(self: ptr NAUTILUS_ENGINE, Layer: int, X: float32, Y: float32, Color = 0xffffffff): int {.inline discardable.} = self.LayerDrawPoint(self, Layer, X, Y, Color)
proc layerDrawLine*(self: ptr NAUTILUS_ENGINE, Layer: int, X1: float32, Y1: float32, X2: float32, Y2: float32, Color = 0xffffffff): int {.inline discardable.} = self.LayerDrawLine(self, Layer, X1, Y1, X2, Y2, Color)
proc layerDrawTriangle*(self: ptr NAUTILUS_ENGINE, Layer: int, X: float32, Y: float32, Width: float32, Height: float32, Fill = false.int, Color = 0xffffffff): int {.inline discardable.} = self.LayerDrawTriangle(self, Layer, X, Y, Width, Height, Fill, Color)
proc layerDrawBox*(self: ptr NAUTILUS_ENGINE, Layer: int, X: float32, Y: float32, Width: float32, Height: float32, Center = false.int, Fill = false.int, Color = 0xffffffff): int {.inline discardable.} = self.LayerDrawBox(self, Layer, X, Y, Width, Height, Center, Fill, Color)
proc layerDrawRhombus*(self: ptr NAUTILUS_ENGINE, Layer: int, X: float32, Y: float32, Width: float32, Height: float32, Center = false.int, Fill = false.int, Color = 0xffffffff): int {.inline discardable.} = self.LayerDrawRhombus(self, Layer, X, Y, Width, Height, Center, Fill, Color)
proc layerDrawCircle*(self: ptr NAUTILUS_ENGINE, Layer: int, X: float32, Y: float32, Radius: float32, Skip = 0, Fill = false.int, Color = 0xffffffff): int {.inline discardable.} = self.LayerDrawCircle(self, Layer, X, Y, Radius, Skip, Fill, Color)
proc layerClip*(self: ptr NAUTILUS_ENGINE, Layer: int, X: float32, Y: float32, Width: float32, Height: float32): int {.inline discardable.} = self.LayerClip(self, Layer, X, Y, Width, Height)
proc layerUnclip*(self: ptr NAUTILUS_ENGINE, Layer: int): int {.inline discardable.} = self.LayerUnclip(self, Layer)
proc layerPush*(self: ptr NAUTILUS_ENGINE, Layer: int): int {.inline discardable.} = self.LayerPush(self, Layer)
proc layerPop*(self: ptr NAUTILUS_ENGINE, Layer: int): int {.inline discardable.} = self.LayerPop(self, Layer)
proc layerRotate*(self: ptr NAUTILUS_ENGINE, Layer: int, Angle: float32): int {.inline discardable.} = self.LayerRotate(self, Layer, Angle)
proc layerScale*(self: ptr NAUTILUS_ENGINE, Layer: int, X: float32, Y: float32): int {.inline discardable.} = self.LayerScale(self, Layer, X, Y)
proc layerTranslate*(self: ptr NAUTILUS_ENGINE, Layer: int, X: float32, Y: float32): int {.inline discardable.} = self.LayerTranslate(self, Layer, X, Y)
proc layerReset*(self: ptr NAUTILUS_ENGINE, Layer: int): int {.inline discardable.} = self.LayerReset(self, Layer)
proc layerCallback*(self: ptr NAUTILUS_ENGINE, Layer: int, Function: pointer, Paramater: pointer): int {.inline discardable.} = self.LayerCallback(self, Layer, Function, Paramater)
proc createTexture*(self: ptr NAUTILUS_ENGINE, Buffer: pointer, File = ""): int {.inline discardable.} = self.CreateTexture(self, Buffer, File)
proc createAnimation*(self: ptr NAUTILUS_ENGINE, Start: int, Stop: int, Cycle: int, Active = true.int, Once = false.int): int {.inline discardable.} = self.CreateAnimation(self, Start, Stop, Cycle, Active, Once)
proc createFont*(self: ptr NAUTILUS_ENGINE, Offset = 0, Layout = "", Spacing = 0): int {.inline discardable.} = self.CreateFont(self, Offset, Layout, Spacing)
proc release*(self: ptr NAUTILUS_ENGINE): int {.inline discardable.} = self.Release(self)
#  IDE Options = PureBasic 5.70 LTS (Windows - x86)
#  CursorPosition = 47
#  FirstLine = 20
#  EnableXP
converter bool2int*(self: bool): int = self.int
converter str2widestr*(self: string): WideCString = self.newWideCString
proc nautilusWindow*(Width: int, Height: int, Title = "".newWideCString, Type = 0, TopMost = false): ptr NAUTILUS_WINDOW  {.NAUT, importc: "nautilusWindow".}
proc nautilusEngine*(Hwnd: int, Width: int, Height: int): ptr NAUTILUS_ENGINE {.NAUT, importc: "nautilusEngine".}
proc nautilusVersion*(): int {.NAUT, importc: "nautilusVersion".}