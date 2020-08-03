# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
# Nautilus engine sample #1: Hello, world !
# Converted in 2*20 by Guevara-chan
# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
import nautilus

if nautilusVersion() == NAUTILUS_VERSION:
    let window = nautilusWindow(800, 600)
    if not window.isNil:
        if window.timerCreate.bool: #<- create a window timer to control rendering
            let engine = nautilusEngine(window.hwnd,600,400) #<- initialize the engine
            if not engine.isNil:
                engine.renderColor 0xFF603E14.int
                engine.drawTextResize 32, 32
                while not window.exit.bool:
                    window.pollEvents()
                    engine.renderBegin()
                    engine.drawText 300,160,"NAUTILUS ENGINE",true,true,0xFF
                    engine.drawText 300,240,"Hello World!",true,true,0x80
                    engine.renderEnd()
                    window.timerWait()                     
                engine.release()
            window.release()
