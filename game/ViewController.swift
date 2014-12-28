//
//  ViewController.swift
//  game
//
//  Created by haoran zhang on 12/24/14.
//  Copyright (c) 2014 haoran zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    var myBoard: MutableBoard = MutableBoard(n: 6)
    
    var firstContainer: UIView!
    var secondContainer: UIView!
    var thirdContainer: UIView!
    var fourthContainer: UIView!
    
    var titleLabel:UILabel!
    var nextPlayer:UILabel!
    
    var restartButton: UIButton!
    
    var addBoardSizeButton: UIButton!
    var decreaseBoardSizeButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tests
        println(myBoard.size())
        println(myBoard.whoseMove().toString())
        myBoard.addSpot(Side.BLUE, r: 1, c: 1)
        println(myBoard.isLegal(Side.RED, r: 1, c: 1))
        myBoard.addSpot(Side.BLUE, r: 1, c: 1)
        println(myBoard.get(1, c: 2)._spots)
        myBoard.set(2, c: 2, num: 4, player: Side.RED)
        myBoard.addSpot(Side.RED, r: 2, c: 2)
        println(myBoard.get(1, c:2).getSpots())
        println(myBoard.get(1, c:2).getSide().toString())
        for var i = 0; i < 6; i++ {
            for var j = 0; j < 6; j++ {
                print(myBoard._board[i][j].getSpots())
            }
            println()
        }
        
        setUpContainer()
        setUpFirstContainer(firstContainer)
        setUpSecondContainer(secondContainer)
        setUpFourthContainer(fourthContainer)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpContainer() {
        firstContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x, y: self.view.bounds.origin.y, width: self.view.bounds.width, height: self.view.bounds.height/10.0))
        self.firstContainer.backgroundColor = UIColor(red: 70.0/255.0, green: 130.0/255.0, blue: 180.0/255.0, alpha: 1)
        self.view.addSubview(self.firstContainer)
        
        secondContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x, y: self.view.bounds.origin.y + firstContainer.frame.height, width: self.view.bounds.width, height: self.view.bounds.height/10))
        self.secondContainer.backgroundColor = UIColor(red: 192.0/255.0, green: 192.0/255.0, blue: 192.0/255.0, alpha: 1)
        self.view.addSubview(secondContainer)

        
        thirdContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x, y: self.view.bounds.origin.y + firstContainer.frame.height + secondContainer.frame.height, width: self.view.bounds.width, height: self.view.bounds.height*6/10))
        self.thirdContainer.backgroundColor = UIColor.whiteColor() //UIColor(red: 245.0/255.0, green: 255.0/255.0, blue: 250.0/255.0, alpha: 1)
        self.view.addSubview(thirdContainer)
        
        fourthContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x, y: self.view.bounds.origin.y + firstContainer.frame.height + secondContainer.frame.height + thirdContainer.frame.height, width: self.view.bounds.width, height: self.view.bounds.height*2/10))
        self.fourthContainer.backgroundColor = UIColor(red: 255.0/255.0, green: 245.0/255.0, blue: 238.0/255.0, alpha: 1)
        self.view.addSubview(fourthContainer)
    }

    
    func setUpFirstContainer(containerView: UIView) {
        titleLabel = UILabel()
        titleLabel.text = "Jump61"
        titleLabel.textColor = UIColor(red: 220.0/255.0, green: 220.0/255.0, blue: 220.0/255.0, alpha: 1)
        titleLabel.font = UIFont(name: "Noteworthy-Bold", size: 40)
        titleLabel.sizeToFit()
        titleLabel.center = containerView.center
        containerView.addSubview(titleLabel)
    }
    
    func setUpSecondContainer(containerView: UIView) {
        let playerToPlayTextLabel:UILabel = UILabel()
        playerToPlayTextLabel.text = "Current Player: "
        playerToPlayTextLabel.textColor = UIColor(red: 255.0/255.0, green: 245.0/255.0, blue: 238.0/255.0, alpha: 1)
        playerToPlayTextLabel.font = UIFont(name: "Noteworthy-Bold", size: 26)
        playerToPlayTextLabel.sizeToFit()
        playerToPlayTextLabel.center = CGPoint(x: containerView.frame.width * 8 / 20, y: containerView.frame.height / 2.0)
        containerView.addSubview(playerToPlayTextLabel)
        
        nextPlayer = UILabel(frame: CGRect(x: containerView.frame.width / 1.6, y: containerView.frame.height / 7.0, width: 40.0, height: 20.0))
        nextPlayer.text = "Red"
        nextPlayer.textColor = UIColor(red: 255.0/255.0, green: 99.0/255.0, blue: 71.0/255.0, alpha: 1)
        nextPlayer.font = UIFont(name: "Noteworthy-Bold", size: 26)
        nextPlayer.sizeToFit()
        nextPlayer.center = CGPoint(x: containerView.frame.width * 14 / 20, y: containerView.frame.height / 2.0)
        containerView.addSubview(nextPlayer)
    }

    
    func setUpFourthContainer(containerView: UIView) {
        restartButton = UIButton(frame: CGRect(x: 1 , y: 1, width: containerView.frame.width / 1.2, height: containerView.frame.height / 4.0))
        restartButton.setTitle("Restart Game", forState: UIControlState.Normal)
        restartButton.setTitleColor(UIColor(red: 176.0/255.0, green: 220.0/255.0, blue: 220.0/255.0, alpha: 1), forState: UIControlState.Highlighted)
        restartButton.titleLabel?.font = UIFont(name: "Noteworthy-Bold", size: 20)
        restartButton.backgroundColor = UIColor(red: 230.0/255.0, green: 230.0/255.0, blue: 250.0/255.0, alpha: 1)
        restartButton.center = CGPoint(x: containerView.frame.width/2.0, y: containerView.frame.height/4.0)
        restartButton.addTarget(self, action: "restartButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        restartButton.layer.masksToBounds = true
        restartButton.layer.cornerRadius = 15
        containerView.addSubview(restartButton)

        addBoardSizeButton = UIButton(frame: CGRect(x: 1 , y: 1, width: containerView.frame.width / 2.5, height: containerView.frame.height / 4.0))
        addBoardSizeButton.setTitle("Increase", forState: UIControlState.Normal)
        addBoardSizeButton.setTitleColor(UIColor(red: 176.0/255.0, green: 220.0/255.0, blue: 220.0/255.0, alpha: 1), forState: UIControlState.Highlighted)
        addBoardSizeButton.titleLabel?.font = UIFont(name: "Noteworthy-Bold", size: 20)
        addBoardSizeButton.backgroundColor = UIColor(red: 230.0/255.0, green: 230.0/255.0, blue: 250.0/255.0, alpha: 1)
        addBoardSizeButton.center = CGPoint(x: containerView.frame.width/2.0, y: containerView.frame.height/4.0)
        addBoardSizeButton.addTarget(self, action: "restartButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        addBoardSizeButton.layer.masksToBounds = true
        addBoardSizeButton.layer.cornerRadius = 15
        containerView.addSubview(addBoardSizeButton)

        
    }
    
    func restartButtonPressed(button: UIButton) {
        
    }
    
    
    func play() {
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

