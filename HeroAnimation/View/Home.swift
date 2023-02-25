//
//  Home.swift
//  HeroAnimation
//
//  Created by Abdullah Karaboğa on 25.02.2023.
//

import SwiftUI

struct Home: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {

            VStack(spacing: 30) {

                HStack(alignment: .bottom) {

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Monday 13 April")
                            .font(.callout)
                            .foregroundColor(.gray)
                        Text("Today")
                            .font(.largeTitle.bold())
                    }
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Button {

                    } label: {
                        Image(systemName: "person.circle.fill").font(.largeTitle)
                    }


                }
                    .padding(.horizontal)

                ForEach(todayItems) { item in


                }
            }
                .padding(.vertical)

        }
    }

}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
