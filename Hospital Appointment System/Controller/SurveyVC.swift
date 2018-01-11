//
//  SurveyVC.swift
//  Hospital Appointment System
//
//  Created by admin on 09/01/2018.
//  Copyright © 2018 MuhammadAamir. All rights reserved.
//

import UIKit
import UICircularProgressRing

class SurveyVC: UIViewController ,UITableViewDataSource, UITableViewDelegate, UICircularProgressRingDelegate{
    func finishedUpdatingProgress(forRing ring: UICircularProgressRingView) {
        
    }
    

    @IBOutlet weak var ServeyPersentage: UICircularProgressRingView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var QuestionLable: UILabel!
    
    
    var questionArray :[(Question: String, Answer: [String], TypeQuestion: Bool)] = []
    var selectedCells:[(Question: String, Answer: [String])] = []
    var indexArray = Int()
    var totalCount = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        indexArray = 0
        
        ServeyPersentage.maxValue = 100
        ServeyPersentage.value = 0
        ServeyPersentage.font = UIFont.systemFont(ofSize: 50)
       
        questionArray.append((Question: """
        Who is completing this survey?
        """, Answer: ["Patient","Spouse or Partner","Adult child of the patient","Family member or relative","Friend","Paid caretaker","Staff","Other"], TypeQuestion: true))
        questionArray.append((Question: """
NCCN Distress Thermometer
Distress is an unpleasant emotional state that effects everyone with an illness with some time.It includes many feelings like sadness, worry, anger, helplessness and guilt. Distress can effect how you feel, think and act.
How distressed are you feeling today? Select the number that describes your level of distress from 0 being the lowest and 10 being the highest distress you can imagine.
""", Answer: ["1","2","3","4","5","6","7","8","9","10"], TypeQuestion: true))
        questionArray.append((Question: """
        Select any one the following that have been a problem for you in the past week, including today
        Practical concerns: (select all that apply)
""", Answer: ["Child care","Housing/Lodging","Insurance or billing issues","Financial / Cost of my care","Transportation","Treatment Decision","Work / Employment","None"], TypeQuestion: false))
        tableView.dataSource = self
        tableView.delegate = self
     totalCount = questionArray.count
        ServeyPersentage.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func divide(lhs: Int, rhs: Int) -> Double {
        return Double(lhs) / Double(rhs)
    }
    @IBAction func NextAction(_ sender: Any) {
        if indexArray < questionArray.count - 1 {
            indexArray = indexArray + 1
            print(indexArray)
            print(totalCount)
            print(Double(1/3))
            let roundValue = divide(lhs: indexArray, rhs: totalCount)*100
            self.ServeyPersentage.setProgress(value: CGFloat(roundValue), animationDuration: 2.0){
                
            }
            
            
            tableView.reloadData()
        }else {return}
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Answers", for: indexPath) as! QuestionAnswerTVC
//        cell.AnswerLabel.text = questionArray.Ans[indexPath.row]
        
        self.QuestionLable.text = questionArray[indexArray].Question
        cell.AnswerLabel.text = questionArray[indexArray].Answer[indexPath.row]
        cell.accessoryType = .none
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionArray[indexArray].Answer.count
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
        if questionArray[indexArray].TypeQuestion != true{
            //Multiple Selection Work Here...
//            var arr = []
        }else{
            //Single Selection Work...
        }
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
    }
//    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        let deselectedRow = tableView.cellForRow(at: indexPath)
//        if(selectedCells[indexArray].Ans.contains(deselectedRow!)){
//            let indx = selectedCells.index(of: deselectedRow!)
//            selectedCells.remove(at: indx!)
//        }
//    }
}
