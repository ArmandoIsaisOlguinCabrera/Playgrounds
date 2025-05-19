import UIKit
import CoreImage

class ImageHandler {
    
    // MARK: - Apply Sepia Filter to UIImage
    func applySepiaFilter(to image: UIImage) -> UIImage? {
        // Convert UIImage to CIImage for Core Image processing
        guard let ciImage = CIImage(image: image) else { return nil }
        
        // Create sepia filter and set input parameters
        let filter = CIFilter(name: "CISepiaTone")
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        filter?.setValue(1.0, forKey: kCIInputIntensityKey)
        
        // Get the filtered output
        guard let outputCIImage = filter?.outputImage else { return nil }
        
        // Convert filtered CIImage back to UIImage
        let context = CIContext()
        guard let cgImage = context.createCGImage(outputCIImage, from: outputCIImage.extent) else { return nil }
        
        return UIImage(cgImage: cgImage)
    }
    
    // MARK: - Generate an Image Programmatically (a circle)
    func generateCircleImage(radius: CGFloat, color: UIColor) -> UIImage {
        let size = CGSize(width: radius * 2, height: radius * 2)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()!
        
        color.setFill()
        context.fillEllipse(in: CGRect(origin: .zero, size: size))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image ?? UIImage()
    }
    
    // MARK: - Test Method
    func runDemo() {
        // Load an image (use your own if not in Playground)
        guard let originalImage = UIImage(systemName: "photo") else {
            print("❌ Could not load test image.")
            return
        }
        
        // Apply filter
        if let sepiaImage = applySepiaFilter(to: originalImage) {
            print("✅ Sepia filter applied.")
            // You can preview this in Playground's live view with UIImageView
        } else {
            print("❌ Failed to apply filter.")
        }
        
        // Generate image
        let circleImage = generateCircleImage(radius: 50, color: .systemPink)
        print("✅ Generated circle image.")
        
        // Preview (Playground or Xcode)
        showImages(original: originalImage, filtered: sepiaImage, generated: circleImage)
    }
    
    // MARK: - Preview with UIImageViews (for Playground)
    func showImages(original: UIImage, filtered: UIImage?, generated: UIImage) {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 10
        
        let imageViews = [
            makeImageView(for: original, label: "Original"),
            makeImageView(for: filtered ?? original, label: "Filtered"),
            makeImageView(for: generated, label: "Generated")
        ]
        
        imageViews.forEach { stack.addArrangedSubview($0) }
        
        import PlaygroundSupport
        PlaygroundPage.current.liveView = stack
    }
    
    private func makeImageView(for image: UIImage, label: String) -> UIView {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let labelView = UILabel()
        labelView.text = label
        labelView.textAlignment = .center
        labelView.font = UIFont.systemFont(ofSize: 12)
        
        let stack = UIStackView(arrangedSubviews: [imageView, labelView])
        stack.axis = .vertical
        stack.alignment = .center
        return stack
    }
}

// Execute playground
let handler = ImageHandler()
handler.runDemo()
