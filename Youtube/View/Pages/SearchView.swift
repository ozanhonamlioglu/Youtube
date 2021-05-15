//
//  SearchView.swift
//  Youtube
//
//  Created by ozan honamlioglu on 11.05.2021.
//

import SwiftUI

let searchPast = ["Test 1", "Test 2", "Test 3", "Test 4"]

struct SearchView: View {
    @Binding var showSearch: Bool
    @Binding var showSearchPage: Bool
    
    @State var editingEnd: Bool = true
    @State var q = ""
    
    var body: some View {
        ZStack {
            Color("primary").edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    SysImageButton(callback: {
                        showSearch = false
                    }, buttonImageName: "chevron.backward", activeButtonImageName: nil, active: nil, buttonLabel: nil)
                    
                    // CustomTextfield(placeholder: "Search", text: $searchText, editingEnd: $editingEnd)
                    CustomTextField(placeholder: "Search", text: $q, onEditingChanged: {status in}, onCommit: {
                        // when user hits the DONE button.
                        if (!q.isEmpty) {
                            showSearch = false
                            showSearchPage = true
                            searchManager.setQ(q: q)
                        }
                    })
                    .frame(maxWidth: UIScreen.main.bounds.width - 70, maxHeight: 30, alignment: .center)
                    .clipped()
                    
                    SysImageButton(callback: nil, buttonImageName: "mic", activeButtonImageName: nil, active: nil, buttonLabel: nil)
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 5)
                .onReceive(searchManager.q) { q in
                    self.q = q
                }
                
                Divider()

                ScrollView {
                    VStack {
                        ForEach(searchPast, id: \.self) { item in
                            
                            Button(action: {
                                q = item
                                searchManager.setQ(q: item)
                                UIApplication.shared.endEditing()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    // if user selects any item from the search history.
                                    self.showSearch = false
                                    self.showSearchPage = true
                                }
                            }, label: {
                                EmptyView()
                            })
                            .buttonStyle(StateableButton { state in
                                return HStack {
                                    Image(systemName: "clock.arrow.circlepath")
                                    Text(item)
                                    Spacer()
                                    Image(systemName: "arrow.up.backward")
                                }
                                .padding(.horizontal)
                                .frame(height: 50)
                                .background(state ? Color("searchItemButton") : Color.clear)
                                
                            })
                            
                        }.foregroundColor(Color("generalForeground"))
                    }
                }
                
                Spacer()
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("primary").edgesIgnoringSafeArea(.all)
            
            SearchView(showSearch: .constant(true), showSearchPage: .constant(false))
        }
        .preferredColorScheme(.dark)
    }
}

// This custom TextField implementation is only for this page
final class MyTextFieldCoordinator: NSObject {
    var control: CustomTextField

    init(_ control: CustomTextField) {
        self.control = control
        super.init()
        control.textField.addTarget(self, action: #selector(textFieldEditingDidBegin(_:)), for: .editingDidBegin)
        control.textField.addTarget(self, action: #selector(textFieldEditingDidEnd(_:)), for: .editingDidEnd)
        control.textField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        control.textField.addTarget(self, action: #selector(textFieldEditingDidEndOnExit(_:)), for: .editingDidEndOnExit)
        control.textField.autocorrectionType = .no
        customToolBar()
    }
    
    // setup custom toolbar
    func customToolBar() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: control.textField.frame.width, height: 44))
        let closeButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(closeAccessory))
        let flexibleButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolbar.setItems([flexibleButton, closeButton], animated: true)
        control.textField.inputAccessoryView = toolbar
        control.textField.translatesAutoresizingMaskIntoConstraints = true
    }

    @objc private func textFieldEditingDidBegin(_ textField: UITextField) {
        control.onEditingChanged(true)
    }

    @objc private func textFieldEditingDidEnd(_ textField: UITextField) {
        control.onEditingChanged(false)
    }

    @objc private func textFieldEditingChanged(_ textField: UITextField) {
        control.text = textField.text ?? ""
    }

    @objc private func textFieldEditingDidEndOnExit(_ textField: UITextField) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.control.onCommit()
        }
    }
    
    @objc func closeAccessory() {
        control.textField.resignFirstResponder()
    }
}

struct CustomTextField: UIViewRepresentable {

    private let placeholder: String?
    @Binding var text: String
    let onEditingChanged: (Bool) -> Void
    let onCommit: () -> Void
    let onCancel: () -> Void

    let textField = UITextField()

    init(placeholder: String?, text: Binding<String>, onEditingChanged: @escaping (Bool) -> Void = { _ in }, onCommit: @escaping () -> Void = {}, onCancel: @escaping () -> Void = {}) {
        self.placeholder = placeholder
        self._text = text
        self.onEditingChanged = onEditingChanged
        self.onCommit = onCommit
        self.onCancel = onCancel
    }

    func makeCoordinator() -> MyTextFieldCoordinator {
        return MyTextFieldCoordinator(self)
    }

    func makeUIView(context: Context) -> UITextField {
        textField.placeholder = placeholder
        textField.delegate = context.coordinator as? UITextFieldDelegate
        textField.returnKeyType = .done
        textField.becomeFirstResponder()
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
    }
}

extension UIApplication {
   func endEditing() {
       sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
   }
}

//struct CustomTextfield: UIViewRepresentable {
//    var placeholder: String
//    @Binding var text: String
//    @Binding var editingEnd: Bool
//
//    var textfield: UITextField {
//        let textfield = UITextField()
//        textfield.placeholder = placeholder
//        textfield.becomeFirstResponder()
//        textfield.returnKeyType = .done
//
//        return textfield
//    }
//
//    func makeUIView(context: Context) -> UITextField {
//        return textfield
//    }
//
//    func updateUIView(_ uiView: UITextField, context: Context) {
//        uiView.text = text
//    }
//}
