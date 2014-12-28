//
//  ViewController.swift
//  game
//
//  Created by haoran zhang on 12/24/14.
//  Copyright (c) 2014 haoran zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var firstContainer: UIView!
    var secondContainer: UIView!
    var thirdContainer: UIView!
    var fourthContainer: UIView!
    
    var titleLabel:UILabel!
    var nextPlayer:UILabel!
    
    var restartButton: UIButton!

    var boardSizeLabel:UILabel!

    var addBoardSizeButton: UIButton!
    var decreaseBoardSizeButton: UIButton!
    
    var myBoard:MutableBoard = MutableBoard(n: 6)
    
    var myTapRec:UITapGestureRecognizer!
    
    var currentPlayer:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpContainer()
        setUpFirstContainer(firstContainer)
        setUpSecondContainer(secondContainer)
        setUpThirdContainer(thirdContainer)
        setUpFourthContainer(fourthContainer)
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

        thirdContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x, y: self.view.bounds.origin.y + firstContainer.frame.height + secondContainer.frame.height, width: self.view.bounds.width, height: self.view.bounds.height*5.6/10))
        self.thirdContainer.backgroundColor = UIColor(red: 255.0/255.0, green: 204.0/255.0, blue: 229.0/255.0, alpha: 1)
        self.view.addSubview(thirdContainer)
        
        fourthContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x, y: self.view.bounds.origin.y + firstContainer.frame.height + secondContainer.frame.height + thirdContainer.frame.height, width: self.view.bounds.width, height: self.view.bounds.height*2.4/10))

        thirdContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x, y: self.view.bounds.origin.y + firstContainer.frame.height + secondContainer.frame.height, width: self.view.bounds.width, height: self.view.bounds.height*5.6/10))
        self.thirdContainer.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(thirdContainer)
        myTapRec = UITapGestureRecognizer()
        myTapRec.addTarget(self, action: "tappedView")
        thirdContainer.addGestureRecognizer(myTapRec)
        thirdContainer.userInteractionEnabled = true
        
        
        fourthContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x, y: self.view.bounds.origin.y + firstContainer.frame.height + secondContainer.frame.height + thirdContainer.frame.height, width: self.view.bounds.width, height: self.view.bounds.height*2.4/10))

        self.fourthContainer.backgroundColor = UIColor(red: 255.0/255.0, green: 245.0/255.0, blue: 238.0/255.0, alpha: 1)
        self.view.addSubview(fourthContainer)
    }

    func tappedView() {
        var r:Int = Int(myTapRec.locationInView(thirdContainer).x/thirdContainer.bounds.width*CGFloat(myBoard.size())) + 1
        var c:Int = Int(myTapRec.locationInView(thirdContainer).y/thirdContainer.bounds.height*CGFloat(myBoard.size())) + 1
        
        if currentPlayer == 0 && myBoard.isLegal(Side.RED, r: r, c: c){
            myBoard.addSpot(Side.RED, r: r, c: c)
            nextPlayer.text = "Blue"
            nextPlayer.textColor = UIColor(red: 51.0/255.0, green: 153.0/255.0, blue: 255.0/255.0, alpha: 1)
            nextPlayer.sizeToFit()
            currentPlayer = 1
            updateBoard()
        } else if currentPlayer == 1 && myBoard.isLegal(Side.BLUE, r: r, c: c){
            myBoard.addSpot(Side.BLUE, r: r, c: c)
            nextPlayer.text = "Red"
            nextPlayer.sizeToFit()
            nextPlayer.textColor = UIColor(red: 255.0/255.0, green: 99.0/255.0, blue: 71.0/255.0, alpha: 1)
            currentPlayer = 0
            updateBoard()
        } else {
            showAlertWithText(message: "Invalid Move!")
        }
        if myBoard.getWinner() != nil {
            if myBoard.getWinner() == Side.BLUE {
                showAlertWithText(header: "congratulations", message: "Blue Won!")
            } else {
                showAlertWithText(header: "congratulations", message: "Red Won!")
            }
        }
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
        
        nextPlayer = UILabel(frame: CGRect(x: containerView.frame.width / 1.6, y: containerView.frame.height / 7.0, width: 100.0, height: 20.0))
        nextPlayer.text = "Red"
        nextPlayer.textColor = UIColor(red: 255.0/255.0, green: 99.0/255.0, blue: 71.0/255.0, alpha: 1)
        nextPlayer.font = UIFont(name: "Noteworthy-Bold", size: 26)
        nextPlayer.sizeToFit()
        nextPlayer.center = CGPoint(x: containerView.frame.width * 14 / 20, y: containerView.frame.height / 2.0)
        containerView.addSubview(nextPlayer)
    }

    
    func setUpThirdContainer(containerView: UIView) {
        for var x = 0; x < myBoard.size(); x += 1{
            for var y = 0; y < myBoard.size(); y += 1 {
                var slotImageView = UIImageView()
                slotImageView.image = UIImage(named: "Empty")
                slotImageView.frame = CGRect(x: CGFloat(x)*containerView.bounds.width/CGFloat(myBoard.size()), y: CGFloat(y)*containerView.bounds.width/CGFloat(myBoard.size()), width: containerView.bounds.width/CGFloat(myBoard.size()), height: containerView.bounds.height/CGFloat(myBoard.size()))
                containerView.addSubview(slotImageView)
            }
        }
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

        addBoardSizeButton = UIButton(frame: CGRect(x: 1 , y: 1, width: containerView.frame.width / 3.1, height: containerView.frame.height / 4.0))

        addBoardSizeButton.setTitle("Increase", forState: UIControlState.Normal)
        addBoardSizeButton.setTitleColor(UIColor(red: 176.0/255.0, green: 220.0/255.0, blue: 220.0/255.0, alpha: 1), forState: UIControlState.Highlighted)
        addBoardSizeButton.titleLabel?.font = UIFont(name: "Noteworthy-Bold", size: 20)
        addBoardSizeButton.backgroundColor = UIColor(red: 230.0/255.0, green: 230.0/255.0, blue: 250.0/255.0, alpha: 1)

        addBoardSizeButton.center = CGPoint(x: containerView.frame.width/1.34, y: containerView.frame.height/1.4)
        addBoardSizeButton.addTarget(self, action: "increaseBoardSizeButtonPress:", forControlEvents: UIControlEvents.TouchUpInside)
        addBoardSizeButton.layer.masksToBounds = true
        addBoardSizeButton.layer.cornerRadius = 15
        containerView.addSubview(addBoardSizeButton)

        decreaseBoardSizeButton = UIButton(frame: CGRect(x: 1 , y: 1, width: containerView.frame.width / 3.1, height: containerView.frame.height / 4.0))
        decreaseBoardSizeButton.setTitle("Decrease", forState: UIControlState.Normal)
        decreaseBoardSizeButton.setTitleColor(UIColor(red: 176.0/255.0, green: 220.0/255.0, blue: 220.0/255.0, alpha: 1), forState: UIControlState.Highlighted)
        decreaseBoardSizeButton.titleLabel?.font = UIFont(name: "Noteworthy-Bold", size: 20)
        decreaseBoardSizeButton.backgroundColor = UIColor(red: 230.0/255.0, green: 230.0/255.0, blue: 250.0/255.0, alpha: 1)
        decreaseBoardSizeButton.center = CGPoint(x: containerView.frame.width/4, y: containerView.frame.height/1.4)
        decreaseBoardSizeButton.addTarget(self, action: "decreaseBoardSizeButtonPress:", forControlEvents: UIControlEvents.TouchUpInside)
        decreaseBoardSizeButton.layer.masksToBounds = true
        decreaseBoardSizeButton.layer.cornerRadius = 15
        containerView.addSubview(decreaseBoardSizeButton)
        
        boardSizeLabel = UILabel(frame: CGRect(x: 1 , y: 1, width: containerView.frame.width / 2.5, height: containerView.frame.height / 4.0))
        boardSizeLabel.text = "\(6)"
        boardSizeLabel.textColor = UIColor(red: 255.0/255.0, green: 182.0/255.0, blue: 193.0/255.0, alpha: 1)
        boardSizeLabel.font = UIFont(name: "Noteworthy-Bold", size: 23)
        boardSizeLabel.sizeToFit()
        boardSizeLabel.center = CGPoint(x: containerView.frame.width/2, y: containerView.frame.height/1.4)
        containerView.addSubview(boardSizeLabel)
    }
    
    func restartButtonPressed(button: UIButton) {
        myBoard = MutableBoard(n: boardSizeLabel.text!.toInt()!)
        currentPlayer = 0
        nextPlayer.textColor = UIColor(red: 255.0/255.0, green: 99.0/255.0, blue: 71.0/255.0, alpha: 1)
        nextPlayer.text = "Red"
        setUpThirdContainer(thirdContainer)
    }
    
    func increaseBoardSizeButtonPress(button: UIButton) {
        boardSizeLabel.text = "\(boardSizeLabel.text!.toInt()! + 1)"
        if boardSizeLabel.text!.toInt()! > 6 {
            boardSizeLabel.text = "\(6)"
        }
        boardSizeLabel.sizeToFit()
    }
    
    func decreaseBoardSizeButtonPress(button: UIButton) {
        boardSizeLabel.text = "\(boardSizeLabel.text!.toInt()! - 1)"
        if boardSizeLabel.text!.toInt()! < 2 {
            boardSizeLabel.text = "\(2)"
        }
    }
    
    func updateBoard() {
        for var x:Int = 0; x < myBoard.size(); x += 1{
            for var y:Int = 0; y < myBoard.size(); y += 1 {
                var slotImageView = UIImageView()
                var value:Int = myBoard.get(x+1, c: y+1)._spots!
                var side:String = myBoard.get(x+1, c: y+1)._side!.toString()
                switch value {
                case 1 :
                    switch side {
                        
                    case "White":
                        slotImageView.image = UIImage(named: "Empty")
                    case "Blue":
                        slotImageView.image = UIImage(named: "Blue1")
                    case "Red":
                        slotImageView.image = UIImage(named: "Red1")
                    default:
                        println("error1")
                    }
                case 2 :
                    switch side {
                    case "Red":
                        slotImageView.image = UIImage(named: "Red2")
                    case "Blue":
                        slotImageView.image = UIImage(named: "Blue2")
                    default:println("error2")
                    }
                case 3 :
                    switch side {
                    case "Red":
                        slotImageView.image = UIImage(named: "Red3")
                    case "Blue":
                        slotImageView.image = UIImage(named: "Blue3")
                    default:println("error3")
                    }
                case 4 :
                    switch side {
                    case "Red":
                        slotImageView.image = UIImage(named: "Red4")
                    case "Blue":
                        slotImageView.image = UIImage(named: "Blue4")
                    default:println("error4")
                    }
                default:
                    println("error5")
                    }
                slotImageView.frame = CGRect(x: CGFloat(x)*thirdContainer.bounds.width/CGFloat(myBoard.size()), y: CGFloat(y)*thirdContainer.bounds.width/CGFloat(myBoard.size()), width: thirdContainer.bounds.width/CGFloat(myBoard.size()), height: thirdContainer.bounds.height/CGFloat(myBoard.size()))
                thirdContainer.addSubview(slotImageView)
            }
        }
    }
    
    func showAlertWithText(header: String = "Warnign", message: String) {
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}


