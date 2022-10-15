//
//  ViewController.swift
//  catchTheEagleGame
//
//  Created by Furkan Cemal Çalışkan on 1.08.2022.
//

import UIKit

class ViewController: UIViewController {
    
    //variables
    
    var score = 0
    var timer = Timer()
    var hideTimer = Timer()
    var counter = 0
    var eagleArray = [UIImageView]()
    var highScore = 0
    
    //Views
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var dejkoveci: UILabel!
    @IBOutlet weak var eagle1: UIImageView!
    @IBOutlet weak var eagle2: UIImageView!
    @IBOutlet weak var eagle3: UIImageView!
    @IBOutlet weak var eagle4: UIImageView!
    @IBOutlet weak var eagle5: UIImageView!
    @IBOutlet weak var eagle6: UIImageView!
    @IBOutlet weak var eagle7: UIImageView!
    @IBOutlet weak var eagle8: UIImageView!
    @IBOutlet weak var eagle9: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Score: \(score)"
        
        //Highscore Check
        
        let savedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if savedHighScore == nil {
            
            highScore = 0
            highScoreLabel.text = "Highscore: \(highScore)"
            
        }
        
        if let newScore = savedHighScore as? Int {
            
            highScore = newScore
            highScoreLabel.text = "Highscore: \(highScore)"
            
        }
        
        //Images
        
        eagle1.isUserInteractionEnabled = true
        eagle2.isUserInteractionEnabled = true
        eagle3.isUserInteractionEnabled = true
        eagle4.isUserInteractionEnabled = true
        eagle5.isUserInteractionEnabled = true
        eagle6.isUserInteractionEnabled = true
        eagle7.isUserInteractionEnabled = true
        eagle8.isUserInteractionEnabled = true
        eagle9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        eagle1.addGestureRecognizer(recognizer1)
        eagle2.addGestureRecognizer(recognizer2)
        eagle3.addGestureRecognizer(recognizer3)
        eagle4.addGestureRecognizer(recognizer4)
        eagle5.addGestureRecognizer(recognizer5)
        eagle6.addGestureRecognizer(recognizer6)
        eagle7.addGestureRecognizer(recognizer7)
        eagle8.addGestureRecognizer(recognizer8)
        eagle9.addGestureRecognizer(recognizer9)
        
        eagleArray = [eagle1,eagle2,eagle3,eagle4,eagle5,eagle6,eagle7,eagle8,eagle9]
        
        //Timers
        
        counter = 10
        timeLabel.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(hideEagles), userInfo: nil, repeats: true)
        
        hideEagles()
        
    }
    
    @objc func hideEagles(){
        
        for eagle in eagleArray {
            
            eagle.isHidden = true
            
        }
        
        let randomEagle = arc4random_uniform(UInt32(eagleArray.count - 1))
        eagleArray[Int(randomEagle)].isHidden = false
        
    }
    
    @objc func increaseScore(){
        
        score += 1
        scoreLabel.text = "Score: \(score)"
        
    }
    
    @objc func countDown(){
        
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            for eagle in eagleArray {
                
                eagle.isHidden = true
                
            }
            
            //High Score
            
            if self.score > self.highScore {
                self.highScore = self.score
                highScoreLabel.text = "Highscore: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            //dejkoAlert
            
            let dejkoAlert = UIAlertController(title: "Time's Up", message: "Again?", preferredStyle: UIAlertController.Style.alert)
            
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) {
                (UIAlertAction) in
                //replay func
                
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(self.hideEagles), userInfo: nil, repeats: true)
                
            }
            
            let okButton = UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: nil)
            
            
            dejkoAlert.addAction(replayButton)
            dejkoAlert.addAction(okButton)
            
            self.present(dejkoAlert, animated: true, completion: nil)
        }
        
        
        
    }
    
    

}

