//
//  UserNotesTableViewCell.swift
//  Git App
//
//  Created by Sergey Galagan on 22.03.2021.
//

import Foundation
import UIKit

class UserNotesTableViewCell: UITableViewCell, UITextViewDelegate {
    @IBOutlet var textView: UITextView!
    var textChanged: ((String) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textView.delegate = self
    }
    
    func showNotes(_ notes: String) {
        self.textView?.text = notes
    }
    
    func textChanged(action: @escaping (String) -> Void) {
        self.textChanged = action
    }
        
    func textViewDidChange(_ textView: UITextView) {
        textChanged?(textView.text)
    }
}
