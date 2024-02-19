//
//  ContentView.swift
//  SlideNumberPuzzle
//
//  Created by นางสาวสุภาพันธ์ หง่อสกุล on 10/2/2567 BE.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = NumberViewModel()
    
    let spacing = 4 as CGFloat
    let aspectRatio = 1 as CGFloat
    @State var showAlert = false
    
    func notificationReminder() -> Alert {
            Alert(
                title: Text("Congratulations"),
                message: Text("Total move: \(viewModel.count)"),
                dismissButton: .default(Text("New Game"), action: {
                                viewModel.shuffle()
                })
            )
        
    }
    
    var body: some View {
        ZStack {
            Image("bg")
                .resizable()
//                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                Text("Move: \(viewModel.count)")
                    .padding(10)
                    .background(Color("lightYellow"))
                    .cornerRadius(7)
                    .frame(maxWidth: .infinity, alignment: .trailing)
        
                AspectVGrid(items: viewModel.blocks, aspectRatio: aspectRatio) {
                    block in BlockView(block)
                        .padding(spacing)
                        .onTapGesture {
                            viewModel.choose(block)
                            showAlert = viewModel.isOrder
                        }
                        .animation(.default, value: viewModel.blocks)
                }
                
                Spacer()
                Button("Shuffle"){
                    withAnimation {
                        viewModel.shuffle()
                    }
                    
                }
                .foregroundColor(Color.black)
                .padding(5)
                .background(
                    RoundedRectangle(cornerRadius: 7)
                        .foregroundColor(.white)
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 30)
                        .blur(radius: 2)
                )
                .background(
                    RoundedRectangle(cornerRadius: 7)
                        .stroke(Color("lightYellow"), lineWidth: 15)
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 30)
                )
                
                .alert(isPresented: self.$showAlert, content: {
                    self.notificationReminder()
                })
            }
            .padding(.horizontal, 50)
            
        }
        .font(.custom("AmericanTypewriter",fixedSize: 20))
    }
}

struct BlockView: View{
    var block: SlideNumberModel<String>.Block
    init(_ block: SlideNumberModel<String>.Block) {
        self.block = block
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 10)
            Group {
                if !block.isSpace {
                    base.foregroundColor(Color.white)
                    base.stroke(Color("yellowFlower"), lineWidth: 3)
                    Text(block.content)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
