//
//  ViewController.swift
//  HomeWork9
//
//  Created by Роман on 14.06.2020.
//  Copyright © 2020 destplay. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sharedTextLabel: UILabel!
    
    private let presenter = Presenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.viewDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
    }

    @objc func viewDidBecomeActive() {
        let userDefaults = UserDefaults(suiteName: "group.ru.destplay.HomeWork9")
        let text = userDefaults?.string(forKey: "SHARED_TEXT") ?? self.sharedTextLabel.text!
        self.sharedTextLabel.text = self.presenter.getDateText(text: text)
        self.sharedTextLabel.text = self.presenter.getMeasurentText(text: self.sharedTextLabel.text ?? "")
    }

    @IBAction func actionSegmentedLocale(_ sender: UISegmentedControl) {
        let userDefaults = UserDefaults(suiteName: "group.ru.destplay.HomeWork9")
        let text = userDefaults?.string(forKey: "SHARED_TEXT") ?? self.sharedTextLabel.text!
        var locale = Locale(identifier: "en_EN")
        switch sender.selectedSegmentIndex {
            case 0:
                locale = Locale(identifier: "en_EN")
            case 1:
                locale = Locale(identifier: "fr_FR")
            case 2:
                locale = Locale(identifier: "it_CH")
            default:
                break
        }
        self.sharedTextLabel.text = self.presenter.getDateText(text: text, locale: locale)
        self.sharedTextLabel.text = self.presenter.getMeasurentText(text: self.sharedTextLabel.text ?? "", locale: locale)
    }
    
}

