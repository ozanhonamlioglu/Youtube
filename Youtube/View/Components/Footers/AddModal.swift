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

enum AnimationPositionStatus: String {
    case open, closed, waiting
}

struct AddModal: View {
    @State var modalPosition: CGFloat = UIScreen.main.bounds.height + (UIScreen.main.bounds.height / 2)
    @State var bgOpacity: Double = 0.0
    @Binding var open: Bool {
        didSet {
            animPositionStatus = .open
        }
    }
    
    @State var dragStarted: Bool = false
    @State var direction: DragDirection = .bottom
    @State var startPosition: CGFloat = 0
    @State var animPositionStatus: AnimationPositionStatus = .closed
    var animationDuration = 0.2
    
    func closeModal() {
        withAnimation(.easeIn(duration: animationDuration)) {
            modalPosition = UIScreen.main.bounds.height + (UIScreen.main.bounds.height / 2)
            bgOpacity = 0.0
            direction = .none
            animPositionStatus = .waiting
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
                withAnimation(.easeIn(duration: 0.1)) {
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
                .animation(.linear(duration: animationDuration))
            

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
                            Image(systemName: "square.and.arrow.up")
                                .surroundWithCircle(circleSize: 35)
                            Text("Upload Video")
                        }.frame(width: UIScreen.main.bounds.width - 30, alignment: .leading)
                    })
                    Button(action: {}, label: {
                        HStack {
                            Image(systemName: "dot.radiowaves.left.and.right")
                                .surroundWithCircle(circleSize: 35)
                            Text("Start Streaming")
                        }.frame(width: UIScreen.main.bounds.width - 30, alignment: .leading)
                    })
                }.padding(.vertical)
                
                Spacer()
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .background(RoundedCorners(color: Color("addModal"), tl: 15, tr: 15, bl: 0, br: 0))
            .position(CGPoint( x: UIScreen.main.bounds.width / 2, y: modalPosition ))
            .foregroundColor(.white)
            .gesture(drag)
            .onAnimationCompleted(for: modalPosition) {
                // run here only for close the animation
                if animPositionStatus == .waiting {
                    animPositionStatus = .closed
                    open = false
                }
            }

        }
        .edgesIgnoringSafeArea(.all)
        .onAppear(perform: {
            withAnimation(.easeIn(duration: animationDuration)) {
                modalPosition = UIScreen.main.bounds.height + (UIScreen.main.bounds.height / 2) - 200
                bgOpacity = 0.5
            }
        })

    }
}

struct AddModal_Previews: PreviewProvider {
    static var previews: some View {
        AddModal(open: .constant(false))
    }
}
