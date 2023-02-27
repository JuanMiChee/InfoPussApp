//
//  CatsMainView.swift
//  InfoPussApp
//
//  Created by Juan Harrington on 26/02/23.
//

import SwiftUI

struct CatsMainView: View {
    
    @StateObject var viewModel: CatsMainViewModel
    
    var body: some View {
        VStack{
            ScrollView{
                ForEach(viewModel.viewContent, id: \.self) { index in
                    VStack(alignment: .leading){
                        Text(index.name)
                        AsyncImage(url: URL(string: index.vetstreet_url)) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .scaledToFit()
                            } else if phase.error != nil {
                                //i could not find the image URL so sorry :C We should add the URL just in there, or give us the format you would like to use (JPG etc. i didn't know how to  make fit the "Reference_Image_id" with ist endpoint. apologizes about that
                                Text("Where is the imageURL???")
                            } else {
                                ProgressView()
                            }
                        }
                        .padding(.vertical)
                        HStack{
                            VStack{
                                Text("Origin Country:")
                                Text(index.origin)
                            }
                            Spacer()
                            VStack{
                                Text("Intelligence:")
                                Text("\(index.intelligence)")
                            }
                            
                        }
                    }
                    .padding()
                    .background(Color(red: 240/255, green: 240/255, blue: 240/255))
                    .border(.gray)
                    .padding(.horizontal)
                    .padding(.bottom)
                    
                }
            }
        }
        .onAppear{
            Task{
                await viewModel.getCats()
            }
        }
    }
}

//struct CatsMainView_Previews: PreviewProvider {
//    static var previews: some View {
//        CatsMainView(viewModel: CatsMainViewModel(service: ))
//    }
//}
