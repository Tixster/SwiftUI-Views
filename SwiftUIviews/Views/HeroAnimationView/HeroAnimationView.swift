//
//  HeroAnimationView.swift
//  SwiftUIviews
//
//  Created by Кирилл Тила on 17.04.2022.
//

import SwiftUI

struct HeroAnimationView: View {
    
    @State var currentItem: Today?
    @State var showDetailPage: Bool = false
    
    @Namespace var animation
    @State var animateView: Bool = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 8) {
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("MONDAY 4 APRIL")
                            .font(.callout)
                            .foregroundColor(.gray)
                        Text("Today")
                            .font(.largeTitle.bold())
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Button {
                        //
                    } label: {
                        Image(systemName: "person.circle.fill")
                            .font(.largeTitle)
                    }

                }
                .padding([.horizontal, .bottom])
                ForEach(todayItems) { item in
                    Button {
                        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                            currentItem = item
                            showDetailPage = true
                        }
                    } label: {
                        CardView(item: item)
                            .scaleEffect(currentItem?.id == item.id && showDetailPage ? 1 : 0.93)
                    }
                    .buttonStyle(ScaledButtonStyle())
                    .opacity(showDetailPage ? (currentItem?.id == item.id ? 1 : 0) : 1)

                }
            }
            .padding(.vertical)
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
                .scaleEffect(animateView ? 1: 0.93)
                .opacity(animateView ? 1: 0)
                .ignoresSafeArea()
        }
    }
    
    @ViewBuilder
    func CardView(item: Today) -> some View {
        VStack(alignment: .leading, spacing: 15) {
            ZStack(alignment: .topLeading) {
                GeometryReader { proxy in
                    let size = proxy.size
                    Image(item.artwordk)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .clipShape(CustomCornerns(corners: [.topLeft, .topRight],
                                                  radius: 15))
                }
                .frame(height: 400)
                
                LinearGradient(colors: [
                    .black.opacity(0.7),
                    .black.opacity(0.2),
                    .clear
                ], startPoint: .top, endPoint: .bottom)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(item.platformTitle.uppercased())
                        .font(.callout)
                        .fontWeight(.semibold)
                        
                    Text(item.bannerTitle)
                        .font(.largeTitle.bold())
                        .multilineTextAlignment(.leading)
                }
                .foregroundColor(.primary)
                .padding()
                .offset(y: currentItem?.id == item.id && animateView ? safeArea().top : 0)
            }
            HStack(spacing: 12) {
                Image(item.appLogo)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 15,
                                                style: .continuous))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.platformTitle.uppercased())
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(item.appName)
                        .fontWeight(.bold)
                    Text(item.appDescription)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
                Button {
                    //
                } label: {
                    Text("GET")
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 28)
                        .background(
                            Capsule()
                                .fill(.ultraThinMaterial)
                        )
                }

            }
            .padding([.horizontal, .bottom])
        }
        .background(
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color("BG"))
        )
        .matchedGeometryEffect(id: item.id, in: animation)
    }
    
    func DetailView(item: Today) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                CardView(item: item)
                    .scaleEffect(animateView ? 1 : 0.93)
            }
        }
        .overlay(alignment: .topTrailing, content: {
            Button {
                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                    animateView = false
                }
                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7).delay(0.95)) {
                    currentItem = nil
                    showDetailPage = false
                }
                
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .foregroundColor(.white)
            }
            .padding()
            .padding(.top, safeArea().top)
            .offset(y: -10)
            .opacity(animateView ? 1 : 0)

        })
        .onAppear {
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                animateView = true
            }
        }
        .transition(.identity)
    }
    
}

struct HeroAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        HeroAnimationView()
            .preferredColorScheme(.dark)
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
    func safeArea() -> UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        guard let safeArea = screen.windows.first?.safeAreaInsets
        else { return .zero }
        return safeArea
    }
}
