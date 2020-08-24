//
//  ContentView.swift
//  SwiftUIWorkShop

import SwiftUI

struct ContentView: View {
    @State var number = 1
    @State var isShowAlert = false
    @State var logos: [Logo] = [
        Logo(image: Image.appleLogo,
             text: Text("Continue with Apple")
                .foregroundColor(Color.appleColor)
        ),
        
        Logo(image: Image.googleLogo,
             text: Text("Continue with Google")
                .foregroundColor(Color.googleColor)
        ),
        
        Logo(image: Image.facebookLogo,
             text: Text("Continue with Facebook")
                .foregroundColor(Color.facebookColor)
        ),
        
        Logo(image: Image.twitterLogo,
             text: Text("Continue with Twitter")
                .foregroundColor(Color.twitterColor)
        ),
        
    ]
    
    func addLogo() {
        isShowAlert = true
        self.logos.append(
            Logo(image: Image.appleLogo, text: Text("New Apple"))
        )
    }
    
    var body: some View {
        NavigationView {
            contentView
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarHidden(true)
                .alert(isPresented: $isShowAlert, content: {
                    Alert(title: Text("Warning"), message: Text("Destail"), dismissButton: .default(Text("Done")))
                })
        }
    }
    
    private var contentView: some View {
        VStack(alignment: .leading) {
            skipButtonView()
            
            Spacer()
            Image.flipboardLogo
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
            
            Text.headerText
                .font(Font.system(size: 30, weight: .medium, design: .serif))
                .multilineTextAlignment(.leading)
            
            Spacer()
            Spacer()
            VStack(alignment: .leading, spacing: 30) {
                continueContainerView()
                footerView()
            }
            
            Spacer()
                .frame(height: 30)
        }
        .padding()
        .frame(minWidth: 0,
               maxWidth: .infinity,
               minHeight: 0,
               maxHeight: .infinity,
               alignment: .topLeading)
    }
    
    private func skipButtonView() -> some View {
        HStack {
            Spacer()
            Button(action: {}, label: {
                Text.skipText
                    .setSkipButtonStyle()
            })
        }
    }
    
    private func continueContainerView() -> some View {
        Group {
            ForEach(logos) { logo in
                Button(action: {}, label: {
                    HStack {
                        logo.image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                        Spacer()
                            .frame(width: 15)
                        logo.text
                            .font(.subheadline)
                            .fontWeight(.medium)
                    }
                })
            }
            
            Button(action: {
                self.addLogo()
            }, label: {
                HStack {
                    Image(systemName: "envelope.fill")
                        .foregroundColor(.white)
                    Spacer()
                    Text("Continue with Email \(number)")
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding()
            })
            .background(Color.primaryColor)
//            .background(LinearGradient(gradient: Gradient(colors: [Color(hex: "#EA1D25"), Color(hex: "#F99C2D")]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(5)
//            .shadow(color: .black, radius: 10, x: 1, y: 1)
        }
    }
    
    private func footerView() -> some View {
        VStack(alignment: .center, spacing: 20) {
            HStack(alignment: .center, spacing: 3) {
                Text("Already have an account?")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(Color.black.opacity(0.5))
                NavigationLink(
                    destination: LoginView(number: $number),
                    label: {
                        Text("Log In")
                            .underline()
                            .fontWeight(.medium)
                            .font(.subheadline)
                            .foregroundColor(Color.primaryColor)
                    })
            }
            
            (Text("By continuing, you accept the ")
                + Text("Terms of Use")
                    .underline()
                + Text(" and ")
                + Text("Privacy Policy")
                    .underline()
            )
            .multilineTextAlignment(.center)
            .font(.footnote)
            .foregroundColor(.gray)
        }
    }
}

struct Logo: Identifiable {
    var id: Int {
        return UUID().hashValue
    }
    
    var image: Image
    var text: Text
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
                .previewDisplayName("iPhone SE")
        }
    }
}

struct LoginView: View {
    @Binding var number: Int
    var body: some View {
        NavigationView {
            Text("Login")
                .onAppear {
                    number = 3
                }
                .navigationBarHidden(false)
        }
    }
}

struct SkipButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .foregroundColor(.gray)
            .padding([.leading, .trailing], 10)
            .padding([.top, .bottom], 5)
            .overlay(
                RoundedRectangle(cornerRadius: 5.0)
                    .strokeBorder(Color.gray)
            )
    }
}

extension Text {
    func setSkipButtonStyle() -> some View {
        self.fontWeight(.medium)
            .modifier(SkipButtonStyle())
    }
}
