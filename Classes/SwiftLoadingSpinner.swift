//
//  SwiftLoadingSpinner.swift
//  SwiftLoadingSpinner
//
//  Created by Phong Le on 25/09/2021.
//

import UIKit

public enum Icon {
    case square
    case circle
}

public enum Animation {
    case fade
    case spiral
}

@available(iOS 10.0, *)
open class SwiftLoadingSpinner: UIView {
    
    private var icons = [UIView]()
    private var timer: Timer?
    open var iconType: Icon = .square
    open var animationType: Animation = .fade
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public convenience init(icon: Icon, animation: Animation) {
        self.init(frame: .zero)
        iconType = icon
        animationType = animation
        setupView()
    }
    
    private func clearAllImagesColor() {
        for icon in icons {
            icon.backgroundColor = .white
        }
    }
    
    func after(interval: TimeInterval, completion: (() -> Void)?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            completion?()
        }
    }
    
    private func randomDotSpiral() -> Timer {
        // time run for dots
        let delays = [(0.1 * 1), (0.1 * 2), (0.1 * 3),
                      (0.1 * 8), (0.1 * 9), (0.1 * 4),
                      (0.1 * 7), (0.1 * 6), (0.1 * 5)]

        let timer = Timer.scheduledTimer( withTimeInterval: 1,
                              repeats: true) { [unowned self] _ in
            for index in icons.indices {
                self.after(interval: delays[index]) {
                    self.clearAllImagesColor()
                    icons[index].backgroundColor = .grayLight
                }
            }
        }
        
        return timer
    }
    
    private func randomDotFade() {
        for icon in icons {
            let duration = CGFloat.random(in: 1.0...1.5)
            let delay = CGFloat.random(in: 0.5...0.8)
            UIView.animate(
                withDuration: duration,
                delay: delay,
                options: [.repeat, .curveEaseInOut],
                animations: {
                    icon.backgroundColor = .lightGray
                },
                completion: nil)
        }
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        
        for index in 0...8 {
            let icon = UIView()
            icon.backgroundColor = .white
            icon.translatesAutoresizingMaskIntoConstraints = false
            addSubview(icon)
 
            switch index {
            case 0:
                NSLayoutConstraint.activate([
                    icon.topAnchor.constraint(equalTo: topAnchor),
                    icon.leadingAnchor.constraint(equalTo: leadingAnchor)
                ])
            case 1:
                NSLayoutConstraint.activate([
                    icon.topAnchor.constraint(equalTo: topAnchor),
                    icon.leadingAnchor.constraint(equalTo: icons[0].trailingAnchor, constant: 6)
                ])
            case 2:
                NSLayoutConstraint.activate([
                    icon.topAnchor.constraint(equalTo: topAnchor),
                    icon.leadingAnchor.constraint(equalTo: icons[1].trailingAnchor, constant: 6),
                    icon.trailingAnchor.constraint(equalTo: trailingAnchor)
                ])
            case 3:
                NSLayoutConstraint.activate([
                    icon.topAnchor.constraint(equalTo: icons[0].bottomAnchor, constant: 6),
                    icon.leadingAnchor.constraint(equalTo: leadingAnchor)
                ])
            case 4:
                NSLayoutConstraint.activate([
                    icon.topAnchor.constraint(equalTo: icons[1].bottomAnchor, constant: 6),
                    icon.leadingAnchor.constraint(equalTo: icons[3].trailingAnchor, constant: 6)
                ])
            case 5:
                NSLayoutConstraint.activate([
                    icon.topAnchor.constraint(equalTo: icons[2].bottomAnchor, constant: 6),
                    icon.leadingAnchor.constraint(equalTo: icons[4].trailingAnchor, constant: 6),
                    icon.trailingAnchor.constraint(equalTo: trailingAnchor)
                ])
            case 6:
                NSLayoutConstraint.activate([
                    icon.topAnchor.constraint(equalTo: icons[3].bottomAnchor, constant: 6),
                    icon.leadingAnchor.constraint(equalTo: leadingAnchor),
                    icon.bottomAnchor.constraint(equalTo: bottomAnchor)
                ])
            case 7:
                NSLayoutConstraint.activate([
                    icon.topAnchor.constraint(equalTo: icons[4].bottomAnchor, constant: 6),
                    icon.leadingAnchor.constraint(equalTo: icons[6].trailingAnchor, constant: 6),
                    icon.bottomAnchor.constraint(equalTo: bottomAnchor)
                ])
            default:
                NSLayoutConstraint.activate([
                    icon.topAnchor.constraint(equalTo: icons[5].bottomAnchor, constant: 6),
                    icon.leadingAnchor.constraint(equalTo: icons[7].trailingAnchor, constant: 6),
                    icon.trailingAnchor.constraint(equalTo: trailingAnchor),
                    icon.bottomAnchor.constraint(equalTo: bottomAnchor)
                ])
            }
            
            NSLayoutConstraint.activate([
                icon.widthAnchor.constraint(equalToConstant: 10),
                icon.heightAnchor.constraint(equalToConstant: 10)
            ])
            
            icon.layer.cornerRadius = iconType == .circle ? 5 : 0
            icons.append(icon)
        }
        
        switch animationType {
        case .fade:
            randomDotFade()
        case .spiral:
            timer = randomDotSpiral()
        }
    }
    
    deinit {
        timer?.invalidate()
        timer = nil
        for icon in icons {
            icon.layer.removeAllAnimations()
        }
    }
}

extension UIColor {
    static var grayLight: UIColor {
        return .init(red: 126 / 255,
                     green: 126 / 255,
                     blue: 126 / 255,
                     alpha: 0.001)
    }
}
