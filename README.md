[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Pods compatible](https://img.shields.io/cocoapods/v/EAKitAI.svg?style=flat)](https://cocoapods.org/pods/DSKitc)
[![SPM compatible](https://img.shields.io/badge/SPM-supported-DE5C43.svg?style=flat)](https://swift.org/package-manager)
[![Swift Version](https://img.shields.io/badge/swift-5.1-orange.svg)](https://swift.org/)
[![Platform](https://img.shields.io/cocoapods/p/LFAlertController.svg?style=flat)](https://github.com/Li-Bot/eakit)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)

# DSKit
DSKit is a Framework of Data Structures written in Swift. 

## Contents
- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Future](#future)
- [License](#license)

## Features
- [x] Linked List
- [x] Queue
- [x] QuadTree

## Requirements
- iOS 8+ / macOS 10.10+
- Xcode 10+
- Swift 5+

## Installation

### Carthage
```ogdl
github "Li-Bot/DSKit.git" ~> 0.1.0
```

### Swift Package Manager
```swift
dependencies: [
    .package(url: "https://github.com/Li-Bot/DSKit.git", .upToNextMajor(from: "1.0.0"))
]
```

### Cocoapods
```ruby
pod 'DSKitc', '~> 0.1.0'
```

## Usage
Let's look at how simple it is!

### Linked List
A simple linked list.

```swift
// Create
let list = DSLinkedList<DSLinkedListNode<Int>>()
// Append
list.append(data: 1)
list.append(node: DSLinkedListNode(data: 2))
// Get
let firstNumber = list[0]
// Remove
list.remove(at: 1)
```

### Queue
A simple queue.

```swift
// Create
let queue = DSQueue<Int>()
// Enqueue
queue.enqueue(1)
// Dequeue
let firstNumber = queue.dequeue()
```

### QuadTree
QuadTree is a special tree data structure. QuadTree is used for spatial decomposition of 2D space. 
Each node has four subnodes that represent - top left, top right, bottom right and bottom left.

```swift
// Create
let treeRootRect = DSQuadRect(origin: .zero, end: CGPoint(x: 100.0, y: 100.0))
let quadTree = DSQuadTree<DSQuadTreeNode<Int>>(rect: treeRootRect)
// Insert
var result = quadTree.insert(node: DSQuadTreeNode(position: CGPoint(x: 10.0, y: 10.0), data: 1))
result = quadTree.insert(node: DSQuadTreeNode(position: CGPoint(x: 12.0, y: 12.0), data: 1))
result = quadTree.insert(node: DSQuadTreeNode(position: CGPoint(x: 70.0, y: 90.0), data: 1))
// Search
let foundNode = quadTree.search(at: CGPoint(x: 10.0, y: 10.0))
let circle = DSCircle(center: CGPoint(x: 50.0, y: 50.0), radius: 25.0)
let foundNodes = quadTree.search(at: circle)
```

#### QaudTree Image Renderer
Render QuadTree into an image.
```swift
let renderer = DSQuadTreeRenderer()
let image = renderer.draw(tree: quadTree, highlight: circle)
```

## Future
- More data structures. I am only in the beginning.

## License
DSKit is released under the GNU GPLv3 license. See the [LICENSE here](LICENSE.md).
