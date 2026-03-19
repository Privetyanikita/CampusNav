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
    private var PhoneNumber: String? = ""
    private var Email: String? = ""
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle.fill")
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemGray6
        imageView.clipsToBounds = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let laberUserName: UILabel = {
        let label = UILabel()
        label.text = "..."
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var Button1: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Фамилия и имя", for: .normal)
            button.setTitleColor(.systemGray6, for: .normal)
            button.backgroundColor = .systemBlue
            button.layer.cornerRadius = 10
            button.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
            return button
        }()
    
    private lazy var Button2: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Номер телефона", for: .normal)
            button.setTitleColor(.systemGray6, for: .normal)
            button.backgroundColor = .systemBlue
            button.layer.cornerRadius = 10
            button.addTarget(self, action: #selector(showAlertNumberPhone), for: .touchUpInside)
            return button
        }()
    
    private lazy var Button3: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Электронная почта", for: .normal)
            button.setTitleColor(.systemGray6, for: .normal)
            button.backgroundColor = .systemBlue
            button.layer.cornerRadius = 10
            button.addTarget(self, action: #selector(showAlertEmail), for: .touchUpInside)
            return button
        }()
    
    private let Button4: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Уведомления", for: .normal)
            button.setTitleColor(.systemGray6, for: .normal)
            button.backgroundColor = .systemBlue
            button.layer.cornerRadius = 10
            return button
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
    
    private lazy var Button5: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Сбросить данные", for: .normal)
            button.setTitleColor(.systemGray6, for: .normal)
            button.backgroundColor = .systemRed
            button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(resetData), for: .touchUpInside)
            return button
        }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notificationSwitch.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        avatarImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectPhoto))
        avatarImageView.addGestureRecognizer(tapGesture)
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .systemGroupedBackground
        view.add(subviews: avatarImageView, laberUserName, Button1, Button2, Button3, Button4, Button5, notificationLabel, notificationSwitch)
    }
}

extension SettingsViewController {
    @objc private func switchChanged(_ sender: UISwitch) {
        if sender.isOn {
            notificationLabel.text = "Уведомления: Включены"
            print("Уведомления активированы")
        } else {
            notificationLabel.text = "Уведомления: Выключены"
            print("Уведомления отключены")
        }
    }
    
    @objc private func resetData() {
        let alert = UIAlertController(
            title: "Сброс данных",
            message: "Вы уверены, что хотите удалить все введенные данные? Это действие нельзя отменить.",
            preferredStyle: .actionSheet
        )
    
        let resetAction = UIAlertAction(title: "Сбросить всё", style: .destructive) { [weak self] _ in
            self?.performReset()
        }
        
        alert.addAction(resetAction)
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        
        present(alert, animated: true)
    }

    private func performReset() {
        PhoneNumber = ""
        Email = ""
        laberUserName.text = "Ваше имя..."
        avatarImageView.image = UIImage(systemName: "person.circle.fill")
    }
    
    @objc func showAlert(){
        let alert = UIAlertController(title: "Ваша фамилия и имя", message: nil, preferredStyle: .alert)
        alert.addTextField { [weak self] textField in
            textField.text = self?.laberUserName.text
            textField.placeholder = "Фамилия и имя"
        }
        let saveAction = UIAlertAction(title: "Сохранить", style: .default) { _ in
            if let textField = alert.textFields?.first, !textField.text!.isEmpty {
                self.laberUserName.text = textField.text
            }
        }
        alert.addAction(saveAction)
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        present(alert, animated: true)
    }
    
    @objc func showAlertNumberPhone(){
        let alert = UIAlertController(title: "Ваш номер телефона", message: nil, preferredStyle: .alert)
        alert.addTextField { [weak self] textField in
            textField.text = self?.PhoneNumber
            textField.placeholder = "Ваш номер телефона"
            textField.keyboardType = .phonePad
        }
        let saveAction = UIAlertAction(title: "Сохранить", style: .default) { [weak self] _ in
            if let textField = alert.textFields?.first?.text {
                self?.PhoneNumber = textField
                print("Номер сохранен: \(textField)")
            }
        }
        alert.addAction(saveAction)
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        
        present(alert, animated: true)
    }
    
    @objc func showAlertEmail(){
        let alert = UIAlertController(title: "Ваша электронная почта", message: nil, preferredStyle: .alert)
        alert.addTextField { [weak self] textField in
            textField.text = self?.Email
            textField.placeholder = "@email"
        }
        let saveAction = UIAlertAction(title: "Сохранить", style: .default) { [weak self] _ in
            if let textField = alert.textFields?.first?.text {
                self?.Email = textField
                print("Почта сохранена: \(textField)")
            }
        }
        alert.addAction(saveAction)
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        
        present(alert, animated: true)
    }
    
    @objc private func selectPhoto() {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    private func setupConstraints() {
        notificationLabel.snp.makeConstraints { make in
                make.leading.equalTo(Button1.snp.leading) // Выравниваем по левому краю кнопок
                make.centerY.equalTo(Button4.snp.centerY) // Центрируем по вертикали относительно места 4-й кнопки
            }
            
            notificationSwitch.snp.makeConstraints { make in
                make.trailing.equalTo(Button1.snp.trailing) // Выравниваем по правому краю
                make.centerY.equalTo(notificationLabel.snp.centerY)
            }
        avatarImageView.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.centerX.equalToSuperview()
            make.size.equalTo(120)
        }
        laberUserName.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(45)
        }
        Button1.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
        }
        Button2.snp.makeConstraints { make in
            make.top.equalTo(Button1.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
        }
        Button3.snp.makeConstraints { make in
            make.top.equalTo(Button2.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
        }
        Button4.snp.makeConstraints { make in
            make.top.equalTo(Button3.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
        }
        Button5.snp.makeConstraints { make in
            make.top.equalTo(Button4.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
        }
        Button4.isHidden = true
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
