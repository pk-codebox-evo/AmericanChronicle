//
//  DatePickerViewController.swift
//  AmericanChronicle
//
//  Created by Ryan Peterson on 8/15/15.
//  Copyright (c) 2015 ryanipete. All rights reserved.
//

import UIKit
import FSCalendar
import SwiftMoment

@objc class DatePickerViewController: UIViewController, UITextFieldDelegate, FSCalendarDelegate {

    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var yearTextField: UITextField!

    private let selectedDateOnInit: NSDate

    var saveCallback: ((NSDate) -> ())?

    // MARK: UIViewController Init methods

    init(selectedDateOnInit: NSDate = ChroniclingAmericaArchive.earliestPossibleDate) {
        self.selectedDateOnInit = selectedDateOnInit
        super.init(nibName: "DatePickerViewController", bundle: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .Plain, target: self, action: "saveButtonTapped:")
    }

    @IBAction func unfocusedTapRecognized(sender: AnyObject) {
        yearTextField.resignFirstResponder()
    }
    @availability(*, unavailable) init() {
        fatalError("init not supported. Use designated initializer instead")
    }

    @availability(*, unavailable) required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not supported. Use designated initializer instead")
    }

    @availability(*, unavailable) override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        fatalError("init(nibName:bundle) not supported. Use designated initializer instead")
    }

    // MARK: Internal methods

    func saveButtonTapped(sender: UIBarButtonItem) {
        saveCallback?(calendarView.selectedDate)
    }

    func setCalendarDate(year: Int? = nil, month: Int? = nil) {
        if let year = year {
            println("will set year")
            calendarView.selectedDate = NSCalendar.currentCalendar().dateBySettingUnit(.CalendarUnitYear, value: year, ofDate: calendarView.selectedDate, options: NSCalendarOptions.allZeros)
            println("did set year")
        }
        if let month = month {
            println("will set month")
            calendarView.selectedDate = NSCalendar.currentCalendar().dateBySettingUnit(.CalendarUnitMonth, value: month, ofDate: calendarView.selectedDate, options: NSCalendarOptions.allZeros)
            println("did set month")
        }
    }

    func updateLabelsToMatchCurrentDate(currentDate: NSDate) {
        let date = moment(currentDate)
        yearTextField.text = "\(date.year)"
    }

    // MARK: UIViewController overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        calendarView.selectedDate = selectedDateOnInit
        updateLabelsToMatchCurrentDate(calendarView.selectedDate)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        yearTextField.becomeFirstResponder()
    }

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var updatedText = textField.text as NSString
        updatedText = updatedText.stringByReplacingCharactersInRange(range, withString: string)
        if updatedText.length > 4 {
            return false
        }

        if updatedText.length == 0 {
            textField.backgroundColor = UIColor.grayColor()
            return true
        }

        if let year = (updatedText as String).toInt() {
            if year >= 1836 && year <= 1922 {
                setCalendarDate(year: year)
                textField.backgroundColor = UIColor.greenColor()
                // Setting calendar date will trigger its delegate's MonthDidChange method,
                // which will update the textField. If we do it here, we end up modifying 
                // the already-updated text.
                return false
            } else if updatedText.length == 4 {
                textField.backgroundColor = UIColor.redColor()
                return true
            } else {
                textField.backgroundColor = UIColor.grayColor()
                return true
            }
        } else {
            return false
        }
    }

    func calendarCurrentMonthDidChange(calendar: FSCalendar) {
        updateLabelsToMatchCurrentDate(calendar.selectedDate)
    }

}