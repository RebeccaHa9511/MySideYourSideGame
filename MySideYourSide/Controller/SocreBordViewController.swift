//
//  SocreBordViewController.swift
//  MySideYourSide
//
//  Created by Rebecca Ha on 2022/06/27.
//


import UIKit
import Lottie


class ScoreBoardViewController: UIViewController {

    @IBOutlet weak var winnerStar: AnimationView!
    @IBOutlet weak var finalScorelbl: UILabel!
    var scoretxt: String = ""
    
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var restartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAnimation()
        configureUI()
        MusicPlayer.shared.startBackgroundMusic4() 
    }
    
    
    // MARK: - UI 꾸미기
    func configureUI() {
        restartButton.clipsToBounds = true
        restartButton.layer.cornerRadius = 20
        
        exitButton.clipsToBounds = true
        exitButton.layer.cornerRadius = 20
        
        finalScorelbl.text = scoretxt
    }
    
    func configureAnimation(){
        
        winnerStar.contentMode = .scaleAspectFill
        winnerStar.loopMode = .loop
        winnerStar.animationSpeed = 1
        winnerStar.play()
    }

    
// MARK: -     RESTART 버튼 누르면 이전화면으로 ! 게임 다시 시작
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        
        UIButton.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {self.restartButton.transform = CGAffineTransform(scaleX: -1, y:1)}, completion: nil)
        
        let toMainVC = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        toMainVC.modalPresentationStyle = .fullScreen
        toMainVC.modalTransitionStyle = .coverVertical
        self.present(toMainVC, animated: true, completion: nil)
        MusicPlayer.shared.playSoundEffect(soundEffect: "collectcoin-6075")
        
    }
    
    @IBAction func exitButtonTapped(_ sender: UIButton) {
        UIButton.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {self.exitButton.transform = CGAffineTransform(scaleX: -1, y:1)}, completion: nil)
        
        let toStartVC = self.storyboard?.instantiateViewController(withIdentifier: "StartingViewController") as! StartingViewController
        toStartVC.modalPresentationStyle = .fullScreen
        toStartVC.modalTransitionStyle = .coverVertical
        self.present(toStartVC, animated: true, completion: nil)
        MusicPlayer.shared.playSoundEffect(soundEffect: "collectcoin-6075")
        
    }
    

}
