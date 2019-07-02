//
//  AppDelegate.swift
//  KQED Player
//
//  Created by Andrey on 7/2/19.
//  Copyright © 2019 Turbobabr. All rights reserved.
//

import Cocoa
import AVKit;
import AVFoundation;


@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    var player:AVPlayer?
    var isPlaying:Bool = false

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if let button = statusItem.button {
            button.action = #selector(AppDelegate.onIconClick(sender:))
            button.sendAction(on: [.leftMouseUp, .rightMouseUp])
        }
        
        load()
        play()
    }

    @objc func onIconClick(sender: NSStatusItem) {
        let event = NSApp.currentEvent!
        if event.type == NSEvent.EventType.rightMouseUp {
            quit()
        } else {
            toggle()
        }
    }
    
    func quit() {
        NSApp.terminate(self);
    }
    
    func load() {
        player = AVPlayer(url: URL(string: "https://streams.kqed.org/kqedradio.m3u")!)        
    }
    
    func play() {
        isPlaying = true;
        statusItem.image = NSImage(named: "tray-icon-active")
        player!.play()
    }
    
    func toggle() {
        if isPlaying {
            stop()
        } else {
            load()
            play()
        }
    }
    
    func stop() {
        if let playerInstance = player {
            statusItem.image = NSImage(named: "tray-icon-normal")
            playerInstance.pause()
            player = nil
            isPlaying = false;
        }
    }
}

