//
//  ViewController.swift
//  StompClientLib
//
//  Created by wrathchaos on 07/07/2017.
//  Copyright (c) 2017 wrathchaos. All rights reserved.
//

import UIKit
import StompClientLib

class ViewController: UIViewController, StompClientLibDelegate {
    
    var socketClient = StompClientLib()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func connectClicked(_ sender: Any) {
        // Connection with socket
        registerSocket()
    }
    @IBAction func disconnectClicked(_ sender: Any) {
        socketClient.unsubscribe(destination: "/topic/greetings")
        socketClient.disconnect()
    }
    func registerSocket(){
//        let baseURL = "ws://192.168.1.199:8983/ws"
        // Cut the first 7 character which are "http://" Not necessary!!!
        // substring is depracated in iOS 11, use prefix instead :)
        // let wsURL = baseURL.substring(from:baseURL.index(baseURL.startIndex, offsetBy: 7))
//        let wsURL = baseURL.prefix(7)
        let completedWSURL = "ws://192.168.1.199:8983/ws"
        print("Completed WS URL : \(completedWSURL)")
        let url = NSURL(string: completedWSURL)!
        
        socketClient.openSocketWithURLRequest(request: NSURLRequest(url: url as URL) , delegate: self as StompClientLibDelegate)
    }
    
    func stompClientDidConnect(client: StompClientLib!) {
        let topic = "/topic/greetings"
        print("Socket is Connected : \(topic)")
        socketClient.subscribe(destination: topic)
    }
    
    func stompClientDidDisconnect(client: StompClientLib!) {
        print("Socket is Disconnected")
    }
    
    func stompClientWillDisconnect(client: StompClientLib!, withError error: NSError) {
        
    }
    
    func stompClient(client: StompClientLib!, didReceiveMessageWithJSONBody jsonBody: String?, withHeader header: [String : String]?, withDestination destination: String) {
        print("DESTINATION : \(destination)")
        print("JSON BODY : \(jsonBody)")
    }
    
    func serverDidSendReceipt(client: StompClientLib!, withReceiptId receiptId: String) {
        print("Receipt : \(receiptId)")
    }
    
    func serverDidSendError(client: StompClientLib!, withErrorMessage description: String, detailedErrorMessage message: String?) {
        print("Error : \(String(describing: message))")
    }
    
    func serverDidSendPing() {
        print("Server Ping")
    }

}
