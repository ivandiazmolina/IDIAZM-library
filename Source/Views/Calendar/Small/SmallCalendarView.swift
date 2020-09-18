//
//  SmallCalendarView.swift
//  IDIAZM
//
//  Created by Iván Díaz Molina on 13/09/2020.
//  Copyright © 2020 IDIAZM. All rights reserved.
//

import UIKit

open class SmallCalendarView: UIView {
    
    // MARK: IBOutlets
    @IBOutlet weak var weekDaysStackView: UIStackView!
    @IBOutlet weak var numberDaysCollectionView: UICollectionView!
    @IBOutlet weak var monthLabel: UILabel!
    
    // MARK: LETS
    private let ITEMS_BY_ROW: CGFloat = 7
    private let SECTION_INSETS = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    
    // MARK: VARS
    private var elements: [Date] = []
    open var isAmericanCalendar: Bool = Calendar.currentUTC.firstWeekday == 1 {
        didSet {
            setupView()
        }
    }
    
    private var selectedDay: Date = Date()
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupXib()
        setupView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupXib()
        setupView()
    }
    
    // MARK: Gestures
    
    @IBAction func onBackTap(_ sender: UIButton) {
        print("Back tapped")
    }
    
    @IBAction func onNextTap(_ sender: UIButton) {
        print("Next tapped")
    }
    
    
    // MARK: Private methods
    
    /// Setup View
    fileprivate func setupView() {
        
        // Setup Months
        setupMonths()
        
        // Setup Week Days
        setupWeekDays()
        
        // Setup Number Days
        setupNumberDays()
        
        // Create Week Days
        createWeekDays()
        
        // Calculate days for calendar
        calculateDays()
    }
    
    /// Setup the Months 
    fileprivate func setupMonths() {
        monthLabel.text = getMonthName()
    }
    
    /// Setup the StackView component which contains the days of week
    fileprivate func setupWeekDays() {
        
        weekDaysStackView.axis = .horizontal
        weekDaysStackView.distribution = .fillEqually
    }
    
    /// Setup the StackView component which contains the numbers in the calendar
    fileprivate func setupNumberDays() {
        
        numberDaysCollectionView.register(NumberCalendarCell.self)
        numberDaysCollectionView.delegate = self
        numberDaysCollectionView.dataSource = self
        
        if let layout = numberDaysCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        
        numberDaysCollectionView.showsHorizontalScrollIndicator = false
        numberDaysCollectionView.showsVerticalScrollIndicator = false
        numberDaysCollectionView.isPagingEnabled = true
    }
    
    /// create the WeekDays on the header
    fileprivate func createWeekDays() {
        
        // clear the current headers
        clearWeekDays()
                
        var days: [Calendar.WeekDays] = [.sunday,.monday, .tuesday, .wednesday, .thursday, .friday, .saturday]
        
        // switch var 'isAmericanCalendar', the header will change his order
        if !isAmericanCalendar {
            let element = days.remove(at: 0)
            days.append(element)
        }
        
        // through the days of the week and add them to the header
        for tmp in days {
            
            let label = UILabel()
            label.text = tmp.getShortWeekdaySymbols()?.capitalized
            label.textAlignment = .center
            
            weekDaysStackView.addArrangedSubview(label)
        }
    }
    
    /// remove the days of the week from the headers
    fileprivate func clearWeekDays() {
        
        // through the views in the stackView and remove them
        for tmp in weekDaysStackView.arrangedSubviews {
            weekDaysStackView.removeArrangedSubview(tmp)
            tmp.removeFromSuperview()
        }
    }
    
    /// Calculate the days to show in calendar view
    fileprivate func calculateDays() {
        
        // get the current calendar
        let calendar = Calendar.currentUTC
        
        // get the first and last day of current month
        let firstDay = calendar.firstDayOfCurrentMonth
        let lastDay = calendar.lastDayOfCurrentMonth
        
        // clear the elements object
        elements = []
        
        // get the firstWeekDay switch calendar type
        let firstWeekDay = isAmericanCalendar ? 1 : 2
        
        // get the weekDays of first and last day of calendar
        let weekDayFirstDay = calendar.component(.weekday, from: firstDay)
        let weekDayLastDay = calendar.component(.weekday, from: lastDay)
        
        // calculate past days of month
        var diff = weekDayFirstDay - firstWeekDay
        for index in 1...diff {
            let beforeDay = firstDay.add(days: -(index))
            elements.append(beforeDay)
        }
        
        // reverse the elements of array
        elements.reverse()
        
        // calculate days of month
        let totalDaysOfMonth = Calendar.currentUTC.getDaysOfMonth()
        for i in 0...totalDaysOfMonth - 1 {
            elements.append(firstDay.add(days: i))
        }
                
        // calculate future days of month
        diff = 7 - (isAmericanCalendar ? weekDayLastDay : weekDayLastDay - 1)
        if diff > 0 {
            for index in 1...diff {
                let afterDay = lastDay.add(days: index)
                elements.append(afterDay)
            }
        }
        
        // reload collectionView
        numberDaysCollectionView.reloadData()
    }
    
    /// Get the String of the month parameter
    /// - Parameter month: month of which you want its name
    fileprivate func getMonthName(month: Calendar.Months = .current) -> String {
        return month.description
    }
}

// MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension SmallCalendarView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return elements.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NumberCalendarCell.identifier, for: indexPath) as? NumberCalendarCell else { return UICollectionViewCell()}
                
        // check if exists element on array
        if let date = elements.getElement(indexPath.row) {
            cell.updateUI(date: date)
        }
        
        // return cell
        return cell
    }
}

// MARK: UICollectionViewFlowLayout
extension SmallCalendarView: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // get the padding space between items
        let padding = SECTION_INSETS.left * (ITEMS_BY_ROW + 1)
        
        // get the available width of the screen
        let availableWidth = UIScreen.main.bounds.width - padding
        
        // calculate the width of the item
        let itemWidth = availableWidth / ITEMS_BY_ROW
        
        // return item size
        return CGSize(width: itemWidth, height: collectionView.frame.height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return SECTION_INSETS
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return SECTION_INSETS.left
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
