//
//  SquareView.swift
//  task6
//
//  Created by sergey on 16.11.2024.
//

import UIKit

final class SquareView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        bounds.size = .init(width: 100, height: 100)
        backgroundColor = .systemBlue
        layer.cornerRadius = 8
    }
    
    func findRotationAngle(for point: CGPoint) -> CGFloat {
        let angle = angle(point: point)
        
        let neutralAngles: [CGFloat] = [0, .pi / 2, .pi, -.pi / 2] // Right, Bottom, Left, Top
        let closestNeutralAngle = neutralAngles.min(by: { abs($0 - angle) < abs($1 - angle) })!
        
        // Calculate the angle difference
        let angleDifference = angle - closestNeutralAngle
        
        // Define the maximum allowed rotation (e.g., π/6)
        let maxRotation: CGFloat = .pi / 6
        
        // Scale the angle difference to the maximum rotation
        let rotation = max(min(angleDifference, maxRotation), -maxRotation)
        
        return rotation
    }
    
    private func angle(point: CGPoint) -> CGFloat {
        let initial = center
        
        let deltaX = point.x - initial.x
        let deltaY = point.y - initial.y
        
        // Calculate the angle using atan2
        let angle = atan2(deltaY, deltaX) // Angle in radians
        
        return angle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
