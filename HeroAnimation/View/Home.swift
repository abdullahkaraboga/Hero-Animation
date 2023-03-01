//
//  Home.swift
//  HeroAnimation
//
//  Created by Abdullah Karaboğa on 25.02.2023.
//

import SwiftUI

struct Home: View {

    @State var currentItem: Today?

    @State var showDetailPage: Bool = false

    @Namespace var animation

    @State var animateView: Bool = false

    @State var animateContent: Bool = false

    @State var scrollOffset: CGFloat = 0

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
                    .opacity(showDetailPage ? 0 : 1)

                ForEach(todayItems) { item in
                    Button {
                        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                            currentItem = item
                            showDetailPage = true
                        }

                    } label: {
                        CardView(item: item)
                            .scaleEffect(currentItem?.id == item.id && showDetailPage ? 1 : 0.93)
                    }.buttonStyle(ScaledButtonStyle())
                        .opacity(showDetailPage ? (currentItem?.id == item.id && showDetailPage ? 1 : 0) : 1)
                }
            }.padding(.vertical)
        }
            .overlay {
            if let currentItem = currentItem, showDetailPage {
                DetailView(item: currentItem)
                    .ignoresSafeArea(.container, edges: .top)
            }
        }
            .background(alignment: .top) {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color("BG"))
                .frame(height: animateView ? nil : 350, alignment: .top)
                .scaleEffect(animateView ? 1 : 0.93)
                .opacity(animateView ? 1 : 0)
                .ignoresSafeArea()
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


        }
            .background {
            RoundedRectangle(cornerRadius: 15, style: .continuous).fill(.gray.opacity(0.09))
        }
            .matchedGeometryEffect(id: item.id, in: animation)
    }

    func DetailView(item: Today) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                CardView(item: item)

                VStack(spacing: 15) {

                    Text("dummy Text")
                        .multilineTextAlignment(.leading)
                        .lineSpacing(10)
                        .padding(.bottom, 20)

                    Divider()

                    Button {

                    } label: {
                        Label {
                            Text("Share Image")

                        } icon: {
                            Image(systemName: "square.and.arrow.up.fill")
                        }
                            .foregroundColor(.primary)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 25)
                            .background {
                            RoundedRectangle(cornerRadius: 5, style: .continuous).fill(.ultraThinMaterial)
                        }
                    }

                }
                    .padding()
                    .offset(y: scrollOffset > 0 ? -scrollOffset : 0)
                    .opacity(animateContent ? 1 : 0)
                    .scaleEffect(animateView ? 1 : 0, anchor: .top)
            }
                .offset(y: scrollOffset > 0 ? -scrollOffset : 0)
                .offset(offset: $scrollOffset)
        }
            .coordinateSpace(name: "SCROLL")
            .overlay(alignment: .topTrailing, content: {
            Button {
                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                    animateView = false
                    animateContent = false
                }

                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                    currentItem = nil
                    showDetailPage = true
                }

            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .foregroundColor(.white)
            }
                .padding()
                .padding(.top)
                .offset(y: -10)
                .opacity(animateView ? 1 : 0)

        })
            .onAppear {
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                animateView = true
            }

            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7).delay(0.1)) {
                animateContent = true
            }
        }
            .transition(.identity)
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

extension View {
    func offset(offset: Binding<CGFloat>) -> some View {
        return self.overlay {
            GeometryReader { proxy in
                let minY = proxy.frame(in: .named("SCROLL")).minY

                Color.clear
                    .preference(key: OffsetKey.self, value: minY)
            }
                .onPreferenceChange(OffsetKey.self) { value in
                offset.wrappedValue = value
            }
        }
    }
}

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
