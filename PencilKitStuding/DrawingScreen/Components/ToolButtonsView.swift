//  ToolButtonsView.swift
//  EcosystemChallenge
//
//  Created by Leticia Bezerra on 29/06/25.
//

import UIKit

final class ToolButtonsView: UIView {
    
    let penButton = UIButton()
    let eraserButton = UIButton()
    let color1Button = UIButton()
    let color2Button = UIButton()
    let undoRedoControlsView = UndoRedoControlsView()

    private let penButtonContainer = UIView()
    private let eraserButtonContainer = UIView()
    
    private struct Constants {
        static let penButtonSize = CGSize(width: 105, height: 105)
        static let eraserButtonSize = CGSize(width: 90, height: 90)
        static let colorCircleSize: CGFloat = 50
        static let penButtonLeading: CGFloat = 10
        static let eraserButtonLeadingToPenTrailing: CGFloat = -40
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        clipsToBounds = true
        setupButtons()
        setupConstraints()
        applyRandomColors()
    }
    
    private func setupButtons() {
        penButton.setImage(UIImage(named: "pen")?.withRenderingMode(.alwaysOriginal), for: .normal)
        penButton.imageView?.contentMode = .scaleAspectFit
        penButton.contentHorizontalAlignment = .fill
        penButton.contentVerticalAlignment = .fill
        penButton.translatesAutoresizingMaskIntoConstraints = false
        
        eraserButton.setImage(UIImage(named: "eraser")?.withRenderingMode(.alwaysOriginal), for: .normal)
        eraserButton.imageView?.contentMode = .scaleAspectFit
        eraserButton.contentHorizontalAlignment = .fill
        eraserButton.contentVerticalAlignment = .fill
        eraserButton.translatesAutoresizingMaskIntoConstraints = false

        penButtonContainer.translatesAutoresizingMaskIntoConstraints = false
        eraserButtonContainer.translatesAutoresizingMaskIntoConstraints = false
        
        penButtonContainer.addSubview(penButton)
        eraserButtonContainer.addSubview(eraserButton)

        NSLayoutConstraint.activate([
            penButton.centerXAnchor.constraint(equalTo: penButtonContainer.centerXAnchor),
            penButton.centerYAnchor.constraint(equalTo: penButtonContainer.centerYAnchor),
            penButton.widthAnchor.constraint(equalToConstant: Constants.penButtonSize.width),
            penButton.heightAnchor.constraint(equalToConstant: Constants.penButtonSize.height),
            
            eraserButton.centerXAnchor.constraint(equalTo: eraserButtonContainer.centerXAnchor),
            eraserButton.centerYAnchor.constraint(equalTo: eraserButtonContainer.centerYAnchor),
            eraserButton.widthAnchor.constraint(equalToConstant: Constants.eraserButtonSize.width),
            eraserButton.heightAnchor.constraint(equalToConstant: Constants.eraserButtonSize.height)
        ])

        // Cores dos botões
        [color1Button, color2Button].forEach {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = Constants.colorCircleSize / 2
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.addTarget(self, action: #selector(colorButtonTapped(_:)), for: .touchUpInside)
        }
        
        undoRedoControlsView.translatesAutoresizingMaskIntoConstraints = false

        [penButtonContainer, eraserButtonContainer, color1Button, color2Button, undoRedoControlsView].forEach {
            addSubview($0)
        }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            penButtonContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.penButtonLeading),
            penButtonContainer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 14),
            penButtonContainer.widthAnchor.constraint(equalToConstant: Constants.penButtonSize.width),
            penButtonContainer.heightAnchor.constraint(equalToConstant: Constants.penButtonSize.height),

            eraserButtonContainer.leadingAnchor.constraint(equalTo: penButtonContainer.trailingAnchor, constant: Constants.eraserButtonLeadingToPenTrailing),
            eraserButtonContainer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 14),
            eraserButtonContainer.widthAnchor.constraint(equalToConstant: Constants.eraserButtonSize.width),
            eraserButtonContainer.heightAnchor.constraint(equalToConstant: Constants.eraserButtonSize.height),

            color1Button.leadingAnchor.constraint(equalTo: eraserButtonContainer.trailingAnchor, constant: 12),
            color1Button.centerYAnchor.constraint(equalTo: centerYAnchor),
            color1Button.widthAnchor.constraint(equalToConstant: Constants.colorCircleSize),
            color1Button.heightAnchor.constraint(equalToConstant: Constants.colorCircleSize),

            color2Button.leadingAnchor.constraint(equalTo: color1Button.trailingAnchor, constant: 18),
            color2Button.centerYAnchor.constraint(equalTo: centerYAnchor),
            color2Button.widthAnchor.constraint(equalToConstant: Constants.colorCircleSize),
            color2Button.heightAnchor.constraint(equalToConstant: Constants.colorCircleSize),

            undoRedoControlsView.leadingAnchor.constraint(equalTo: color2Button.trailingAnchor, constant: 10),
            undoRedoControlsView.centerYAnchor.constraint(equalTo: centerYAnchor),
            undoRedoControlsView.widthAnchor.constraint(equalToConstant: 150),
            undoRedoControlsView.heightAnchor.constraint(equalToConstant: 60),
            undoRedoControlsView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor)
        ])
    }

    // Destaca o botão de cor selecionado com escala e anel interno branco
    /// Remove o destaque de outros botões
    func highlightSelectedColor(selectedButton: UIButton) {
        let buttons = [color1Button, color2Button]
        
        buttons.forEach { button in
            if button == selectedButton {
                button.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
                button.layer.borderWidth = 5
                button.layer.borderColor = button.backgroundColor?.cgColor
                
                button.subviews.filter { $0.tag == 98 || $0.tag == 99 }.forEach { $0.removeFromSuperview() }
                
                let whiteRing = UIView()
                whiteRing.tag = 98
                whiteRing.backgroundColor = .white
                whiteRing.translatesAutoresizingMaskIntoConstraints = false
                whiteRing.layer.cornerRadius = (Constants.colorCircleSize * 0.8) / 2
                whiteRing.clipsToBounds = true
                button.addSubview(whiteRing)
                
                NSLayoutConstraint.activate([
                    whiteRing.centerXAnchor.constraint(equalTo: button.centerXAnchor),
                    whiteRing.centerYAnchor.constraint(equalTo: button.centerYAnchor),
                    whiteRing.widthAnchor.constraint(equalTo: button.widthAnchor, multiplier: 0.8),
                    whiteRing.heightAnchor.constraint(equalTo: button.heightAnchor, multiplier: 0.8)
                ])
                
                let colorDot = UIView()
                colorDot.tag = 99
                colorDot.backgroundColor = button.backgroundColor
                colorDot.translatesAutoresizingMaskIntoConstraints = false
                colorDot.layer.cornerRadius = (Constants.colorCircleSize * 0.6) / 2
                colorDot.clipsToBounds = true
                button.addSubview(colorDot)
                
                NSLayoutConstraint.activate([
                    colorDot.centerXAnchor.constraint(equalTo: button.centerXAnchor),
                    colorDot.centerYAnchor.constraint(equalTo: button.centerYAnchor),
                    colorDot.widthAnchor.constraint(equalTo: button.widthAnchor, multiplier: 0.6),
                    colorDot.heightAnchor.constraint(equalTo: button.heightAnchor, multiplier: 0.6)
                ])
                
            } else {
                button.transform = .identity
                button.layer.borderWidth = 0
                button.layer.borderColor = nil
                button.subviews.filter { $0.tag == 98 || $0.tag == 99 }.forEach { $0.removeFromSuperview() }
            }
        }
    }

    @objc private func colorButtonTapped(_ sender: UIButton) {
        #if DEBUG
            print("Cor selecionada: \(String(describing: sender.backgroundColor))")
        #endif
        
        highlightSelectedColor(selectedButton: sender)
    }

    func highlightSelectedTool(isPenSelected: Bool) {
        #if DEBUG
            print("Ferramenta selecionada: \(isPenSelected ? "Caneta" : "Borracha")")
        #endif
        
        let selectedButton = isPenSelected ? penButton : eraserButton
        let unselectedButton = isPenSelected ? eraserButton : penButton

        selectedButton.layer.borderWidth = 0
        selectedButton.layer.borderColor = nil
        selectedButton.layer.shadowColor = UIColor.black.cgColor
        selectedButton.layer.shadowOpacity = 0.5
        selectedButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        selectedButton.layer.shadowRadius = 6
        selectedButton.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)

        unselectedButton.layer.shadowOpacity = 0
        unselectedButton.transform = .identity
    }
    
    // Aplica cores aleatórias nos botões das cores e destaca o primeiro botão
    func applyRandomColors() {
        let toolSet = ToolSetGenerator.randomToolSet()
        color1Button.backgroundColor = toolSet.color1
        color2Button.backgroundColor = toolSet.color2
        
        #if DEBUG
            print("Cores aplicadas: cor1 = \(toolSet.color1.accessibilityName), cor2 = \(toolSet.color2.accessibilityName)")
        #endif

        DispatchQueue.main.async {
            self.highlightSelectedColor(selectedButton: self.color1Button)
        }
    }

    func setUndoRedoDelegate(_ delegate: UndoRedoControlsViewDelegate) {
        undoRedoControlsView.delegate = delegate
    }
}

#Preview {
    DrawingViewController()
}
