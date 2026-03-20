//
//  SettingsViewController.swift
//  CampusNav
//
//  Created by Nikita on 04.03.2026.
//

import UIKit
import SnapKit
import PhotosUI

final class SettingsViewController: UIViewController {
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle.fill")
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemGray6
        imageView.clipsToBounds = true
        return imageView
    }()
    private let laberUserName: UILabel = {
        let label = UILabel()
        label.text = "Фамилия Имя"
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    private let editNameIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "pencil")
        imageView.tintColor = .systemGray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let containerUserNumberPhone: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.1
        return view
    }()
    private let UserNumberPhoneTitle: UILabel = {
        let label = UILabel()
        label.text = "Номер телефона:"
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    private let UserNumberPhoneLabel: UILabel = {
        let label = UILabel()
        label.text = "+7-(000)-000-00-00"
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let containerUserEmail: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.1
        return view
    }()
    private let UserEmailTitle: UILabel = {
        let label = UILabel()
        label.text = "Почта:"
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    private let UserEmailLabel: UILabel = {
        let label = UILabel()
        label.text = "example@email.com"
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let containerUserBirthDay: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.1
        return view
    }()
    private let UserBirthDayTitle: UILabel = {
        let label = UILabel()
        label.text = "Дата рождения:"
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    private let UserBirthDayLabel: UILabel = {
        let label = UILabel()
        label.text = "00.00.0000"
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.isUserInteractionEnabled = true
        return label
    }()
    private let dataPickerField = UITextField(frame: .zero)
    private let dataPicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        picker.locale = Locale(identifier: "ru_RU")
        return picker
    }()
    
    private let notificationSwitch: UISwitch = {
        let sw = UISwitch()
        sw.isOn = false
        sw.onTintColor = .systemGreen
        return sw
    }()
    private let notificationLabel: UILabel = {
        let label = UILabel()
        label.text = "Уведомления: Выключены"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var ResetProfileButton: UIButton = { // WIP
        let button = UIButton(type: .system)
        button.backgroundColor = .systemRed
        button.setTitle("Сбросить профиль", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = 12
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.1
        return button
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        avatarImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectPhoto))
        avatarImageView.addGestureRecognizer(tapGesture)
        
        laberUserName.isUserInteractionEnabled = true
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(handleNameTap))
        laberUserName.addGestureRecognizer(tapGesture1)
        
        UserNumberPhoneLabel.isUserInteractionEnabled = true
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(handlePhoneTap))
        UserNumberPhoneLabel.addGestureRecognizer(tapGesture2)
        
        UserEmailLabel.isUserInteractionEnabled = true
        let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(handleEmailTap))
        UserEmailLabel.addGestureRecognizer(tapGesture3)
        
        notificationSwitch.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        
        ResetProfileButton.addTarget(self, action: #selector(ResetTap), for: .touchUpInside)
        
        view.backgroundColor = .systemGroupedBackground
        setupViews()
        setupConstrains()
    }
    private func setupViews() {
        view.backgroundColor = .systemGroupedBackground
        view.add(subviews: avatarImageView, laberUserName, editNameIcon, containerUserNumberPhone, containerUserEmail, containerUserBirthDay, dataPickerField, notificationLabel, notificationSwitch, ResetProfileButton)
        
        containerUserNumberPhone.addSubview(UserNumberPhoneTitle)
        containerUserNumberPhone.addSubview(UserNumberPhoneLabel)
        
        containerUserEmail.addSubview(UserEmailTitle)
        containerUserEmail.addSubview(UserEmailLabel)
        
        containerUserBirthDay.addSubview(UserBirthDayTitle)
        containerUserBirthDay.addSubview(UserBirthDayLabel)
        
        dataPickerField.inputView = dataPicker
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        dataPickerField.inputAccessoryView = toolbar
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleBirthDayTap))
        UserBirthDayLabel.addGestureRecognizer(tap)
    }
}

extension SettingsViewController {
    @objc private func selectPhoto() {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        present(picker, animated: true)
    }
    @objc private func handleNameTap() {
            let alert = UIAlertController(title: "Изменить имя", message: "Введите ваше имя и фамилию", preferredStyle: .alert)
            alert.addTextField { textField in
                textField.placeholder = "Иван Иванов"
                textField.text = self.laberUserName.text
            }
            let saveAction = UIAlertAction(title: "Сохранить", style: .default) { [weak self] _ in
                if let newName = alert.textFields?.first?.text, !newName.isEmpty {
                    self?.laberUserName.text = newName
                    self?.laberUserName.textColor = .label
                }
            }
            alert.addAction(saveAction)
            alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
            present(alert, animated: true)
        }
    
    @objc private func handlePhoneTap() {
        let alert = UIAlertController(title: "Изменить номер", message: "Введите новый номер телефона", preferredStyle: .alert)
            alert.addTextField { textField in
                textField.placeholder = "+7 (000) 000-00-00"
                textField.keyboardType = .phonePad
                textField.text = self.UserNumberPhoneLabel.text
            }
            let saveAction = UIAlertAction(title: "Сохранить", style: .default) { [weak self] _ in
                if let newNumber = alert.textFields?.first?.text, !newNumber.isEmpty {
                    self?.UserNumberPhoneLabel.text = newNumber
                    self?.UserNumberPhoneLabel.textColor = .systemBlue
                }
            }
            alert.addAction(saveAction)
            alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
            
            present(alert, animated: true)
    }
    
    @objc private func handleEmailTap() {
        let alert = UIAlertController(title: "Изменить почту", message: "Введите новую почту", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "example@mail.ru"
            textField.keyboardType = .emailAddress
            textField.text = self.UserEmailLabel.text
        }
        let saveAction = UIAlertAction(title: "Сохранить", style: .default) { [weak self] _ in
            if let newEmail = alert.textFields?.first?.text, !newEmail.isEmpty {
                self?.UserEmailLabel.text = newEmail
                self?.UserEmailLabel.textColor = .systemBlue
            }
        }
        alert.addAction(saveAction)
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        
        present(alert, animated: true)
    }
    @objc private func handleBirthDayTap() {
        dataPickerField.becomeFirstResponder( )
    }
    @objc private func donePressed() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        UserBirthDayLabel.text = formatter.string(from: dataPicker.date)
        UserBirthDayLabel.textColor = .systemBlue
        view.endEditing(true)
    }
    
    @objc private func switchChanged(_ sender: UISwitch) {
        notificationLabel.text = sender.isOn ? "Уведомления: Включены" : "Уведомления: Выключены"
    }
    
    @objc private func ResetTap() {
        let alert = UIAlertController(
            title: "Сброс профиля",
            message: "Вы уверены, что хотите сбросить все данные? Это действие нельза отменить.",
            preferredStyle: .actionSheet
        )
        let resetAction = UIAlertAction(title: "Сбросить", style: .destructive) { [weak self] _ in
            self?.resetToDefaults()
        }
        alert.addAction(resetAction)
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        
        present(alert, animated: true)
    }
    private func resetToDefaults() {
        laberUserName.text = "Фамилия Имя"
        UserNumberPhoneLabel.text = "+7-(000)-000-00-00"
        UserEmailLabel.text = "example@email.com"
        UserBirthDayLabel.text = "00.00.0000"
        
        laberUserName.textColor = .secondaryLabel
        UserNumberPhoneLabel.textColor = .secondaryLabel
        UserEmailLabel.textColor = .secondaryLabel
        UserBirthDayLabel.textColor = .secondaryLabel
        
        avatarImageView.image = UIImage(systemName: "person.circle.fill")
    }
    
    private func setupConstrains() {
        // Аватарка
        avatarImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalToSuperview()
            make.size.equalTo(150)
        }
        laberUserName.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(0)
            make.centerX.equalToSuperview()
            make.height.equalTo(45)
        }
        editNameIcon.snp.makeConstraints { make in
            make.centerY.equalTo(laberUserName)
            make.left.equalTo(laberUserName.snp.right).offset(8)
            make.size.equalTo(20)
        }
        // Номер телефона
        containerUserNumberPhone.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide).offset(-30)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        UserNumberPhoneTitle.snp.makeConstraints{ make in
            make.top.left.equalToSuperview().inset(18)
            make.height.equalTo(16)
        }
        UserNumberPhoneLabel.snp.makeConstraints { make in
            make.top.right.equalToSuperview().inset(18)
            make.height.equalTo(16)
        }
        // Эл. почта
        containerUserEmail.snp.makeConstraints { make in
            make.top.equalTo(containerUserNumberPhone.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        UserEmailTitle.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(18)
            make.height.equalTo(16)
        }
        UserEmailLabel.snp.makeConstraints { make in
            make.top.right.equalToSuperview().inset(18)
            make.height.equalTo(16)
        }
        // Дата рождения
        containerUserBirthDay.snp.makeConstraints { make in
            make.top.equalTo(containerUserEmail.snp.bottom).offset(20)
            make.left.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        UserBirthDayTitle.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(18)
            make.height.equalTo(16)
        }
        UserBirthDayLabel.snp.makeConstraints { make in
            make.top.right.equalToSuperview().inset(18)
            make.height.equalTo(16)
        }
        // Уведомления
        notificationLabel.snp.makeConstraints { make in
            make.top.equalTo(containerUserBirthDay.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(20)
        }
        notificationSwitch.snp.makeConstraints { make in
            make.centerY.equalTo(notificationLabel)
            make.right.equalToSuperview().inset(20)
        }
        // Cброс профиля
        ResetProfileButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(325)
            make.width.equalTo(225)
            make.height.equalTo(40)
        }
    }
}

extension SettingsViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        guard let provider = results.first?.itemProvider,
              provider.canLoadObject(ofClass: UIImage.self) else { return }
        
        provider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
            DispatchQueue.main.async {
                if let selectedImage = image as? UIImage {
                    self?.avatarImageView.image = selectedImage
                }
            }
        }
    }
}
