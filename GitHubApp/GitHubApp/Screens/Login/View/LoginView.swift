//
//  LoginView.swift
//  GitHubApp
//
//  Created by Ihor Ilin on 16.04.2025.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    var body: some View {
        VStack {
            Image("GitHubIcon")
                .resizable()
                .frame(width: 90, height: 90)
            
            Text("Sign in to GitHubApp")
                .font(.system(size: 28))
                .padding()
            
            Text("Authorize GitHubApp to access your GitHub account")
                .font(.system(size: 15))
                .foregroundStyle(.black.opacity(0.8))
                .lineLimit(nil)
                .multilineTextAlignment(.center)
                .padding(.bottom)
            
            Button {
                viewModel.login()
            } label: {
                HStack {
                    Image("GitHubIcon")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("Continue with GitHub")
                }
                .tint(.white)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.green)
                }
            }
            
        }
        .padding(.horizontal, 20)
        .alert("Access token received!", isPresented: $viewModel.showAlert) {
            Text("Token = \(viewModel.token)")
            Button("Ok") {
                
            }
        }
    }
}

#Preview {
    LoginView()
}
