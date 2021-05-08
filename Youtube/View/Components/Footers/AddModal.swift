//
//  AddModal.swift
//  Youtube
//
//  Created by ozan honamlioglu on 8.05.2021.
//

import SwiftUI

enum DragDirection: String {
    case top, bottom, none
}

struct AddModal: View {
    @State var modalPosition: CGFloat = UIScreen.main.bounds.height + (UIScreen.main.bounds.height / 2)
    @State var bgOpacity: Double = 0.0
    @Binding var open: Bool
    
    @State var dragStarted: Bool = false
    @State var direction: DragDirection = .bottom
    @State var startPosition: CGFloat = 0
    
    func closeModal() {
        modalPosition = UIScreen.main.bounds.height + (UIScreen.main.bounds.height / 2)
        bgOpacity = 0.0
        direction = .none
        
        // animation finish
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            open = false
        }
    }
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { val in

                dragStarted = true
                
                if(val.location.y < startPosition) {
                    // dragging up
                    modalPosition -= 0.5
                    direction = .top
                    
                } else {
                    // dragging down
                    modalPosition += 0.5
                    direction = .bottom
                }
                
                startPosition = val.location.y
                
            }
            .onEnded { val in
                dragStarted = false
                if direction == .top {
                    modalPosition = UIScreen.main.bounds.height + (UIScreen.main.bounds.height / 2) - 200
                } else if direction == .bottom {
                    modalPosition = UIScreen.main.bounds.height + (UIScreen.main.bounds.height / 2) - 200
                }
            }
    }
    
    var body: some View {
        ZStack {
            
            Color.black.opacity(bgOpacity)
                .onTapGesture(count: 1, perform: {
                    closeModal()
                })
                .animation(.linear(duration: 0.2))
            

            VStack {
                HStack {
                    Text("Create")
                    
                    Spacer()
                    
                    Button(action: {
                        closeModal()
                    }, label: {
                        Image(systemName: "xmark")
                            .font(.headline)
                    })
                }
                .padding(.top)
                .padding(.horizontal)
                
                VStack(spacing: 20) {
                    Button(action: {}, label: {
                        HStack() {
                            ZStack {
                                Circle()
                                    .frame(width: 35, height: 35, alignment: .center)
                                    .foregroundColor(.gray)
                                
                                Image(systemName: "square.and.arrow.up")
                            }
                            
                            Text("Upload Video")
                        }.frame(width: UIScreen.main.bounds.width - 30, alignment: .leading)
                    })
                    Button(action: {}, label: {
                        HStack {
                            ZStack {
                                Circle()
                                    .frame(width: 35, height: 35, alignment: .center)
                                    .foregroundColor(.gray)
                                
                                Image(systemName: "dot.radiowaves.left.and.right")
                            }
                            
                            Text("Start Streaming")
                        }.frame(width: UIScreen.main.bounds.width - 30, alignment: .leading)
                    })
                }.padding(.vertical)
                
                Spacer()
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .background(RoundedCorners(color: Color("addModal"), tl: 15, tr: 15, bl: 0, br: 0))
            .position(CGPoint( x: UIScreen.main.bounds.width / 2, y: modalPosition ))
            .animation(dragStarted ? .none : .linear(duration: 0.2))
            .foregroundColor(.white)
            .gesture(drag)
            // .animation(.interpolatingSpring(mass: 0.1, stiffness: 2, damping: 0.7, initialVelocity: 3))

        }
        .edgesIgnoringSafeArea(.all)
        .onAppear(perform: {
            modalPosition = UIScreen.main.bounds.height + (UIScreen.main.bounds.height / 2) - 200
            bgOpacity = 0.5
        })

    }
}

struct AddModal_Previews: PreviewProvider {
    static var previews: some View {
        AddModal(open: .constant(false))
    }
}
