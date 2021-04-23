//
//  WiiMenuView.swift
//  Wii Menu
//
//  Created by João Gabriel Pozzobon dos Santos on 21/04/21.
//

import SwiftUI

struct WiiMenuView: View {
    @State var cursorLocation = CGPoint(x: 960/2, y: 540/2)
    
    private var items: [Channel] = [Channel(disabled: false, imageName: "Finder", colors: [Color.white, Color(#colorLiteral(red: 0.7726274133, green: 0.8513433933, blue: 0.9158047438, alpha: 1))]),
                                    Channel(disabled: false, imageName: "App Store", colors: [Color(#colorLiteral(red: 0.7726274133, green: 0.8513433933, blue: 0.9158047438, alpha: 1)), Color(#colorLiteral(red: 0.5751777291, green: 0.6412175298, blue: 0.8295611739, alpha: 1))]),
                                    Channel(disabled: false, imageName: "Photos", colors: [Color.white, Color(#colorLiteral(red: 0.9196743369, green: 0.8816582561, blue: 0.8557353616, alpha: 1))]),
                                    Channel(), Channel(), Channel(), Channel(), Channel(), Channel(), Channel(), Channel(), Channel()]
    private var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var hourFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "h"
        return formatter
    }
    
    var minutesFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "mm"
        return formatter
    }
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE dd/MM"
        return formatter
    }
    
    var body: some View {
        ZStack {
            background
                .trackingMouse { location in
                    self.cursorLocation = location
                }.onHover { hovering in
                    if hovering {
                        NSCursor.hide()
                    } else {
                        NSCursor.unhide()
                    }
                }
            
            channels
            footer
            
            CursorView()
                .clipped()
                .shadow(color: Color.gray.opacity(0.35), radius: 0, x: 3, y: 3)
                .position(cursorLocation)
            
            //Image("reference").resizable().frame(width: 960, height: 540).opacity(0.2)
        }
    }
    
    var background: some View {
        ZStack {
            Rectangle().fill(ImagePaint(image: Image(decorative: CGImage.stripes(colors: (#colorLiteral(red: 0.9254901961, green: 0.9254901961, blue: 0.9254901961, alpha: 1), #colorLiteral(red: 0.8941176471, green: 0.8941176471, blue: 0.8941176471, alpha: 1)), width: 1, ratio: 2), scale: 0.6))).rotationEffect(.init(degrees: 90)).aspectRatio(contentMode: .fill)
            Rectangle().fill(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9371625781, green: 0.9373195171, blue: 0.9371418357, alpha: 1)).opacity(0), Color(#colorLiteral(red: 0.9371625781, green: 0.9373195171, blue: 0.9371418357, alpha: 1)), Color(#colorLiteral(red: 0.9371625781, green: 0.9373195171, blue: 0.9371418357, alpha: 1)).opacity(0)]), startPoint: .init(x: 0.3, y: 0), endPoint: .init(x: 0.7, y: 0)))
        }
    }
    
    var channels: some View {
        LazyVGrid(
            columns: columns,
            spacing: 14
        ) {
            ForEach(items, id: \.self) { item in
                ChannelView(channel: item)
            }
        }.padding(.horizontal, 80)
        .padding(.bottom, 116)
    }
    
    var footer: some View {
        GeometryReader { geo in
            VStack {
                Spacer()
                ZStack {
                    BottomSheet().fill(Color(#colorLiteral(red: 0.6916888952, green: 0.7093482614, blue: 0.7330204248, alpha: 1)))
                    BottomSheet().fill(Color(#colorLiteral(red: 0.8300312161, green: 0.8416284919, blue: 0.8709446788, alpha: 1))).offset(y: 10).blur(radius: 8)
                    BottomSheet().stroke(Color(#colorLiteral(red: 0.3725490196, green: 0.737254902, blue: 0.9098039216, alpha: 1)), lineWidth: 3.0)
                    
                    dateAndTime
                    
                    HStack {
                        MenuGear(systemName: "applelogo", alignment: .trailing)
                            .offset(x: -geo.size.width/2.9)
                        Spacer()
                        MenuGear(systemName: "envelope.fill", alignment: .leading)
                            .offset(x: geo.size.width/2.9)
                    }.frame(height: 104/540*geo.size.height)
                }.frame(width: geo.size.width, height: 148/540*geo.size.height)
            }
        }
    }
    
    var dateAndTime: some View {
        VStack(spacing: 21) {
            HStack(spacing: 0) {
                Spacer()
                Text(Date(), formatter: hourFormatter)
                Text(":")
                    .opacity(Calendar.current.component(.second, from: Date()) % 2 == 0 ? 1 : 0)
                Text(Date(), formatter: minutesFormatter)
                Spacer()
            }.font(Font.custom("DSEG7 Classic Mini", size: 42).weight(.bold))
            .foregroundColor(Color(#colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1)))
            .frame(width: 175)
            
            Text(Date(), formatter: dateFormatter)
                .font(.system(size: 37, weight: .bold))
                .foregroundColor(Color(#colorLiteral(red: 0.5098039216, green: 0.5098039216, blue: 0.5098039216, alpha: 1)))
            
            Spacer()
        }
    }
}

struct MenuGear: View {
    let systemName: String
    let alignment: Alignment
    
    var body: some View {
        ZStack(alignment: alignment) {
            Capsule().fill(Color(#colorLiteral(red: 0.8300312161, green: 0.8416284919, blue: 0.8709446788, alpha: 1)))
            Capsule().stroke(Color(#colorLiteral(red: 0.6916888952, green: 0.7093482614, blue: 0.7330204248, alpha: 1)), lineWidth: 3.5)
            GearButton(systemName: systemName)
            .padding(9)
            .offset(y: -9)
        }
    }
}

struct GearButton: View {
    let systemName: String
    
    @State var over = false
    
    var body: some View {
        ZStack {
            Circle().fill(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.8943449259, green: 0.9068402648, blue: 0.9384284616, alpha: 1)), Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))]), startPoint: .topLeading, endPoint: .center))
                .shadow(color: Color.gray.opacity(0.2), radius: 0, x: 6, y: 8)
            Circle().fill(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.8941176471, green: 0.8941176471, blue: 0.8941176471, alpha: 1)), Color(#colorLiteral(red: 0.8329629302, green: 0.8280120492, blue: 0.8367689848, alpha: 1))]), startPoint: .center, endPoint: .bottomTrailing)).scaleEffect(0.75).offset(x: -14, y: -14).mask(Circle().scaleEffect(0.85))
            Circle().stroke(Color(#colorLiteral(red: 0.3725490196, green: 0.737254902, blue: 0.9098039216, alpha: 1)), lineWidth: 2.5)
        }.aspectRatio(contentMode: .fit)
        .overlay(Image(systemName: systemName)
                    .font(.system(size: 45, weight: .bold))
                    .foregroundColor(Color(#colorLiteral(red: 0.6342203617, green: 0.6581591964, blue: 0.6795070171, alpha: 1))).offset(y: -2))
        .scaleEffect(over ? 1.1 : 1.0)
        .onHover(perform: { hovering in
            withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                over = hovering
            }
        })
    }
}

func launchApp(identifier: String) {
    guard let url = NSWorkspace.shared.urlForApplication(withBundleIdentifier: identifier) else { return }

    let path = "/bin"
    let configuration = NSWorkspace.OpenConfiguration()
    configuration.arguments = [path]
    NSWorkspace.shared.openApplication(at: url,
                                       configuration: configuration,
                                       completionHandler: nil)
}

struct BottomSheet: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let curveInset: CGFloat = 0.15
        let curveSize: CGFloat = 0.21
        let curveDepth: CGFloat = 0.4
        let curveControl: CGFloat = 0.13

        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        
        path.addLine(to: CGPoint(x: rect.width*curveInset, y: rect.minY))
        path.addCurve(to: CGPoint(x: rect.width*(curveInset+curveSize), y: rect.height*curveDepth), control1: CGPoint(x: rect.width*(curveInset+curveControl), y: rect.minY), control2: CGPoint(x: rect.width*(curveInset+curveSize-curveControl), y: rect.height*curveDepth))
        
        path.addLine(to: CGPoint(x: rect.width*(1-curveInset-curveSize), y: rect.height*curveDepth))
        path.addCurve(to: CGPoint(x: rect.width*(1-curveInset), y: rect.minY), control1: CGPoint(x: rect.width*(1-curveInset-curveSize+curveControl), y: rect.height*curveDepth), control2: CGPoint(x: rect.width*(1-curveInset-curveControl), y: rect.minY))
        
        path.addLine(to: CGPoint(x: rect.width*0.85, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()

        return path
    }
}

struct WiiMenu_Previews: PreviewProvider {
    static var previews: some View {
        WiiMenuView()
    }
}
