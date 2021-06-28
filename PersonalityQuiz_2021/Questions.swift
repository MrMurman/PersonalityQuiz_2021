//
//  Questions.swift
//  PersonalityQuiz_2021
//
//  Created by Андрей Бородкин on 28.06.2021.
//

import Foundation

struct Question {
    var text: String
    var type: ResponseType
    var answers: [Answer]
    
    enum ResponseType {
        case single, multiple, ranged
    }
    
    
    static var questions: [Question] = [
        Question(text: "Which food do you like the most?", type: .single, answers: [
                    Answer(text: "Steak", type: .dogo),
                    Answer(text: "Fish", type: .neko),
                    Answer(text: "Carrots", type: .rabbit),
                    Answer(text: "Salad", type: .turtle)
            ]
        ),
        
        Question(text: "Which activities do you enjoy?", type: .multiple, answers: [
                    Answer(text: "Teaching kung-fu", type: .turtle),
                    Answer(text: "Sleeping", type: .neko),
                    Answer(text: "Destroying worlds", type: .rabbit),
                    Answer(text: "Eating", type: .dogo)
            ]
        ),
        
        Question(text: "How much to you enjoy car ride?", type: .ranged, answers: [
                    Answer(text: "I dislike them", type: .neko),
                    Answer(text: "I get a little nervous", type: .rabbit),
                    Answer(text: "I love them", type: .dogo),
                    Answer(text: "Why would I need a car? I am faster", type: .rabbit)
            ]
        )
    ]
}

struct Answer {
    var text: String
    var type: AnimalType
    
    enum AnimalType: Character {
        case dogo = "🐕", neko = "🐈", rabbit = "🐇", turtle = "🐢"
      
        
        var definition: String {
            switch self {
            case .dogo:
                return "You are incredibly outgoing. You surround yourself with the people you love and enjoy activities with your friends."
            case .neko:
                return "Mischievous, yet mild-tempered, you enjoy doing things on your own terms."
            case .rabbit:
                return "You love everything that's soft. You are healthy and full of energy."
            case .turtle:
                return "You are wise beyond your years, and you focus on the details. Slow and steady wins the race"
            }
        }
    
    
    }
}
