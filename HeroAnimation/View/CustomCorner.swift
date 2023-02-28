//
//  CustomCorner.swift
//  HeroAnimation
//
//  Created by Abdullah Karaboğa on 25.02.2023.
//

import SwiftUI

struct CustomCorner: Shape {
    
    var corners = UIRectCorner()
    var radius : CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }

}
