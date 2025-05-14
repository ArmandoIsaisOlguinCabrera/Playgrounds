import Foundation

// MARK: Tree and Graph

// Tree (Hierarchical and Acyclic)
class TreeNode {
    var value: Int
    var children: [TreeNode] = []
    
    init(_ value: Int) {
        self.value = value
    }
}

// Graph (General, can be cyclic, multiple connections)
class GraphNode {
    var value: Int
    var neighbors: [GraphNode] = []
    
    init(_ value: Int) {
        self.value = value
    }
}

// MARK: Binary Tree vs Binary Search Tree

// Binary Tree Node (Simple tree with no ordering)
class BinaryTreeNode {
    var value: Int
    var left: BinaryTreeNode?
    var right: BinaryTreeNode?
    
    init(_ value: Int) {
        self.value = value
    }
}

// Binary Search Tree (BST - Ordered tree where left subtree < node, right subtree > node)
class BST {
    var root: BinaryTreeNode?
    
    // Insert a new value into the BST
    func insert(_ value: Int) {
        root = insertHelper(root, value)
    }
    
    private func insertHelper(_ node: BinaryTreeNode?, _ value: Int) -> BinaryTreeNode {
        // If node is nil, create a new node with the given value
        guard let node = node else { return BinaryTreeNode(value) }
        
        if value < node.value {
            // Insert in the left subtree if value is smaller than the current node's value
            node.left = insertHelper(node.left, value)
        } else {
            // Insert in the right subtree if value is greater than the current node's value
            node.right = insertHelper(node.right, value)
        }
        
        return node
    }
    
    // In-order traversal (DFS) to print node values in ascending order
    func inorder(_ node: BinaryTreeNode?) {
        guard let node = node else { return }
        inorder(node.left)   // Traverse left subtree
        print(node.value)     // Visit node
        inorder(node.right)  // Traverse right subtree
    }
}

// Create a Binary Search Tree (BST) and insert values
let bst = BST()
[5, 3, 7, 2, 4, 6, 8].forEach { bst.insert($0) }
print("BST In-Order Traversal (DFS):")
bst.inorder(bst.root)

// MARK: Breadth-First Search (BFS) and Depth-First Search (DFS)

/// Breadth-First Search (BFS) - Explores all nodes level by level (using a queue)
func bfs(start: GraphNode) {
    var visited: Set<ObjectIdentifier> = []  // To track visited nodes
    var queue: [GraphNode] = [start]         // Queue to process nodes in BFS order
    
    while !queue.isEmpty {
        let node = queue.removeFirst()  // Dequeue node
        let id = ObjectIdentifier(node)
        if visited.contains(id) { continue }  // Skip if already visited
        visited.insert(id)
        print("Visited (BFS):", node.value)  // Visit the node
        queue.append(contentsOf: node.neighbors)  // Enqueue neighbors
    }
}

/// Depth-First Search (DFS) - Explores as deep as possible along a path before backtracking (using recursion)
func dfs(start: GraphNode) {
    var visited: Set<ObjectIdentifier> = []  // To track visited nodes
    dfsHelper(start, &visited)
}

/// Helper function for DFS, recursively visits neighbors
func dfsHelper(_ node: GraphNode, _ visited: inout Set<ObjectIdentifier>) {
    let id = ObjectIdentifier(node)
    if visited.contains(id) { return }  // Skip if already visited
    visited.insert(id)
    print("Visited (DFS):", node.value)  // Visit the node
    for neighbor in node.neighbors {
        dfsHelper(neighbor, &visited)  // Recursively visit neighbors
    }
}

// Create a sample undirected graph
let a = GraphNode(1)
let b = GraphNode(2)
let c = GraphNode(3)
let d = GraphNode(4)

a.neighbors = [b, c]  // Node a is connected to b and c
b.neighbors = [a, d]  // Node b is connected to a and d
c.neighbors = [a]     // Node c is connected to a
d.neighbors = [b]     // Node d is connected to b

print("\nGraph Traversal (BFS):")
bfs(start: a)  // Perform BFS starting from node a

print("\nGraph Traversal (DFS):")
dfs(start: a)  // Perform DFS starting from node a

// MARK: - 4. AVL Tree (Balanced Tree)

// AVL Tree Node - It stores a value and balance information (height)
class AVLTreeNode {
    var value: Int
    var left: AVLTreeNode?
    var right: AVLTreeNode?
    var height: Int
    
    init(_ value: Int) {
        self.value = value
        self.height = 1  // Initially, height of a node is 1
    }
}

// AVL Tree with insertion and balancing
class AVLTree {
    var root: AVLTreeNode?
    
    // Insert a value into the AVL tree
    func insert(_ value: Int) {
        root = insertHelper(root, value)
    }
    
    // Helper function to insert a node and balance the tree
    private func insertHelper(_ node: AVLTreeNode?, _ value: Int) -> AVLTreeNode {
        guard let node = node else { return AVLTreeNode(value) }
        
        if value < node.value {
            node.left = insertHelper(node.left, value)  // Insert in the left subtree
        } else if value > node.value {
            node.right = insertHelper(node.right, value)  // Insert in the right subtree
        } else {
            return node  // No duplicates allowed in AVL
        }
        
        // Update the height of the node
        node.height = 1 + max(height(node.left), height(node.right))
        
        // Balance the tree after insertion
        let balance = getBalance(node)
        
        // Left heavy tree
        if balance > 1 && value < node.left!.value {
            return rotateRight(node)
        }
        
        // Right heavy tree
        if balance < -1 && value > node.right!.value {
            return rotateLeft(node)
        }
        
        // Left-Right heavy tree
        if balance > 1 && value > node.left!.value {
            node.left = rotateLeft(node.left!)
            return rotateRight(node)
        }
        
        // Right-Left heavy tree
        if balance < -1 && value < node.right!.value {
            node.right = rotateRight(node.right!)
            return rotateLeft(node)
        }
        
        return node
    }
    
    // Helper function to get the height of a node
    private func height(_ node: AVLTreeNode?) -> Int {
        return node?.height ?? 0
    }
    
    // Helper function to get the balance factor of a node
    private func getBalance(_ node: AVLTreeNode) -> Int {
        return height(node.left) - height(node.right)
    }
    
    // Right rotation for balancing the tree
    private func rotateRight(_ y: AVLTreeNode) -> AVLTreeNode {
        let x = y.left!
        let T2 = x.right
        
        // Perform rotation
        x.right = y
        y.left = T2
        
        // Update heights
        y.height = max(height(y.left), height(y.right)) + 1
        x.height = max(height(x.left), height(x.right)) + 1
        
        return x
    }
    
    // Left rotation for balancing the tree
    private func rotateLeft(_ x: AVLTreeNode) -> AVLTreeNode {
        let y = x.right!
        let T2 = y.left
        
        // Perform rotation
        y.left = x
        x.right = T2
        
        // Update heights
        x.height = max(height(x.left), height(x.right)) + 1
        y.height = max(height(y.left), height(y.right)) + 1
        
        return y
    }
}

// Example of AVL tree insertion and balancing
let avl = AVLTree()
avl.insert(10)
avl.insert(20)
avl.insert(30)  // This should trigger a left rotation to balance the tree
