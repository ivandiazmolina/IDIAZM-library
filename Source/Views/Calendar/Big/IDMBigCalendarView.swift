//
//  BigCalendarView.swift
//  IDIAZM
//
//  Created by Iván Díaz Molina on 29/09/2020.
//

import UIKit

open class BigCalendarView: UIView {
    
    // MARK: IBOutlets
    @IBOutlet weak var weekDaysStackView: UIStackView!
    @IBOutlet weak var numberDaysCollectionView: UICollectionView!
    @IBOutlet weak var monthLabel: UILabel!
    
    // MARK: LETS
    private let ITEMS_BY_ROW: CGFloat = 7 // 7 days
    private let SECTION_INSETS = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    private let DIFF_YEARS = 5
    
    // MARK: VARS
    private let calendar = Calendar.currentUTC
    private var data = CalendarData()
    
    private var startDate: Date = Date()
    private var endDate: Date = Date()
    
    open weak var delegate: CalendarDelegate?
    open var isAmericanCalendar: Bool = Calendar.currentUTC.firstWeekday == 1 {
        didSet {
            setupView()
        }
    }
    
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
        updateDate(date: data.selectedDate.add(months: -1))
    }
    
    @IBAction func onNextTap(_ sender: UIButton) {
        print("Next tapped")
        updateDate(date: data.selectedDate.add(months: 1))
    }
    
    // MARK: Public methods
    
    /// Gets the Month Object from a Date
    /// - Parameter date: Date which you wish the month object
    /// - Returns: Month , otherwhise nil
    func getMonth(date: Date = Date()) -> Calendar.Months? {
        
        guard let month = Calendar.Months(rawValue: date.month) else {
            print("Error to get month")
            return nil
        }
        
        return month
    }
    
    /// Updates Calendar UI
    /// - Parameter date: date which you want to show on the calendar
    func updateDate(date: Date) {
        
        // get the month object from date
        guard let month = getMonth(date: date) else {
            print("Error to update month")
            return
        }
        
        // updates the month label
        monthLabel.text = "\(month.description) \(date.year)"
        
        // update data struct
        var newData = data
        newData.selectedDate = date
        updateData(data: newData)
        
        print("Date on Calendar: \(data.selectedDate)")
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
        
        // Setup Calendar Range
        //        setupCalendarRange()
        createMonths()
        
        //animateToCurrentMonth
        animationToDay(animated: false)
    }
    
    /// Setup the Months
    fileprivate func setupMonths() {
        
        updateDate(date: data.selectedDate)
    }
    
    /// Setup the StackView component which contains the days of week
    fileprivate func setupWeekDays() {
        
        weekDaysStackView.axis = .horizontal
        weekDaysStackView.distribution = .fillEqually
    }
    
    /// Setup the StackView component which contains the numbers in the calendar
    fileprivate func setupNumberDays() {
        
        numberDaysCollectionView.register(WeekCalendarCell.self)
        numberDaysCollectionView.delegate = self
        numberDaysCollectionView.dataSource = self
        
        if let layout = numberDaysCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
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
    
    fileprivate func createMonths() {
        let currentDate = Date()
        for int in -1...1 {
            let calculatedDate = currentDate.add(months: int)
            calculateDays(date: calendar.getDate(year: calculatedDate.year, month: calculatedDate.month) ?? Date())
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
    
    /// Calculate the days to show in calendar view in 3 weeks
    fileprivate func setup3Weeks() {
        
        // get the first and last day of current month
        var firstDayOfCurrentWeek = calendar.firstDayOfCurrentWeek
        
        // get the firstWeekDay switch calendar type
        if isAmericanCalendar && calendar.firstWeekday == 2 { // isAmericanCalendar && firsWeekday spanish
            firstDayOfCurrentWeek = firstDayOfCurrentWeek.add(days: -1)
        } else if !isAmericanCalendar && calendar.firstWeekday == 1 { // is not isAmericanCalendar && firsWeekday EEUU
            firstDayOfCurrentWeek = firstDayOfCurrentWeek.add(days: 1)
        }
        
        // get the past week
        let lastWeek = firstDayOfCurrentWeek.add(weeks: -1)
        
        // clear the elements object
        data.weekRange = []
        
        // init a temporal array
        var elements: [Date] = []
        
        // get days
        for index in 0...20 {   // 20 = 3 weeks
            let day = lastWeek.add(days: index)
            elements.append(day)
        }
        
        // split the elements
        //        data.weekRange = elements.chunked(into: Int(ITEMS_BY_ROW))
        
        // reload collectionView
        reloadData()
    }
    
    /// Updates the days to show in calendar view in 3 weeks
    fileprivate func updates3Weeks(forward: Bool) {
        
        // removes before or next week switch forward
        _ = forward ? data.weekRange.removeFirst() : data.weekRange.removeLast()
        
        // gets the first day switch week
        let day = data.weekRange.getElement(forward ? 1 : 0)?.getElement(0)
        let lastWeek = day?.add(weeks: forward ? 1 : -1)
        
        var newElements: [Date] = []
        let closedRange: ClosedRange = 0...6
        
        // insert new elements at first of array
        for index in closedRange {
            newElements.append(lastWeek?.add(days: index) ?? Date())
        }
        
        // updates the elements
        forward ? data.weekRange.append(newElements) : data.weekRange.insert(newElements, at: 0)
        
        // reload new data
        reloadData()
        
        // scroll to new position
        animationToDay(animated: false)
    }
    
    /// Calculate the days to show in calendar view
    fileprivate func calculateDays(date: Date) {
        
        // get the first and last day of current month
        //
        //        Date().year
        //        Date().month
        
        //        calendar.getDate(year: 2020, month: 1)
        
        let firstDay = date.firstDayOfMonth
        let lastDay = date.lastDayOfMonth
        
        // clear the elements object
        var elements: [Date] = []
        
        // get the firstWeekDay switch calendar type
        let firstWeekDay = getFirstWeekDay()
        
        // get the weekDays of first and last day of calendar
        let weekDayFirstDay = calendar.component(.weekday, from: firstDay)
        let weekDayLastDay = calendar.component(.weekday, from: lastDay)
        
        // calculate past days of month
        
        var diff = weekDayFirstDay - firstWeekDay
        if diff > 0 {
            for index in 1...diff {
                let beforeDay = firstDay.add(days: -(index))
                elements.append(beforeDay)
            }
        }
        
        // reverse the elements of array
        elements.reverse()
        
        // calculate days of month
        let totalDaysOfMonth = date.daysOfMonth
        for i in 0...totalDaysOfMonth - 1 {
            elements.append(firstDay.add(days: i))
        }
        
        // calculate future days of month
        diff = Int(ITEMS_BY_ROW) - (isAmericanCalendar ? weekDayLastDay : weekDayLastDay - 1)
        if diff > 0 {
            for index in 1...diff {
                let afterDay = lastDay.add(days: index)
                elements.append(afterDay)
            }
        }
        
        data.monthRange.append(WeekRange(week: elements.chunked(into: Int(ITEMS_BY_ROW))))
        
        //        data.monthRange.append(elements.chunked(into: Int(ITEMS_BY_ROW))
        
        // split the elements
        //        var calendarRange = WeekRange(month: date.month, year: date.year, daysInMonth: 30, weekRange: elements.chunked(into: Int(ITEMS_BY_ROW)))
        //        data.monthRange.append
        
        // reload collectionView
        reloadData()
    }
    
    /// Scroll Collectionview to specific day with optional animation
    /// - Parameters:
    ///   - animated: animation
    fileprivate func animationToDay(animated: Bool = true) {
        
        // init the animation
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.numberDaysCollectionView.setContentOffset(CGPoint(x: UIScreen.main.bounds.width, y: 0), animated: animated)
        }
    }
    
    /// Update the data struct
    /// - Parameter data: new data
    fileprivate func updateData(data: CalendarData) {
        self.data = data
    }
    
    /// Reload the collection view in order to updates cells
    fileprivate func reloadData() {
        numberDaysCollectionView.reloadData()
    }
    
    /// get the first day of the week according to the calendar
    /// - Returns: 1 if is American, otherwhise 2
    fileprivate func getFirstWeekDay() -> Int {
        return isAmericanCalendar ? 1 : 2
    }
    
    /// Creates a date object from indexPath
    /// - Parameter indexPath: index path
    /// - Returns: date object
    fileprivate func createDateFrom(indexPath: IndexPath) -> Date? {
        
        return Date()
        
        //        // check if exists element on array
        //        guard let range = data.monthRange.getElement(indexPath.section),
        //            let date = calendar.getDate(year: range.year, month: range.month, day: indexPath.row) else {
        //                print("Error to create date from IndexPath")
        //                return nil
        //        }
        //
        // return date object
        //        return date
    }
}

// MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension BigCalendarView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.monthRange.getElement(section)?.week.count ?? 0
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.monthRange.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeekCalendarCell.identifier, for: indexPath) as? WeekCalendarCell else { return UICollectionViewCell()}
        
        cell.delegate = self
        
        // check if exists element on array
        if let week = data.monthRange.getElement(indexPath.section)?.week.getElement(indexPath.row) {
            cell.updateUI(dates: week, data: data)
        }
        
        return cell
    }
}

// MARK: UICollectionViewFlowLayout
extension BigCalendarView: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // return item size
        return CGSize(width: UIScreen.main.bounds.width, height: CalendarConstants.HEIGHT_ROW)
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
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            let currentPage = scrollView.currentPage
            // Do something with your page update
            print("scrollViewDidEndDragging: \(currentPage)")
        }
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = scrollView.currentPage
        // Do something with your page update
        print("scrollViewDidEndDecelerating: \(currentPage)")
        
        return
        
        switch currentPage {
        case 0: // past
            updates3Weeks(forward: false)
            updateDate(date: data.selectedDate.add(weeks: -1))
            reloadData()
        case 2: // future
            updates3Weeks(forward: true)
            updateDate(date: data.selectedDate.add(weeks: 1))
            reloadData()
        default:
            break
        }
        
    }
}

// MARK: WeekCalendarCellDelegate
extension BigCalendarView: WeekCalendarCellDelegate {
    public func didSelectedDay(date: Date) {
        
        print(date)
        
        // updates the data struct
        var newData = data
        newData.selectedDate = date
        updateData(data: newData)
        
        // refresh collectionview
        reloadData()
        
        // notify
        delegate?.didSelectedDate(date: date)
    }
}
