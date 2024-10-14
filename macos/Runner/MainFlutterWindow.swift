import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
    override func awakeFromNib() {
        let flutterViewController = FlutterViewController()
        let windowFrame = self.frame
        self.contentViewController = flutterViewController
        self.setFrame(windowFrame, display: true)

        // Hide titlebar and make window resizable
        self.styleMask.insert(.fullSizeContentView)
        self.styleMask.insert(.resizable)
        self.titlebarAppearsTransparent = true
        self.titleVisibility = .hidden

        // Hide the standard window buttons
        self.standardWindowButton(.closeButton)?.isHidden = true
        self.standardWindowButton(.miniaturizeButton)?.isHidden = true
        self.standardWindowButton(.zoomButton)?.isHidden = true

        // Make the window movable by its background
        self.isMovableByWindowBackground = true

        RegisterGeneratedPlugins(registry: flutterViewController)

        super.awakeFromNib()
    }
}
