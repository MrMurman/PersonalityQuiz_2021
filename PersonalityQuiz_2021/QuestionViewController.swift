//
//  QuestionViewController.swift
//  PersonalityQuiz_2021
//
//  Created by Андрей Бородкин on 28.06.2021.
//

import UIKit

class QuestionViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet var questionLabel: UILabel!
    
    @IBOutlet var singleStackView: UIStackView!
    @IBOutlet var singleButtonsArr: [UIButton]!
    
    
    @IBOutlet var multipleStackView: UIStackView!
    @IBOutlet var multiLabelArr: [UILabel]!
    @IBOutlet var multiSwitchArr: [UISwitch]!
    
    
    @IBOutlet var rangedStackView: UIStackView!
    @IBOutlet var rangedLabel1: UILabel!
    @IBOutlet var rangedLabel2: UILabel!
    
    
    @IBOutlet var questionProgressView: UIProgressView!
    
    @IBOutlet var rangedSlider: UISlider!
    
    
    // MARK: - Variables
    var questions: [Question] = Question.questions
    var questionIndex = 0
    var answersChosen: [Answer] = []
    
    // MARK: - Main Body
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    // MARK: - Actions
    @IBAction func singleAnswerBTNPressed(_ sender: UIButton) {
        
        let currentAnswers = questions[questionIndex].answers
        
        answersChosen.append(currentAnswers[sender.tag])
        

        nextQuestion()
    }
    
    @IBAction func multipleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        
        for index in 0..<multiSwitchArr.count {
            if multiSwitchArr[index].isOn{
                answersChosen.append(currentAnswers[index])
            }
        }
        
        nextQuestion()
        
    }
    
    
    @IBAction func rangedAnswerBTNPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count-1)))
        
        answersChosen.append(currentAnswers[index])
        
        nextQuestion()
        
    }
    
    // MARK: - UI methods
    func updateUI() {
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        navigationItem.title = "Question #\(questionIndex + 1)"
        
        let currentQuestion = questions[questionIndex]
        let currentAnswer = currentQuestion.answers
        let totalProgress = Float(questionIndex / questions.count)
        
        questionLabel.text = currentQuestion.text
        questionProgressView.setProgress(totalProgress, animated: true)
        
        switch currentQuestion.type {
        case .single:
            updateSingleStack(using: currentAnswer)
        case .multiple:
            updateMultiStack(using: currentAnswer)
        case .ranged:
            updateRangedStack(using: currentAnswer)
        }
    }
    
    func updateSingleStack(using answers: [Answer]) {
        singleStackView.isHidden = false
        
        for index in 0..<answers.count {
            singleButtonsArr[index].setTitle(answers[index].text, for: .normal)
        }
    }
    
    func updateMultiStack(using answers: [Answer]) {
        multipleStackView.isHidden = false
        
        for index in 0..<answers.count {
            multiLabelArr[index].text = answers[index].text
            multiSwitchArr[index].isOn = false
        }
    }
    
    func updateRangedStack(using answers: [Answer]) {
        rangedStackView.isHidden = false
        rangedSlider.setValue(0.5, animated: false)
        rangedLabel1.text = answers.first?.text
        rangedLabel2.text = answers.last?.text
    }
    
    // MARK: - Navigation
    func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "Results", sender: nil)
        }
    }
    
    @IBSegueAction func showResults(_ coder: NSCoder) -> ResultsViewController? {
        return ResultsViewController(coder: coder, responses: answersChosen)
    }
    
}
