import UIKit
import SwiftUI
import PlaygroundSupport

// MARK: - UIKit: Dynamic UICollectionView Example

// Define a custom UICollectionViewCell
class CustomCell: UICollectionViewCell {
    static let identifier = "CustomCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
        
        let label = UILabel(frame: bounds)
        label.text = "Item"
        label.textColor = .white
        label.textAlignment = .center
        addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// Create a basic UICollectionView layout
let layout = UICollectionViewFlowLayout()
layout.itemSize = CGSize(width: 100, height: 100)
layout.minimumInteritemSpacing = 10
layout.minimumLineSpacing = 10

// Create UICollectionView
let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 400, height: 400), collectionViewLayout: layout)
collectionView.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.identifier)
collectionView.backgroundColor = .lightGray

// Set up the data source
let data = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]

// Set data source and delegate
class DataSource: NSObject, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCell.identifier, for: indexPath) as! CustomCell
        return cell
    }
}

let dataSource = DataSource()
collectionView.dataSource = dataSource

// MARK: - SwiftUI: Dynamic LazyVStack Example

struct ContentView: View {
    let items = Array(1...1000).map { "Item \($0)" }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(items, id: \.self) { item in
                    Text(item)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.bottom, 5)
                }
            }
        }
    }
}

// Display SwiftUI view
PlaygroundPage.current.setLiveView(ContentView())

// MARK: - UIKit: Dynamically Adding Views at Runtime

class DynamicViewController: UIViewController {
    var count = 0
    var dynamicView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Button to add a new view dynamically
        let addButton = UIButton(frame: CGRect(x: 100, y: 50, width: 200, height: 50))
        addButton.setTitle("Add View", for: .normal)
        addButton.backgroundColor = .blue
        addButton.addTarget(self, action: #selector(addView), for: .touchUpInside)
        view.addSubview(addButton)
    }
    
    @objc func addView() {
        count += 1
        dynamicView?.removeFromSuperview() // Remove previous view if exists
        
        dynamicView = UIView(frame: CGRect(x: 100, y: 100 + count * 60, width: 200, height: 50))
        dynamicView?.backgroundColor = .green
        if let dynamicView = dynamicView {
            view.addSubview(dynamicView)
        }
    }
}

// Show DynamicViewController
PlaygroundPage.current.liveView = DynamicViewController()
