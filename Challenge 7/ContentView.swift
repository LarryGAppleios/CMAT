//
//  ContentView.swift
//  Challenge 7
//
//  Created by Larry Gill on 4/16/25.
//

import UIKit
import SwiftUI

// Main View Controller that comes after splash
class MainViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Add your main screen content here
    }
}

// Splash View Controller
class SplashViewController: UIViewController {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.textColor = .white
        label.alpha = 0
        return label
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "CC LOGO 2")
        imageView.alpha = 0
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setupUI()
    }
    
    private func setupViewController() {
        modalPresentationStyle = .fullScreen
        edgesForExtendedLayout = .all
        view.frame = UIScreen.main.bounds
        view.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        setNeedsStatusBarAppearanceUpdate()
        
        if #available(iOS 11.0, *) {
            view.insetsLayoutMarginsFromSafeArea = false
        }
        view.layoutMargins = .zero
        additionalSafeAreaInsets = .zero
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private func setupUI() {
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundView)
        
        view.addSubview(logoImageView)
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            // Background constraints
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // Logo constraints
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 275),
            logoImageView.widthAnchor.constraint(equalToConstant: 250),
            logoImageView.heightAnchor.constraint(equalToConstant: 250),
            
            // Title label constraints
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ])
        
        // Set attributed text for different colors
        let attributedString = NSMutableAttributedString(string: "my", attributes: [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 40, weight: .bold)
        ])
        attributedString.append(NSAttributedString(string: "CrewConnect", attributes: [
            .foregroundColor: UIColor(red: 0/255, green: 230/255, blue: 0/255, alpha: 1),
            .font: UIFont.systemFont(ofSize: 40, weight: .bold)
        ]))
        titleLabel.attributedText = attributedString
        
        animateLabel()
    }
    
    private func animateLabel() {
        titleLabel.transform = CGAffineTransform(translationX: 0, y: 20)
        logoImageView.transform = CGAffineTransform(translationX: 0, y: 20)
        
        UIView.animate(withDuration: 0.8, delay: 0, options: .curveEaseOut) {
            self.titleLabel.alpha = 1
            self.logoImageView.alpha = 1
            self.titleLabel.transform = .identity
            self.logoImageView.transform = .identity
        } completion: { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                self.transitionToMain()
            }
        }
    }
    
    private func transitionToMain() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) {
            self.titleLabel.alpha = 0
            self.logoImageView.alpha = 0
        } completion: { _ in
            let mainViewController = MainViewController()
            mainViewController.modalPresentationStyle = .fullScreen
            self.present(mainViewController, animated: true)
        }
    }
}

// Preview helper
struct SplashViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> SplashViewController {
        return SplashViewController()
    }
    
    func updateUIViewController(_ uiViewController: SplashViewController, context: Context) {}
}

#Preview {
    SplashViewControllerRepresentable()
}
