//
//  ShareViewController.swift
//  TextExtension
//
//  Created by Роман on 14.06.2020.
//  Copyright © 2020 destplay. All rights reserved.
//

import UIKit
import Social

class ShareViewController: SLComposeServiceViewController {

    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }

    override func didSelectPost() {
        guard let text = textView.text else { return }
        
        let userDefaults = UserDefaults(suiteName: "group.ru.destplay.HomeWork9")
        userDefaults?.set(text, forKey: "SHARED_TEXT")
        
        let url = URL(string: "HomeWork9://")
        var responder = self as UIResponder?
        let selectorOpenURL = sel_registerName("openURL:")
        
        while (responder != nil) {
            if (responder?.responds(to: selectorOpenURL))! {
                let _ = responder?.perform(selectorOpenURL, with: url)
            }
            responder = responder!.next
        }
        
        self.extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
    }

    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }

}
