//
//  ChatViewController.swift
//  Flash Chat iOS13
//


import UIKit
import Firebase

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    let db = Firestore.firestore()
    var messages: [Message] = [
//        Message(sender: "1@2.com", body: "Hey"),
//        Message(sender: "a@b.com", body: "Hello"),
//        Message(sender: "1@2.com", body: "Sup?")
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        navigationItem.hidesBackButton = true//hides back button on nav bar on top of screen
        navigationItem.title = "Name of Person"
        //this uses the nibname prototype cell that I made in MessageCell
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        loadMessages()
    }
    
    
    func loadMessages(){
        //orders the messages by the time stamp that they were uploaded to the database
        //add snapshot listener reloads the tableview when a new message is sent
        db.collection(K.FStore.collectionName).order(by: K.FStore.dateField).addSnapshotListener { querySnapshot, error in
            //need to empty out the array each time the listener is called otherwise it will add the same messages each time
            self.messages = []
            //clears the message array so I populate it with the messages from the database
            
            if let e = error{
                print("There was an issue retrieving data")

            }else{
                print("Retrieving data")
                //tap into query snapshot object to get the database messages
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments{
                        print(doc.data())
                        let data = doc.data()
                        //data is a dictionary //optional downcast to string
                        if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String {//optional downcast to string
                            //gets message object and saves it to messages array
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            self.messages.append(newMessage)
                            //this makes the finished messages array using data from the database
                            DispatchQueue.main.async{//use dispatch queue since we are in a closure
                                //reloadss the tableview with the new messages in the array
                                self.tableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                //scrolls to the bottom row
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                           
                        }
                    }
                }
            }
        }
    }
    @IBAction func sendPressed(_ sender: UIButton) {
        //optional binding grabs hold of text in message textfield
        //sender is the logged in users email address by tapping into the currentUser property to get the email
        //adds message to DB with message sender, message, and time it was sent
        //the time the message was sent using dateField for ordering the messages when we load them from the DB
        if let messageBody = messageTextfield.text , let messageSender = Auth.auth().currentUser?.email {
            db.collection(K.FStore.collectionName).addDocument(data: [K.FStore.senderField: messageSender, K.FStore.bodyField: messageBody, K.FStore.dateField: Date().timeIntervalSince1970]) { (error) in
                if let e = error {
                    print("error saving to firestore")
                }else{
                    print("Successfully saved data")
                    DispatchQueue.main.async {
                        self.messageTextfield.text = ""

                    }
                }
            }
        }
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        
        //method to log out users and performs sequeu back to the root viewcontroller
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
      
    }
   
}
//these are the delegate methods for the table view

extension ChatViewController: UITableViewDataSource {
    
    //the numbner of messages to show
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //need to create cell and return it to tableview
        let message = messages[indexPath.row]
        //uses the resusable nib cell that I made
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.label.text = message.body
        //this changes the message bubble depending on if it was the logged in user who sent the message
        if message.sender == Auth.auth().currentUser?.email { //if sender is same as current logged in user
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.label.textColor = UIColor(named: K.BrandColors.purple)
        }else{
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell.label.textColor = UIColor(named: K.BrandColors.lightPurple)
        }
        
      
        return cell
        
    }
    
}

