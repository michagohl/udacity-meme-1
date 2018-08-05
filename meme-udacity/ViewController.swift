//
//  ViewController.swift
//  meme-udacity
//
//  Created by Michael Gohl on 29.06.18.
//  Copyright © 2018 Michael Gohl. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    var cameraButton: UIBarButtonItem!
    @IBOutlet weak var textBottom: UITextField!
    @IBOutlet weak var textTop: UITextField!
    var cancelButton: UIBarButtonItem!
    @IBOutlet weak var topToolbar: UIToolbar!
    var albumButton: UIBarButtonItem!
    var shareButton: UIBarButtonItem!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    
    var textSave = "";
    var isBottomField = false
    
    // MARK: - View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createToolbarButtons();
        reset()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unsubscribeToKeyboardNotifications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardNotifications();
    }
    
    // MARK: - Helper Methods
    
    func closeModal() {
        dismiss(animated: true, completion: nil)
    }
    
    func reset() {
        setTextField(field: textTop, str: "TOP")
        setTextField(field: textBottom, str: "BOTTOM")
        imagePickerView.image = nil
    }
    
    func createToolbarButtons() {
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareClicked(_:)));
        cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelClicked(_:)));
        topToolbar.items = [shareButton, flexible, cancelButton]
        cameraButton = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(pickAnImageFromCamera(_:)));
        albumButton = UIBarButtonItem(title: "Album", style: .plain, target: self, action: #selector(pickAnImageFromAlbum(_:)));
        bottomToolbar.items = [flexible, albumButton, cameraButton, flexible];
    }
    
    func setTextField(field: UITextField, str: String) {
        field.defaultTextAttributes = [
            NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
            NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
            NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSAttributedStringKey.strokeWidth.rawValue: -2.0]
        field.text = str;
        field.delegate = self
        field.textAlignment = .center;
        field.backgroundColor = .clear;
    }
    
    // MARK: - Share
    
    @IBAction func shareClicked(_ sender: Any) {
        let controller = UIActivityViewController(activityItems: [generateMemedImage()], applicationActivities: nil)
        controller.completionWithItemsHandler = {
            (type, completed, items, error) in
            if (completed) {
                MemeHelper().saveMeme(top: self.textTop.text!, bottom: self.textBottom.text!, image: self.generateMemedImage())
                self.closeModal();
            }
        }
        self.present(controller, animated: true, completion: nil)
    }
    
    func generateMemedImage() -> UIImage {
        topToolbar.isHidden = true
        bottomToolbar.isHidden = true;
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        topToolbar.isHidden = false
        bottomToolbar.isHidden = false
        
        return memedImage
    }
    
    // Mark: - Cancel
    
    @IBAction func cancelClicked(_ sender: Any) {
        let alert = UIAlertController(title: "Are you sure?", message: "Do you really want to destroy the current meme?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {(alert: UIAlertAction!) in self.reset()}))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Back to Overview", style: .default, handler: {(alert: UIAlertAction!) in self.closeModal()}));
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: Textfield Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField.text == "") {
            textField.text = textSave;
        }
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        isBottomField = (textField == textBottom)
        return true;
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textSave = textField.text!;
        textField.text = ""
    }
    
    // MARK: - Keyword Events
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if isBottomField {
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        if isBottomField {
            view.frame.origin.y = 0
        }
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeToKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    // MARK: - Image Picker
    
    func openImagePicker(source: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController();
        imagePicker.delegate = self;
        imagePicker.sourceType = source;
        present(imagePicker, animated: true, completion: nil);
        
    }
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        openImagePicker(source: .photoLibrary)
    }
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        openImagePicker(source: .camera)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil);
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            imagePickerView.image = image;
        }
        dismiss(animated: true, completion: nil);
    }
}

