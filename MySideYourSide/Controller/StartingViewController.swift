//
//  StartingViewController.swift
//  MySideYourSide
//
//  Created by Rebecca Ha on 2022/06/27.
//

import UIKit
import Lottie
import AVFoundation

class StartingViewController: UIViewController {


 
    @IBOutlet weak var startingButton: UIButton!
    @IBOutlet weak var tumbleWeedBackground: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animatedEffects()
      
        MusicPlayer.shared.startBackgroundMusic3()

        startingButton.clipsToBounds = true
        startingButton.layer.cornerRadius = 20

    }

    
    func animatedEffects(){
        tumbleWeedBackground.contentMode = .scaleAspectFill
        tumbleWeedBackground.clipsToBounds = false
        tumbleWeedBackground.play()
        tumbleWeedBackground.animationSpeed = 1
        tumbleWeedBackground.loopMode = .loop

    }
    
    func animatedButton(){
        UIButton.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {self.startingButton.transform = CGAffineTransform(scaleX: -1, y:1)}, completion: nil)
    }

    
    override func viewWillAppear(_ animated: Bool) {
            self.navigationController?.setNavigationBarHidden(true, animated: animated)
        }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    @IBAction func startButtonTapped(_ sender: UIButton) {
        
        animatedButton()
        MusicPlayer.shared.playSoundEffect(soundEffect: "collectcoin-6075")
        let mainVC = (self.storyboard?.instantiateViewController(withIdentifier: "ViewController"))! as! ViewController
        mainVC.modalPresentationStyle = .fullScreen
        mainVC.modalTransitionStyle = .coverVertical
        self.present(mainVC, animated: true, completion: nil)
        
    }
    

    
    
}
