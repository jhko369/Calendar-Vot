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
        presentViewController(for: conversation, with: presentationStyle)
    }
    
    override func willTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        guard let conversation = activeConversation else { fatalError("Expected an active converstation") }
        presentViewController(for: conversation, with: presentationStyle)

    }
    
    private func presentViewController(for conversation: MSConversation, with presentationStyle: MSMessagesAppPresentationStyle) {
        // Determine the controller to present.
        let controller: UIViewController
        if presentationStyle == .compact {
            // 투표 만들기, 투표 히스토리 보여주는 뷰
           
            controller = instantiateStartViewController()
        }
        else {
       
            let voteData = Vote(message: conversation.selectedMessage) ?? Vote()

            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ko_kr")
            dateFormatter.dateFormat = "yyyy.MM.dd(E) a hh:mm"
    
            if (voteData.created.isCreated == "true")
            {
                print("created")
                print(voteData.isFinished())
                if(voteData.isFinished() != true)
                {controller = instantiateVoteViewController(with: voteData)}
                else
                { controller = instantiateResultViewController(with: voteData)
                //투표 종료 후 뷰로 바꿔야함.
                }
            }
            else
            {
                print("creating")

                controller = instantiateAddViewController()
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
        print("StartView 생성")
        guard let controller = storyboard?.instantiateViewController(withIdentifier: StartViewController.storyboardIdentifier) as? StartViewController else { fatalError("Start view 생성 실패") }
        controller.delegate = self
        
        return controller
    }
    
    private func instantiateAddViewController() -> UIViewController {
        print("AddView 생성")
        guard let controller = storyboard?.instantiateViewController(withIdentifier: AddViewController.storyboardIdentifier) as? AddViewController else { fatalError("Add view 생성 실패") }
        
        controller.delegate = self
        return controller
    }
    
    private func instantiateVoteViewController(with vote:Vote) -> UIViewController {
        print("VoteView 생성")
        guard let controller = storyboard?.instantiateViewController(withIdentifier:VoteViewController.storyboardIdentifier) as? VoteViewController else {fatalError("VoteView 생성 실패")}

        controller.voteData = vote
        //controller.SettingData()
        controller.delegate = self
        
        return controller
    }
    
    
    private func instantiateResultViewController(with vote:Vote) -> UIViewController {
        print("ResultView 생성")
        guard let controller = storyboard?.instantiateViewController(withIdentifier:ResultViewController.storyboardIdentifier) as? ResultViewController else {fatalError("ResultView 생성 실패")}
        
        controller.voteData = vote
        controller.SettingVoteResult()
        return controller
    }
    
    func composeMessage(with voteData:Vote, caption: String, session: MSSession? = nil) -> MSMessage {
        var components = URLComponents()
        components.queryItems = voteData.queryItems
        
        let layout = MSMessageTemplateLayout()
        layout.image = voteData.renderSticker(opaque: true)
        layout.caption = caption
        
        let message = MSMessage(session: session ?? MSSession())
        message.url = components.url!
        message.layout = layout
        
        return message
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
    

    
    override func didTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        // Called after the extension transitions to a new presentation style.
        
        // Use this method to finalize any behaviors associated with the change in presentation style.
    }
    
    
}


extension MessagesViewController: StartViewControllerDelegate{
    //새로운 투표 추가 버튼 눌렀을 때 
    func startViewControllerDidSelectAdd() {
        requestPresentationStyle(.expanded)
    }
}



extension MessagesViewController: AddViewControllerDelegate {
    func addViewController(_ controller: AddViewController) {
        guard let conversation = activeConversation else { fatalError("Expected a conversation") }
        guard let voteData = controller.voteData else { fatalError("Expected the controller to be displaying a shoppingList") }
        
        // Create a new message with the same session as any currently selected message.
        
        let message = composeMessage(with: voteData, caption: "투표(\(voteData.voteName))가 등록되었습니다. ", session: conversation.selectedMessage?.session)
        
        // Add the message to the conversation.
                conversation.insert(message) { error in
                    if let error = error {
                        print(error)
                    }
                }
                
        dismiss()
    }
}
extension MessagesViewController: VoteViewControllerDelegate {
    func voteViewController(_ controller: VoteViewController) {
        guard let conversation = activeConversation else { fatalError("Expected a conversation") }
        guard let voteData = controller.voteData else { fatalError("Expected the controller to be displaying a shoppingList") }
        
        // Create a new message with the same session as any currently selected message.
        
        let message = composeMessage(with: voteData, caption: "투표(\(voteData.voteName))에 참여했습니다. ", session: conversation.selectedMessage?.session)
        
        // Add the message to the conversation.
        conversation.insert(message) { error in
            if let error = error {
                print(error)
            }
        }
        
        dismiss()
    }
}

