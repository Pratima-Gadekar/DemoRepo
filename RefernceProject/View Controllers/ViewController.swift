//
//  ViewController.swift
//  CourseProject
//
//  Created by Arun Patwardhan on 02/03/19.
//  Copyright © 2019 Amaranthine. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.ageSelector.backgroundColor = UIColor.orange
    }
    
    //Variables --------------------------------------------------
    var dataModelHandle : DataModelController = DataModelController.createModelController()
    
    //IBOutlets --------------------------------------------------
    //Textfields
    @IBOutlet var dataFields: [UITextField]!
    
    //Age
    @IBOutlet weak var ageSlider: UISlider!
    @IBOutlet weak var ageDisplay: UILabel!
    @IBOutlet weak var ageSelector: UIDatePicker!
    
    //Ratings
    @IBOutlet var ratings: [UISegmentedControl]!
    
    //IBActions --------------------------------------------------
    //Age
    @IBAction func ageSliderMoved(_ sender: UISlider, forEvent event: UIEvent)
    {
        ageDisplay.text = "\(Int(sender.value))"
        
        ageSelector.setDate(Date(timeIntervalSinceNow: -TimeInterval(sender.value * 365.0 * 24.0 * 60.0 * 60.0)), animated: true)
    }
    
    @IBAction func dateChanged(_ sender: UIDatePicker)
    {
        let difference  = (((sender.date.timeIntervalSinceNow / 60.0) / 60.0) / 24.0) / 365.0
        print(difference)
        
        ageDisplay.text = "\(Int(-difference))"
        ageSlider.value = Float(-difference)
    }
    
    //Toolbar
    @IBAction func addToCache(_ sender: UIBarButtonItem)
    {
        if check_for_empty_fields()
        {
            let newRating : RatingInfo = RatingInfo(foodRating: RatingScore.generate(withNumber: Int16(ratings[0].selectedSegmentIndex)) , ambienceRating: RatingScore.generate(withNumber: Int16(ratings[1].selectedSegmentIndex)), serviceRating: RatingScore.generate(withNumber: Int16(ratings[2].selectedSegmentIndex)))
            
            let newSurvey : SurveyModel = SurveyModel(name: dataFields[0].text!, dateOfBirth: ageSelector.date, email: dataFields[2].text!, phone: dataFields[1].text!, ratings: newRating,  dateOfSurvey: Date(timeIntervalSinceNow: 0))
            
            dataModelHandle.cache(Survey: newSurvey)
            self.clearScreen()
        }
    }
    
    @IBAction func commitToDB(_ sender: UIBarButtonItem)
    {
        dataModelHandle.put()
        self.clearScreen()
    }
    
    @IBAction func cancelSurvey(_ sender: UIBarButtonItem)
    {
        self.clearScreen()
    }
    
    @IBAction func viewSurveys(_ sender: UIBarButtonItem)
    {
        self.clearScreen()
    }
    
    func check_for_empty_fields() -> Bool
    {
        guard !(dataFields[0].text?.isEmpty)!
            else
        {
            let alert : UIAlertController = UIAlertController(title: "Empty Field", message: "Name field cannot be empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: {[unowned self](act : UIAlertAction) in
                self.dataFields[0].becomeFirstResponder()
            }))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        guard !(dataFields[1].text?.isEmpty)!
        else
        {
            let alert : UIAlertController = UIAlertController(title: "Empty Field", message: "Cell Phone field cannot be empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: {[unowned self](act : UIAlertAction) in
                self.dataFields[1].becomeFirstResponder()
            }))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        guard !(dataFields[2].text?.isEmpty)!
            else
        {
            let alert : UIAlertController = UIAlertController(title: "Empty Field", message: "Email field cannot be empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: {[unowned self](act : UIAlertAction) in
                self.dataFields[2].becomeFirstResponder()
            }))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        return true
    }
    
    func clearScreen()
    {
        //Reset everything back to default values
        dataFields[0].text = ""
        dataFields[1].text = ""
        dataFields[2].text = ""
        
        ageSlider.value = 18.0
        
        ageSelector.date = Date(timeIntervalSince1970: 0)
        
        ageDisplay.text = "18"
        
        ratings[0].selectedSegmentIndex = 0
        ratings[1].selectedSegmentIndex = 0
        ratings[2].selectedSegmentIndex = 0
    }
    
}

