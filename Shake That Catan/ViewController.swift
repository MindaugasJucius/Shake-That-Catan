//
//  ViewController.swift
//  Shake That Catan
//
//  Created by Mindaugas Jucius on 24/02/16.
//  Copyright © 2016 mindawg. All rights reserved.
//

import UIKit
import AKPickerView_Swift

private enum Dice: Int {
    case One = 1
    case Two
    case Three
    case Four
    case Five
    case Six
    
    
    var image: UIImage? {
        switch self {
        case .One:
            return UIImage(named: "one")
        case .Two:
            return UIImage(named: "two")
        case .Three:
            return UIImage(named: "three")
        case .Four:
            return UIImage(named: "four")
        case .Five:
            return UIImage(named: "five")
        case .Six:
            return UIImage(named: "six")
        }
    }
    
    var imageWhite: UIImage? {
        switch self {
        case .One:
            return UIImage(named: "oneWhite")
        case .Two:
            return UIImage(named: "twoWhite")
        case .Three:
            return UIImage(named: "threeWhite")
        case .Four:
            return UIImage(named: "fourWhite")
        case .Five:
            return UIImage(named: "fiveWhite")
        case .Six:
            return UIImage(named: "sixWhite")
        }
    }
}

private let differentDiceValues = 6

class ViewController: UIViewController, AKPickerViewDelegate, AKPickerViewDataSource {

    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var statsButton: UIButton!
    @IBOutlet var collectionOfImageViews: Array<UIImageView>!
    
    @IBOutlet weak var diceCount: UILabel!
    @IBOutlet weak var akPickerView: AKPickerView!
    
    private let flatColors = UIColor.flatColors()
    private let tapticEngine = UIDevice.currentDevice().performSelector(Selector("_tapticEngine"))
    private let dices: [Dice] = [.One, .Two, .Three, .Four, .Five, .Six]
    
    private var results: [Int] = []
    private var labelColor: UIColor?
    private var selectedDiceCount: Int = Dice.One.rawValue
    private var isLight: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = randomColor()
        results = allocateArray()
        akPickerView.pickerViewStyle = .Wheel
        akPickerView.interitemSpacing = 15.0
        akPickerView.textColor = UIColor.whiteColor()
        akPickerView.highlightedTextColor = UIColor.cloudsColor()
        akPickerView.backgroundColor = UIColor.blackColor()
        akPickerView.layer.borderWidth = 1.0
        akPickerView.layer.cornerRadius = 5.0
        akPickerView.layer.borderColor = UIColor.blackColor().CGColor
        statsButton.layer.borderWidth = 1.0
        statsButton.layer.cornerRadius = 5.0
        akPickerView.delegate = self
        akPickerView.dataSource = self
        updateColors()
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake {
            performRollActions()
        }
    }
    
    func numberOfItemsInPickerView(pickerView: AKPickerView) -> Int {
        return dices.count
    }
    
    func pickerView(pickerView: AKPickerView, titleForItem item: Int) -> String {
        return String(dices[item])
    }
    
    func pickerView(pickerView: AKPickerView, didSelectItem item: Int) {
        selectedDiceCount = dices[item].rawValue
        results = allocateArray()
    }
    
    @IBAction func statsButtonTouched(sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("StatsViewController") as! StatsViewController
        vc.backgroundColor = view.backgroundColor
        vc.resultsGrouped = Array(results.dropFirst(selectedDiceCount))
        vc.labelColor = labelColor
        presentViewController(vc, animated: true, completion: nil)
        
        
    }
    
    @IBAction func tapGesture(sender: UITapGestureRecognizer) {
        performRollActions()
    }
    
    private func performRollActions() {
        updateColors()
        let result = rollDices()
        updateFeedback(result)
    }
    
    private func rollDices() -> Int {
        var sum = 0
        
        collectionOfImageViews.map{ $0.image = nil }
        
        for i in 1...selectedDiceCount {
            let dice = Int.random()
            let index = i - 1
            let diceIndex = dice - 1
            if isLight {
                collectionOfImageViews[index].image = dices[diceIndex].image
            } else {
                collectionOfImageViews[index].image = dices[diceIndex].imageWhite
            }
            sum += dice
        }
        results[sum] = results[sum] + 1
        print(results)
        return sum
    }
    
    private func updateFeedback(sum: Int) {
        resultLabel.text = String(sum)
        
        if MMacros.IS_IPHONE_6S_OR_IPHONE6S_PLUS() {
            UIDevice.currentDevice().tapticEngine().actuateFeedback(UITapticEngineFeedbackPop)
        }
    }
    
    private func updateColors() {
        let viewColor = randomColor()
        isLight = viewColor.isLight()
        let color = isLight ? UIColor.blackColor() : UIColor.whiteColor()
        
        view.backgroundColor = viewColor
        labelColor = color
        resultLabel.textColor = color
        diceCount.textColor = color
        statsButton.layer.borderColor = color.CGColor
        
        updateButtonColor(statsButton, color: color)
    }
    
    private func updateButtonColor(button: UIButton, color: UIColor) {
        button.setTitleColor(color, forState: .Normal)
        button.setTitleColor(color, forState: .Highlighted)
    }
    
    private func randomColor() -> UIColor {
        return flatColors[Int.random(0, flatColors.count-1)]
    }
    
    private func allocateArray() -> Array<Int> {
        let array = Array(count: dices.count * selectedDiceCount + 1, repeatedValue: 0)
        print("allocated \(array.count) items")
        return array
    }
    
}

