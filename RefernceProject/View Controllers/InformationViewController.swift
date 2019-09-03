//
//  InformationViewController.swift
//  CourseProject
//
//  Created by Arun Patwardhan on 02/03/19.
//  Copyright © 2019 Amaranthine. All rights reserved.
//

import UIKit
import MessageUI
class InformationViewController: UIViewController, MFMailComposeViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //Variables --------------------------------------------------
    var data : SurveyModel?
    override func viewWillAppear(_ animated: Bool) {
        responseInfo[0].text = data?.name
        responseInfo[1].text = data?.email
        responseInfo[3].text = "\((data?.ratings.foodRating)!)"
        responseInfo[4].text = "\((data?.ratings.ambienceRating)!)"
        responseInfo[5].text = "\((data?.ratings.serviceRating)!)"
        
        let thisbethevariable = "let theis be the varailble bjdkd"
        
        let dateFormatter       = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        responseInfo[2].text = dateFormatter.string(from: (data?.dateOfBirth)!)
        responseInfo[6].text = dateFormatter.string(from: (data?.dateOfSurvey)!)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func sendDetails(_ sender: UIBarButtonItem)
    {
        if MFMailComposeViewController.canSendMail()
        {
            let vc : MFMailComposeViewController = MFMailComposeViewController()
            
            vc.setToRecipients(["arun@amaranthine.co.in"])
            vc.setSubject("Response dated: \((data?.dateOfSurvey)!)")
            
            vc.setMessageBody("""
                Person Details -----
                Name: \(data?.name ?? "...")
                Age: \(data?.dateOfBirth ?? Date())
                Email :\(data?.email ?? "...")
                Birthday :\(data?.dateOfBirth ?? Date())
                Cellphone: \(data?.phone ?? "...")
                
                Ratings
                Food :\((data?.ratings.foodRating) ?? RatingScore.Average)
                Ambience :\((data?.ratings.ambienceRating)!)
                Service :\((data?.ratings.serviceRating)!)

""", isHTML: false)
        }
        else
        {
            let alert : UIAlertController = UIAlertController(title: "Cannot Send Mail", message: "Please configure Mail on your Mail app.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    @IBOutlet var responseInfo: [UILabel]!
    
}
