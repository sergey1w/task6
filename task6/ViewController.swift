//
//  ViewController.swift
//  task6
//
//  Created by sergey on 16.11.2024.
//

import UIKit

class ViewController: UIViewController {
    
    
    private let squareView = SquareView(frame: .zero)
    
    private let animator = UIViewPropertyAnimator(duration: 1, dampingRatio: 0.7)
    
    private var bounds = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        bounds.frame = view.layoutMarginsGuide.layoutFrame
    }
    
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        let touchPoint = sender.location(in: view)
        
        let fittedPoint = fitToBounds(point: touchPoint)
        
        let rotationAngle = squareView.findRotationAngle(for: fittedPoint)

        animator.stopAnimation(true)
        
        animator.addAnimations { [squareView] in
            squareView.center = fittedPoint
            squareView.transform = .identity.rotated(by: rotationAngle)
        }
        
        animator.addAnimations({ [squareView] in
            squareView.transform = .identity
        }, delayFactor: 0.2)
        
        
        animator.startAnimation()
        
    }
    
    private func setup() {
        view.addSubview(squareView)
        view.addSubview(bounds)
        bounds.layer.borderWidth = 2
        squareView.center = view.center
        addGestureRecognizers()
    }
}

extension ViewController {
    private func addGestureRecognizers() {
        let tapGesure = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        view.addGestureRecognizer(tapGesure)
    }
    
    private func fitToBounds(point: CGPoint) -> CGPoint {
        let halfSquareSide = squareView.frame.width / 2
        
        let margins = view.directionalLayoutMargins
        let xLowerBound: CGFloat = margins.leading + halfSquareSide
        let xUpperBound: CGFloat = view.bounds.width - margins.trailing - halfSquareSide
        
        let yLowerBound: CGFloat = margins.top + halfSquareSide
        let yUpperBound: CGFloat = view.bounds.height - margins.bottom - halfSquareSide
        
        
        let x: CGFloat = min(max(xLowerBound, point.x), xUpperBound)
        let y: CGFloat = min(max(yLowerBound, point.y), yUpperBound)
       
        return CGPoint(x: x, y: y)
    }
}
