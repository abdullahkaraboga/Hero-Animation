//
//  Home.swift
//  HeroAnimation
//
//  Created by Abdullah Karaboğa on 25.02.2023.
//

import SwiftUI

struct Home: View {
    
    @State var currentItem : Today?
    @State var showDetailPage : Bool = false
    
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
                    .padding(.bottom)

                ForEach(todayItems) { item in
                    Button {
                        withAnimation(.interactiveSpring(response: 0.6,dampingFraction: 0.7,blendDuration: 0.7)){
                            currentItem = item
                            showDetailPage = true
                        }

                    } label: {
                        CardView(item: item)
                            .scaleEffect(currentItem?.id == item.id && showDetailPage ? 1 : 0.93)
                    }.buttonStyle(ScaledButtonStyle())

                }
            }.padding(.vertical)
        }
        .overlay {
            if let currentItem = currentItem,showDetailPage{
                
            }
        }
    }
    @ViewBuilder
    func CardView(item: Today) -> some View {
        VStack(alignment: .leading, spacing: 15) {

            ZStack(alignment: .topLeading) {


                GeometryReader { proxy in
                    let size = proxy.size

                    Image(item.artwork)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .clipShape(CustomCorner(corners: [.topLeft, .topRight], radius: 8))
                }
            }
                .frame(height: 400)


            HStack(spacing: 12) {
                Image(item.itemLogo)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))

                VStack(alignment: .leading, spacing: 4) {
                    Text(item.platformTitle.uppercased())
                        .font(.caption)
                        .foregroundColor(.gray)

                    Text(item.itemName)
                        .fontWeight(.bold)

                    Text(item.itemDescription)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Button {

                } label: {
                    Text("Buy")
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 20)
                        .background {
                        Capsule()
                            .fill(.ultraThinMaterial)
                    }
                }
            }
                .padding([.horizontal, .bottom])

            LinearGradient(colors: [
                    .black.opacity(0.5),
                    .black.opacity(0.2),
                    .clear

            ], startPoint: .top, endPoint: .bottom)
        }
            .background(RoundedRectangle(cornerRadius: 15, style: .continuous).fill(.gray.opacity(0.09)))
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home().preferredColorScheme(.dark)
    }
}

struct ScaledButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.94 : 1)
            .animation(.easeOut, value: configuration.isPressed)
    }
}
