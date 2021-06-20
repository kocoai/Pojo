//
//  AccountViewController.swift
//  Pojo
//
//  Created by Kien on 17/06/2021.
//

import UIKit

protocol AccountDisplayLogic: AnyObject {
  func display(viewModel: AccountViewModel)
}

final class AccountViewController: UIViewController {
  @IBOutlet private var photoImageView: UIImageView!
  @IBOutlet private var lastNameTextField: UITextField!
  @IBOutlet private var firstNameTextField: UITextField!
  @IBOutlet private var addressTextField: UITextField!
  @IBOutlet private var birthDatePicker: UIDatePicker!
  @IBOutlet private var scrollViewMarginBottomConstraint: NSLayoutConstraint!
  @IBOutlet private var editButton: UIButton! {
    didSet { editButton.circle().shadow() }
  }
  
  private var interactor: AccountBusinessLogic!
  
  private var isEditMode = false {
    didSet {
      lastNameTextField.isEnabled = isEditMode
      firstNameTextField.isEnabled = isEditMode
      addressTextField.isEnabled = isEditMode
      birthDatePicker.isEnabled = isEditMode
      photoImageView.isUserInteractionEnabled = isEditMode
      editButton.isSelected = !isEditMode
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    interactor = AccountInteractor(presenter: AccountPresenter(display: self))
    setupKeyboard()
    interactor.load()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    isEditMode = false
  }
  
  @IBAction func editAction(_ sender: UIButton) {
    sender.isSelected = !sender.isSelected
    isEditMode = !sender.isSelected
    
    if isEditMode  {
      lastNameTextField.becomeFirstResponder()
    } else {
      let user = User(firstName: firstNameTextField.text, lastName: lastNameTextField.text, address: addressTextField.text, birthDate: birthDatePicker.date, photo: photoImageView.image)
      interactor.save(user: user)
    }
  }
  
  @IBAction func photoTapAction(_ sender: Any) {
    let imagePickerController = UIImagePickerController()
    imagePickerController.delegate = self
    imagePickerController.allowsEditing = false
    imagePickerController.mediaTypes = ["public.image"]
    imagePickerController.sourceType = .photoLibrary
    present(imagePickerController, animated: true)
  }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension AccountViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
      photoImageView.image = pickedImage
        .squareCrop()
        .scalePreservingAspectRatio(targetSize: CGSize(width: photoImageView.frame.width, height: photoImageView.frame.width))
    }
    dismiss(animated: true, completion: nil)
  }
}

// MARK: - UITextFieldDelegate
extension AccountViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    view.endEditing(true)
    return true
  }
}

// MARK: - AccountDisplayLogic
extension AccountViewController: AccountDisplayLogic {
  func display(viewModel: AccountViewModel) {
    if let photo = viewModel.userPhoto {
      photoImageView.image = photo
    }
    lastNameTextField.text = viewModel.userLastName
    firstNameTextField.text = viewModel.userFirstName
    addressTextField.text = viewModel.userAddress
    if let date = viewModel.userBirthDate {
      birthDatePicker.date = date
    }
  }
}

// MARK: - Setup keyboard
extension AccountViewController {
  @objc private func adjustForKeyboard(notification: Notification) {
    guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
    
    let keyboardScreenEndFrame = keyboardValue.cgRectValue
    let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
    
    UIView.animate(withDuration: 0.3) {
      if notification.name == UIResponder.keyboardWillHideNotification {
        self.scrollViewMarginBottomConstraint.constant = 0
      } else {
        self.scrollViewMarginBottomConstraint.constant = keyboardViewEndFrame.height - self.view.safeAreaInsets.bottom
      }
      self.view.layoutSubviews()
    }
  }
  
  private func setupKeyboard() {
    let notificationCenter = NotificationCenter.default
    notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
  }
}
