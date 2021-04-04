//
//  ViewController.swift
//  Joystick
//
//  Created by Cristhian Leon on 07.01.20.
//  Copyright © 2020 Cristhian. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private var joystickA: Joystick!
    @IBOutlet private var joystickB: Joystick!
    @IBOutlet private var joystickC: Joystick!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        joystickA.mainColor = UIColor(red: 236/255, green: 155/255, blue: 59/255, alpha: 1)
        joystickB.mainColor = UIColor(red: 41/255, green: 52/255, blue: 98/255, alpha: 1)
        joystickC.mainColor = UIColor(red: 0, green: 129/255, blue: 138/255, alpha: 1)
    }
}

