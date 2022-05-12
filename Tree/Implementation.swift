var tree = Tree([5,3,2,1,7,9,8,6,4])
var node = tree.create()
print(tree.findDepth(node, 4))
print(tree.isCousins(node, 6,4))
tree.postorder(node: node)
print(Problem.inorderTraversal(node))

// Implementation of queue is inside the Tree class create method
