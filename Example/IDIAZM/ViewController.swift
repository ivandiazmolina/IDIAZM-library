//
//  ViewController.swift
//  IDIAZM
//
//  Created by ivandiazmolina on 09/04/2020.
//  Copyright (c) 2020 ivandiazmolina. All rights reserved.
//

import UIKit
import IDIAZM

class ViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: VARS AND LETS
    private let OPTIONS: [String] = ["Intrinsic Height TableView", "Custom Cell"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        
        // setup TableView
        setupTableView()
        
        // test Extensions
        testUIColorExtensions()
        testArrayExtensions()
        testStringExtensions()
        testDateExtensions()
        
        // test Utils
        testCustomLog()
    }
    
    /// init TableView
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    /// method to test extensions of UIColor
    private func testUIColorExtensions() {
        
        print("UICOLOR EXTENSION")
        print("=================")
        
        // random color
        print("Random color: \(UIColor.random())")
        
        // red color HEX format with #
        print("Red color: \(UIColor.colorFrom(hex: "#FF0000"))")
        
        // blue color HEX format without #
        print("Blue color: \(UIColor.colorFrom(hex: "0000FF"))")
        
        // red color HEX format with # and alpha 0.5
        print("Red color with alpha 0.5: \(UIColor.colorFrom(hex: "#FF0000", alpha: 0.5))")
        
        // green color RGB format
        print("Green color : \(UIColor.colorFrom(red: 0, green: 255, blue: 0))")
        
        // green color RGB format with alpha 0.5
        print("Green color with alpha 0.5: \(UIColor.colorFrom(red: 0, green: 255, blue: 0, alpha: 0.5))")
        
        newLine()
    }
    
    /// method to test extensions of Array
    private func testArrayExtensions() {
        
        var data: [String] = []
        
        for i in 0...10 {
            data.append("data \(i)")
        }
        
        print("ARRAY EXTENSIONS")
        print("=================")
        
        // get element from array of position 1 --> "data1"
        print("Element: \(data.getElement(1))")
        
        // get element from array of position 11 --> nil
        print("Element: \(data.getElement(11))")
        
        newLine()
    }
    
    /// method to test extensions of String
    private func testStringExtensions() {
        
        let onlyDigits = "1234567890"
        let onlyLetters = "abcdefgh"
        let emailOK = "test@gmail.com"
        let emailKO = "test@gmail"
        let strongPassword = "A^pbzPwYF8c3q=z"
        let weakPassword = "lowpassword123"
        
        print("STRING EXTENSIONS")
        print("=================")
        
        // test contains only digits
        print("Text '\(onlyDigits)' contains only digits?: \(onlyDigits.containsOnlyDigits)")
        print("Text '\(onlyDigits)' contains only letters?: \(onlyDigits.containsOnlyLetters)")
        
        // test contains only letters
        print("Text '\(onlyLetters)' contains only digits?: \(onlyLetters.containsOnlyDigits)")
        print("Text '\(onlyLetters)' contains only letters?: \(onlyLetters.containsOnlyLetters)")
        
        // test hash
        print("Hash generated: \(String.generateHash())")
        
        // test valid email
        print("\(emailOK) is valid email?: \(emailOK.isValidEmail())")
        print("\(emailKO) is valid email?: \(emailKO.isValidEmail())")
        
        // test valid strong password
        print("\(strongPassword) is strong password?: \(strongPassword.isValidStrongPassword())")
        print("\(weakPassword) is strong password?: \(weakPassword.isValidStrongPassword())")
        
        // test to bool
        print("'true' to bool: \("true".toBool())")
        print("'1' to bool: \("1".toBool())")
        print("'yes' to bool: \("yes".toBool())")
        print("'false' to bool: \("false".toBool())")
        print("'0' to bool: \("0".toBool())")
        print("'no' to bool: \("no".toBool())")
        
        // test capitalize first letter
        print("capitalizing 'hello world: \("hello world".capitalizingFirstLetter())")
        
        // test localizable
        print("localize key 'hello': \("hello".localized)")
        
        newLine()
    }
    
    /// method to test extensions of Date
    private func testDateExtensions() {
        
        let date = Date()
        let day: Date.WeekDays = .friday
        
        print("DATE EXTENSIONS")
        print("=================")
        
        print("Example date: \(date)")
        
        // test first day of current month
        print("First day of current month: \(date.firstDayOfCurrentMonth)")
        
        // test is first day of current month
        print("Is first day of current month?: \(date.isFirstDayOfCurrentMonth)")
        
        // test last day of current month
        print("Last day of current month: \(date.lastDayOfCurrentMonth)")
        
        // test year
        print("Year: \(date.year)")
        
        // test month
        print("Month: \(date.month)")
        
        // test day
        print("Day: \(date.day)")
        
        // test hour
        print("Hour: \(date.hour)")
        
        // test minute
        print("Minutes: \(date.minute)")
        
        // test add years
        print(date.add(years: 1))
        
        // test add months
        print(date.add(months: 1))
        print(date.add(months: -1)) // you can negative numbers
        
        // test add days
        print(date.add(days: 1))
        
        // test add hours
        print(date.add(hours: 1))
        
        // test add minute
        print(date.add(minutes: 1))
        
        // test string from date
        print(date.stringFromDate(format: "dd/MM/yyyy"))
        
        print("Example week day: \(day)")
        
        print("Short weekday: \(day.getShortWeekdaySymbols())")
        
        print("Very short weekday: \(day.getVeryShortWeekdaySymbols())")
        
        newLine()
    }
    
    /// method to test CustomLog
    private func testCustomLog() {
        
        CustomLog.log(type: .default, category: .default, item: "This is a default message")
        CustomLog.log(type: .info, category: .default, item: "This is a info message")
        CustomLog.log(type: .debug, category: .default, item: "This is a debug message")
        CustomLog.log(type: .error, category: .default, item: "This is a error message")
        CustomLog.log(type: .success, category: .default, item: "This is a success message")
    }
    
    private func newLine() {
        print("\n")
    }
}

// MARK: Navigations
extension ViewController {
    
    /// method that navigates to IntrinsicHeightTableViewViewController
    private func navigateToIntrinsicHeightTableView() {
        print("navigateToIntrinsicHeightTableView")
        
        let storyBoard = UIStoryboard(name: "IntrinsicHeightTableView", bundle: nil)
        if let viewController: IntrinsicHeightTableViewViewController = storyBoard.instantiateInitialViewController() as? IntrinsicHeightTableViewViewController,
            let navController = navigationController {
            navController.show(viewController, sender: nil)
        }
    }
    
    /// method that navigates to CustomCellViewController
    private func navigateToCustomCell() {
        print("navigateToCustomCell")
        
        let storyBoard = UIStoryboard(name: "CustomCell", bundle: nil)
        if let viewController: CustomCellViewController = storyBoard.instantiateInitialViewController() as? CustomCellViewController,
            let navController = navigationController {
            navController.show(viewController, sender: nil)
        }
    }
    
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return OPTIONS.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else { return UITableViewCell()}

        cell.textLabel?.text = OPTIONS.getElement(indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("Did selected row at: \(indexPath.row)")
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        switch indexPath.row {
        case 0: navigateToIntrinsicHeightTableView()
        case 1: navigateToCustomCell()
        default: break
        }
    }
}
