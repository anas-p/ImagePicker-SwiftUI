
import SwiftUI

/// This view shows a Image view and a Button,
/// Tap on both views will display an action sheet to choose image picker
///
struct ContentView: View {
    
    @State private var showImagePickerOptions: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var sourceType = UIImagePickerController.SourceType.photoLibrary
    @State private var photo:UIImage?

    var body: some View {
        VStack {
            
            Image(uiImage: self.photo ?? UIImage(named: "Placeholder")!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 200)
                .cornerRadius(100)
                .overlay(RoundedRectangle(cornerRadius: 100).stroke(Color.secondary, lineWidth: 1))
                .shadow(radius: 10)
                .contentShape(Circle())
                .onTapGesture {
                    showImagePickerOptions = true
                }
                .padding(.top, 60)
            
            
            Button(Localization.addPhotoTitle, action: {
                showImagePickerOptions = true
            })
                .font(.system(size: 17))
                .frame(width: 200, height: 50, alignment: .center)
                .background(Color.blue)
                .foregroundColor(Color.white)
                .cornerRadius(10)
                .padding(.top, 40)
                .ActionSheet(showImagePickerOptions: $showImagePickerOptions, showImagePicker: $showImagePicker, sourceType: $sourceType)

            Spacer()
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: self.$photo, isShown: self.$showImagePicker, sourceType: self.sourceType)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// MARK: - Localization

private enum Localization {
    static let addPhotoTitle = NSLocalizedString("Add Photo", comment: "Button title for Add Photo")
}
