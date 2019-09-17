//
//  WildCardGestureRecognizer.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/12/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import UIKit.UIGestureRecognizerSubclass

class WildCardGestureRecognizer: UIPinchGestureRecognizer {
    
    var touchesBeganCallback: ((Set<UITouch>, UIEvent) -> Void)?
    var touchesMovedCallback: ((Set<UITouch>, UIEvent) -> Void)?
    var touchesEndedCallback: ((Set<UITouch>, UIEvent) -> Void)?
    
    override init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
        self.cancelsTouchesInView = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        touchesBeganCallback?(touches, event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)
        touchesMovedCallback?(touches, event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)
        touchesEndedCallback?(touches, event)
    }
    
    override func canPrevent(_ preventedGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
    
    override func canBePrevented(by preventingGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}
