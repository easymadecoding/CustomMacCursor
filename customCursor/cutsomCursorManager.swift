import Cocoa
import QuartzCore

class customCursorManager
{
    static let shared = customCursorManager()
    private var window: NSWindow?
    private var customCursorLayer = CAEmitterLayer()
    
    private init() {}
    
    func startCursorEffect()
    {
        let screenFrame = NSScreen.main!.frame
        window = NSWindow(
            contentRect: screenFrame,
            styleMask: [.borderless],
            backing: .buffered,
            defer: false
        )
        
        window?.isOpaque = false;
        window?.backgroundColor = .clear
        window?.level = .screenSaver
        window?.ignoresMouseEvents = true
        window?.makeKeyAndOrderFront(nil)
        
        setupCursorEffect(in: window!.contentView!)
        
        NSEvent.addGlobalMonitorForEvents(matching: [.mouseMoved]) {
            event in self.updateCustomEffect(position: event.locationInWindow)
        }
    }
    
    
    private func setupCursorEffect(in view: NSView)
    {
        let customEffects = CAEmitterLayer()
        customEffects.emitterSize = CGSize(width: 10, height: 10)
        customEffects.emitterShape = .circle
        
        let effectCell = CAEmitterCell()
        effectCell.contents = NSImage(named: "effectPNG")?.cgImage(forProposedRect: nil, context: nil, hints: nil)
        effectCell.scale = 0.03
        effectCell.birthRate = 5
        effectCell.lifetime = 2.0
        effectCell.velocity = 40
        effectCell.velocityRange = 20
        effectCell.yAcceleration = 30
        
        customEffects.emitterCells = [effectCell]
        customEffects.emitterPosition = CGPoint(x: 0, y: 0)
        
        view.layer = CALayer()
        view.layer?.addSublayer(customEffects)
        view.wantsLayer = true
        
        customCursorLayer = customEffects
    }
    
    private func updateCustomEffect(position: CGPoint)
    {
        customCursorLayer.emitterPosition = CGPoint(x: position.x, y: position.y)
    }
}


