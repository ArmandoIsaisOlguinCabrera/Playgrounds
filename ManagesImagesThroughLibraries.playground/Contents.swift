import SwiftUI
import Kingfisher

struct ImageWithTransitionView: View {
    let imageURL = URL(string: "https://picsum.photos/400")!
    
    var body: some View {
        VStack(spacing: 16) {
            KFImage(imageURL)
                .placeholder {
                    // ⏳ Placeholder shown while image loads
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .frame(width: 80, height: 80)
                }
                .setProcessor(DownsamplingImageProcessor(size: CGSize(width: 200, height: 200)))
                .cancelOnDisappear(true)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 250, height: 250)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(radius: 5)
                .kfImageModifier { image in
                    image
                }
                .onSuccess { result in
                    print("✅ Loaded image from \(result.cacheType == .none ? "network" : "cache")")
                }
                .onFailure { error in
                    print("❌ Error loading image: \(error)")
                }
                .transition(.flipFromLeft(0.6)) // 💫 Transition added here
                .animation(.easeInOut(duration: 0.6), value: UUID()) // Triggers animation

            Text("Image loaded with animated transition")
                .font(.caption)
        }
        .padding()
    }
}
