//
//  ViewController.swift
//  NSScrollViewCache
//
//  Created by Christian Tietze on 08.07.17.
//  Copyright © 2017 Christian Tietze. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var scrollView: NSScrollView!
    @IBOutlet var textView: NSTextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.verticalScroller = CustomScroller()

        let lipsum = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\n\n"
        textView.string = (0...20).map { _ -> String in lipsum }.joined()
    }

    @IBAction func switchOff(_ sender: Any) {

        print("changing drawing mode, now try to scroll some more; will only begin to not show the scroller if you bounce the scroller to the very top or bottom, or if you tab out and back in to the app again, even though `rect(for:)` and `drawKnob()` are called all the time")
        (scrollView.verticalScroller as! CustomScroller).doesDraw = false
    }
}

class CustomScroller: NSScroller {

    override class func isCompatibleWithOverlayScrollers() -> Bool {
        return self == CustomScroller.self
    }

    var doesDraw = true

    override func drawKnob() {
        guard doesDraw else { return }
        super.drawKnob()
    }

    override func rect(for partCode: NSScrollerPart) -> NSRect {
        var superRect = super.rect(for: partCode)
        guard partCode == .knob else { return superRect }
        guard !doesDraw else { return superRect }

        // Change the rect somehow
        superRect.size.height /= 3
        return superRect
    }
}
