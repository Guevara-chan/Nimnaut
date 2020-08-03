# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
# Nautilus engine sample #0: the Well
# Developed in 2*20 by Guevara-chan
# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
import nautilus, lenientops

let window = nautilusWindow(800, 800, "Nimnaut/[the Well]")
if window.hwnd != 0:
    window.timerCreate()
    let engine = nautilusEngine(window.hwnd, window.width, window.height)
    if not engine.isNil:
        var 
            angle = 0.0
            zoom = 1.0
        while not window.exit.bool and not window.timerError.bool:
            window.pollEvents()
            engine.renderBegin()
            engine.renderTranslate(window.width / 2, window.height / 2)            
            engine.renderScale(zoom, zoom)
            zoom = if zoom <= 0.5: 1.0 else: zoom - 0.005
            var scale = 2000
            angle = angle + 1
            while scale > 0:
                for i in 1..3:
                    let shade = 0xffffff or (0xff div i shl 24)
                    let factor = (scale - i * 5).float32
                    engine.renderRotate(angle-i.float32)
                    engine.drawRhombus(0, 0, factor, factor, true, Color = shade)
                    engine.renderRotate(-angle * 2 + i.float32 * 2)
                    engine.drawBox(0, 0, factor, factor, true, Color = shade)
                    engine.renderRotate(angle-i.float32)                
                scale = scale div 2
            engine.renderReset()
            engine.drawTextMod window.width-160.0, window.height-20.0, "by V.A. Guevara", 10, 10, Tint=0x20a5da
            engine.renderEnd()
            window.timerWait()
    engine.release
    window.release