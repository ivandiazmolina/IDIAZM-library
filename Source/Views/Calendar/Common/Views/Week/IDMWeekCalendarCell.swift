//
//  WeekCalendarCell.swift
//  IDIAZM
//
//  Created by Iván Díaz Molina on 30/09/2020.
//

import UIKit

public protocol WeekCalendarCellDelegate: class {
    func didSelectedDay(date: Date)
}

open class WeekCalendarCell: UICollectionViewCell {
    
    @IBOutlet weak var day1CalendarCell: DayCalendarCell!
    @IBOutlet weak var day2CalendarCell: DayCalendarCell!
    @IBOutlet weak var day3CalendarCell: DayCalendarCell!
    @IBOutlet weak var day4CalendarCell: DayCalendarCell!
    @IBOutlet weak var day5CalendarCell: DayCalendarCell!
    @IBOutlet weak var day6CalendarCell: DayCalendarCell!
    @IBOutlet weak var day7CalendarCell: DayCalendarCell!
    
    var views: [DayCalendarCell] = []
    var dates: [Date] = []
    weak var delegate: WeekCalendarCellDelegate?
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    open override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
        for view in views {
            view.numberLabel.round()
        }
    }
    
    fileprivate func setupView() {
        
        views = [day1CalendarCell, day2CalendarCell, day3CalendarCell, day4CalendarCell, day5CalendarCell, day6CalendarCell, day7CalendarCell]
        
        for (index, view) in views.enumerated() {
            view.numberLabel.text = ""
            view.tag = index
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
            view.addGestureRecognizer(tap)
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        
        guard let view = sender?.view,
            let date = dates.getElement(view.tag) else { return }
        
        delegate?.didSelectedDay(date: date)
    }
    
    //    /// Update UI of cell
    //    /// - Parameter date: date
    func updateUI(dates: [Date], data: CalendarData) {
        
        self.dates = dates
        
        setNeedsLayout()
        layoutIfNeeded()
        
        for (index, date) in dates.enumerated() {
            
            // get view
            guard let view: DayCalendarCell = views.getElement(index) else { return }
            
            // text
            view.numberLabel.text = String(describing: date.day)
            
            // text color
            if data.currentDate.isSameDate(date: date) {
                view.numberLabel.textColor = .white
                view.numberLabel.backgroundColor = .red
            } else if data.selectedDate.isSameDate(date: date) {
                view.numberLabel.textColor = .white
                view.numberLabel.backgroundColor = .blue
            } else {
                view.numberLabel.textColor = Calendar.currentUTC.month == date.month ? .black : .gray
                view.numberLabel.backgroundColor = .white
            }
            
        }
    }
}

