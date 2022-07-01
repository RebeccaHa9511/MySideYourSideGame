//
//  ViewController.swift
//  MySideYourSide
//
//  Created by Rebecca Ha on 2022/06/27.
//

import UIKit
import AVFoundation
import SwiftUI
import Lottie


class ViewController: UIViewController {


    @IBOutlet weak var timerLbl: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var starAnimation: AnimationView!
    @IBOutlet weak var rightButtonAnimation: AnimationView!
    
    @IBOutlet weak var backgroundAnimation: AnimationView!
    
    @IBOutlet weak var scoreLbl: UILabel!
    @IBOutlet weak var leftImg1: UIImageView!
    @IBOutlet weak var leftImg2: UIImageView!
    @IBOutlet weak var rightImg1: UIImageView!
    @IBOutlet weak var rightImg2: UIImageView!
    
    @IBOutlet weak var midImg1: UIImageView!
    @IBOutlet weak var midImg2: UIImageView!
    @IBOutlet weak var midImg3: UIImageView!
    @IBOutlet weak var midImg4: UIImageView!
    @IBOutlet weak var midImg5: UIImageView!
    @IBOutlet weak var midImg6: UIImageView!
    @IBOutlet weak var midImg7: UIImageView!
    @IBOutlet weak var midImg8: UIImageView!
    
    // MARK: - 변수, 배열 생성
  
    var timer: Timer?
    var initialTime: Int = 60
    
    //ProgressView 설정
    var gameDuration = 60 //토탈 60초 설정
    var indexProgressBar = 0
    var currentGameIndex = 0
    
    //점수변수 생성
    var initialScore: Int = 0
    
    //이미지 배열화 시키기
    var imgArr: [UIImage] = [UIImage(named: "푸들.png")!, UIImage(named: "훈이.png")!, UIImage(named: "고양이.png")!, UIImage(named: "문어.png")!]
    var imgArr2: [UIImage]!


    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
        progressBar.progress = 0.0
        setProgressBar()
        configureUI()
        playbackgroundAnimation()
        MusicPlayer.shared.startBackgroundMusic()

        
    }



    // MARK: -  UI , Animation ,Background 설정
    func configureUI(){
        progressBar.clipsToBounds = true
        progressBar.layer.cornerRadius = 10
        progressBar.layer.borderWidth = 4
        progressBar.layer.borderColor = UIColor.black.cgColor
    }
    
    func playbackgroundAnimation(){
        backgroundAnimation.contentMode = .scaleAspectFill
        backgroundAnimation.clipsToBounds = true
        backgroundAnimation.play()
        backgroundAnimation.animationSpeed = 0.1
        backgroundAnimation.loopMode = .loop
        
    }
    
    
    func leftbuttonAnimation(){
        starAnimation.contentMode = .scaleAspectFill
        starAnimation.clipsToBounds = false
        starAnimation.play()
        starAnimation.animationSpeed = 2

    }
    
    func rightbuttonAnimation(){
        rightButtonAnimation.contentMode = .scaleAspectFill
        rightButtonAnimation.clipsToBounds = false
        rightButtonAnimation.play()
        rightButtonAnimation.animationSpeed = 2

    }
    

    // MARK: -  그림 일치하는가?
  
     func correct(_ direction: String){
        if direction == "left" {
            if (leftImg1.image?.pngData() == self.midImg1.image?.pngData()) || (leftImg2.image?.pngData() == self.midImg1.image?.pngData()) {
                initialScore += 50
                changemidImage()
                changeScore()
                
            } else {
                let scoreBoardVC = self.storyboard?.instantiateViewController(withIdentifier: "ScoreBoardViewController") as! ScoreBoardViewController
                scoreBoardVC.scoretxt = "\(String(initialScore))"
                scoreBoardVC.modalPresentationStyle = .fullScreen
                scoreBoardVC.modalTransitionStyle = .coverVertical
                self.present(scoreBoardVC, animated: true, completion: nil)
                
            }
            
        } else if direction == "right" {
            if (rightImg1.image?.pngData() == self.midImg1.image?.pngData()) ||
                (rightImg2.image?.pngData() == self.midImg1.image?.pngData()) {
                initialScore += 50
                changemidImage()
                changeScore()
            } else {
                let scoreBoardVC = self.storyboard?.instantiateViewController(withIdentifier: "ScoreBoardViewController") as! ScoreBoardViewController
                scoreBoardVC.scoretxt = "\(String(initialScore))"
                scoreBoardVC.modalPresentationStyle = .fullScreen
                scoreBoardVC.modalTransitionStyle = .coverVertical
                self.present(scoreBoardVC, animated: true, completion: nil)
                
            }
        } }
        
    // MARK: - 버튼 누름과 동시에 가운데 이미지 변경
        func changemidImage(){
            DispatchQueue.global(qos: .userInitiated).async {
                DispatchQueue.main.async {
                    self.midImg1.image = self.midImg2.image
                    self.midImg2.image = self.midImg3.image
                    self.midImg3.image = self.midImg4.image
                    self.midImg4.image = self.midImg5.image
                    self.midImg5.image = self.midImg6.image
                    self.midImg6.image = self.midImg7.image
                    self.midImg7.image = self.midImg8.image
                    self.midImg8.image = self.imgArr.randomElement()
                }
            }
        }
    
        
    // MARK: - 맞으면 score 올려줌
       
        func changeScore(){
            DispatchQueue.global(qos: .userInitiated).async {
                DispatchQueue.main.async {
                    self.scoreLbl.text = "\(self.initialScore)"
                }
            }
        }
        
        // MARK: - 시간제한
        @objc func countdown(){
            if initialTime != 0 {
                startProgressBar()
                setProgressBar()
                let counter = String(format: "%02d", initialTime)
                timerLbl.text = "\(counter)"
                initialTime -= 1
            } else{
                let scoreBoardVC = self.storyboard?.instantiateViewController(withIdentifier: "ScoreBoardViewController") as! ScoreBoardViewController
                scoreBoardVC.scoretxt = "\(String(initialScore))"
                scoreBoardVC.modalPresentationStyle = .fullScreen
                scoreBoardVC.modalTransitionStyle = .coverVertical
                self.present(scoreBoardVC, animated: true, completion: nil)
            }
            
        }
    
    //ProgressBar 설정
    func startProgressBar() {
        currentGameIndex += 1
        print(currentGameIndex)
        }
    
    func setProgressBar(){
        if indexProgressBar == gameDuration
                {
                    startProgressBar()

                    // reset the progress counter
                    indexProgressBar = 0
                }
        progressBar.progress = Float(indexProgressBar) / Float(gameDuration - 1)
        indexProgressBar += 1
    }
    

        
        // MARK: - 버튼

    @IBAction func leftButtonTapped(_ sender: UIButton) {
        correct("left")
        leftbuttonAnimation()

}
//        MusicPlayer.shared.playSoundEffect(soundEffect: "collectcoin-6075")
    
    
    @IBAction func rightButtonTapped(_ sender: UIButton) {
        correct("right")
        rightbuttonAnimation()
//        MusicPlayer.shared.playSoundEffect(soundEffect: "collectcoin-6075")
    }
    



    

}
