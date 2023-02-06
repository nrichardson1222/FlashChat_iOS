//
//  MessageCell.swift
//  Flash Chat iOS13
//


import UIKit
//this is a sub class of UITableViewCell
class MessageCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var rightImageView: UIImageView!
    
    @IBOutlet weak var leftImageView: UIImageView!
    
    //initialize the nib similar to view did load method
    override func awakeFromNib() {
        super.awakeFromNib()
        //makes the message bubbles have rounded corners to make it look more modern
        messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
