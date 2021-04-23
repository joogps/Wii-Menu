//
//  ChannelView.swift
//  Wii Menu
//
//  Created by João Gabriel Pozzobon dos Santos on 22/04/21.
//

import SwiftUI

struct ChannelView: View {
    let channel: Channel
    @State var over = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15.0, style: .continuous)
                .fill(LinearGradient(gradient: Gradient(colors: channel.colors), startPoint: .topLeading, endPoint: .bottomTrailing))
            
            if channel.disabled {
                RoundedRectangle(cornerRadius: 15.0, style: .continuous)
                    .fill(ImagePaint(image: Image(decorative: CGImage.random(bounds: CGRect(origin: .zero, size: CGSize(width: 186, height: 101))), scale: 1.5))).saturation(0.0).blendMode(.softLight)
                RoundedRectangle(cornerRadius: 15.0, style: .continuous)
                    .fill(ImagePaint(image: Image(decorative: CGImage.stripes(colors: (#colorLiteral(red: 0.8243320584, green: 0.819432795, blue: 0.8280988336, alpha: 0.8), .clear), width: 1, ratio: 2), scale: 0.6))).frame(width: 101, height: 186).rotationEffect(.init(degrees: 90)).frame(width: 186, height: 101)
                RoundedRectangle(cornerRadius: 15.0, style: .continuous)
                    .fill(ImagePaint(image: Image(decorative: CGImage.stripes(colors: (.clear, #colorLiteral(red: 0.8418509364, green: 0.8368471265, blue: 0.8456975818, alpha: 0.6978862636)), width: 1, ratio: 4), scale: 0.1))).frame(width: 101, height: 186).rotationEffect(.init(degrees: 90)).frame(width: 186, height: 101)
                
                Image(systemName: "applelogo")
                    .font(.system(size: 38))
                    .foregroundColor(.gray)
                    .opacity(0.3)
            } else {
                Image(channel.imageName ?? "")
                    .resizable().aspectRatio(contentMode: .fit)
                    .padding()
            }
            
            if over {
                RoundedRectangle(cornerRadius: 15.0, style: .continuous)
                    .stroke(Color(#colorLiteral(red: 0.3725490196, green: 0.737254902, blue: 0.9098039216, alpha: 1)), lineWidth: 3.0)
                    .transition(.asymmetric(insertion: .opacity, removal: AnyTransition.scale(scale: 0.9).combined(with: .opacity)))
                    .zIndex(2.0)
            } else {
                RoundedRectangle(cornerRadius: 15.0, style: .continuous).stroke(Color(#colorLiteral(red: 0.7058823529, green: 0.7058823529, blue: 0.7058823529, alpha: 1)), lineWidth: 2.5)
            }
        }.frame(width: 186, height: 101)
        .onHover(perform: { hovering in
            if !channel.disabled {
                withAnimation(hovering ? .easeInOut : .spring(response: 0.8, dampingFraction: 0.9)) {
                    over = hovering
                }
            }
        })
    }
}

struct Channel: Identifiable, Hashable {
    let id = UUID()
    
    var disabled: Bool = true
    var imageName: String? = nil
    var colors: [Color] = [Color(#colorLiteral(red: 0.6376565695, green: 0.6338686943, blue: 0.6405700445, alpha: 1)), Color(#colorLiteral(red: 0.5769771934, green: 0.5735504627, blue: 0.5796133876, alpha: 1))]
}

struct ChannelView_Previews: PreviewProvider {
    static var previews: some View {
        ChannelView(channel: Channel())
    }
}
