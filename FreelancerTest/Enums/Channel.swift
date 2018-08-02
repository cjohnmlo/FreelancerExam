//
//  Channel.swift
//  FreelancerTest
//
//  Created by Christian John Lo on 01/08/2018.
//  Copyright © 2018 Christian John Lo. All rights reserved.
//

import Foundation
import UIKit

enum Channel: String {
    case TEN
    case Seven
    case SBSOne = "SBS One"
    case SBSTwo = "SBS 2"
    case ONE
    case Nine
    case ELEVEN
    case ABC1
    case SevenMate = "7Mate"
    case SevenTwo = "7TWO"
    case Unknown
    
    init(withRawValue: String) {
        if let channel = Channel(rawValue: withRawValue) {
            self = channel
        }
        else {
            self = .Unknown
        }
    }
   
    func channelImage() -> UIImage? {
        return UIImage(named: self.rawValue)
    }
}
