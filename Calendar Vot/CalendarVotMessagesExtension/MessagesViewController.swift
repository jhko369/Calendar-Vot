//
//  MessagesViewController.swift
//  CalendarVotMessagesExtension
//
//  Created by owner on 2016. 12. 1..
//  Copyright © 2016년 Neobono_Mac1. All rights reserved.
//

import UIKit
import Messages

class MessagesViewController: MSMessagesAppViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Conversation Handling
    
    override func willBecomeActive(with conversation: MSConversation) {
        super.willBecomeActive(with: conversation)
        
    
    }
    
    private func presentViewController(for conversation: MSConversation, with presentationStyle: MSMessagesAppPresentationStyle) {
        // Determine the controller to present.
        let controller: UIViewController
        if presentationStyle == .compact {
            // 투표 만들기, 투표 히스토리 보여주는 뷰
            controller = instantiateStartViewController()
        }
        else {
            
        //    let voteData = Vote(message: conversation.selectedMessage) ?? Vote()
            let voteData:Vote = Vote()
            if voteData.finishTime > Date.init()
            {
                controller = instantiateVoteViewController(with: voteData)
            }
            else {
               // controller = (투표 종료 후 나오는 뷰를 만들지 VoteView에서 설정할지 고민중)
            }
        }
        
        // Remove any existing child controllers.
        for child in childViewControllers {
            child.willMove(toParentViewController: nil)
            child.view.removeFromSuperview()
            child.removeFromParentViewController()
        }
        
        // Embed the new controller.
        addChildViewController(controller)
        
        controller.view.frame = view.bounds
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(controller.view)
        
        controller.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        controller.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        controller.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        controller.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        controller.didMove(toParentViewController: self)
    }

    
    private func instantiateStartViewController() -> UIViewController {
        //StartView 생성
        guard let controller = storyboard?.instantiateViewController(withIdentifier: StartViewController.storyboardIdentifier) as? StartViewController else { fatalError("Start view 생성 실패") }

        return controller
    }

    private func instantiateAddViewController() -> UIViewController {
        //AddView 생성
        guard let controller = storyboard?.instantiateViewController(withIdentifier: AddViewController.storyboardIdentifier) as? AddViewController else { fatalError("Add view 생성 실패") }
        
        return controller
    }

    private func instantiateVoteViewController(with vote:Vote) -> UIViewController {
        //VoteView 생성
        guard let controller = storyboard?.instantiateViewController(withIdentifier: VoteViewController.storyboardIdentifier) as? VoteViewController else { fatalError("Vote view 생성 실패") }
        
        controller.voteData = vote
        
        return controller
    }
    
    
    override func didResignActive(with conversation: MSConversation) {
        // Called when the extension is about to move from the active to inactive state.
        // This will happen when the user dissmises the extension, changes to a different
        // conversation or quits Messages.
        
        // Use this method to release shared resources, save user data, invalidate timers,
        // and store enough state information to restore your extension to its current state
        // in case it is terminated later.
    }
   
    override func didReceive(_ message: MSMessage, conversation: MSConversation) {
        // Called when a message arrives that was generated by another instance of this
        // extension on a remote device.
        
        // Use this method to trigger UI updates in response to the message.
    }
    
    override func didStartSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user taps the send button.
    }
    
    override func didCancelSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user deletes the message without sending it.
    
        // Use this to clean up state related to the deleted message.
    }
    
    override func willTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        // Called before the extension transitions to a new presentation style.
    
        // Use this method to prepare for the change in presentation style.
    }
    
    override func didTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        // Called after the extension transitions to a new presentation style.
    
        // Use this method to finalize any behaviors associated with the change in presentation style.
    }
    

}
