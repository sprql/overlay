//
//  StatusMenuController.swift
//  Overlay
//
//  Created by Alexander Obukhov on 1/13/18.
//  Copyright © 2018 sprql. All rights reserved.
//

import Cocoa

class StatusMenuController: NSObject {
    
    @IBOutlet weak var statusMenu: NSMenu!
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    var window: NSWindow?

    override func awakeFromNib() {
        statusItem.menu = statusMenu
        statusItem.image = NSImage(named: NSImage.Name(rawValue: "overlay-statusmenu-icon"))
    }
    
    func createOverlay(path: URL) -> NSWindow {
        let window = NSWindow(contentRect: NSMakeRect(0, 0, 0, 0), styleMask: NSWindow.StyleMask.borderless, backing: NSWindow.BackingStoreType.buffered, defer: true)
        
        window.styleMask = NSWindow.StyleMask.borderless
        window.backgroundColor = NSColor.clear
        window.level = NSWindow.Level.floating
        window.makeKeyAndOrderFront(nil)
        window.canHide = false
        window.isOpaque = false
        window.hasShadow = false
        window.collectionBehavior = [.stationary, .canJoinAllSpaces, .ignoresCycle]

        let image = NSImage(contentsOf: path)!
        
        let contentView = window.contentView!
        contentView.wantsLayer = true
        contentView.layer?.contents = image
        
        window.setFrame(NSMakeRect(0, 0, image.size.width, image.size.height), display: true)
        window.alphaValue = 0.5
        window.ignoresMouseEvents = true
        
        return window;
    }
    
    @IBAction func addOverlay(_ sender: Any) {
        let dialog = NSOpenPanel();
        
        dialog.canCreateDirectories = false;
        dialog.allowsMultipleSelection = false;
        dialog.allowedFileTypes = ["jpg", "png"];
        
        if (dialog.runModal() == NSApplication.ModalResponse.OK) {
            let url = dialog.url
            if (url != nil) {
                 self.window = createOverlay(path: url!)
            }
        } else {
            return
        }
    }
}
