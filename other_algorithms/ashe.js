function isPalindrome(string) {
    var length = string.length;

    for (var i = 0; i < length / 2; i++) {
        if (string[i] !== string[length - 1 - i]) {
            return false;
        }
    }

    return true;
}

Array.prototype.myMap = function (fn) {
    var final = [];
    this.forEach(function (el) {
        final.push(fn(el));
    });

    return final;
};

Array.prototype.myMap = function (fn) {
    const final = [];
    this.forEach((el) => {
        final.push(fn(el));
    });

    return final;
};

// Take in the root node
function isBalanced(node) {
    // Base case: the tree is empty.  Return true.
    if (!node) {
        return true;
    }

    // Get the depths of left and right subtrees and compare
    var leftDepth = getDepth(node.left);
    var rightDepth = getDepth(node.right);
    var depthDiff = Math.abs(leftDepth - rightDepth);

    // The tree is balanced if both subtrees are balanced AND
    // the difference in depths of those subtrees is between -1 and 1
    return (isBalanced(node.left) && isBalanced(node.right)) && depthDiff < 2;
}

function getDepth(node) {
    // Base case: empty tree.  Depth is 0.
    if (!node) {
        return 0;
    }

    // Take the larger depth of the two subtrees, calculated recursively
    return Math.max(getDepth(node.left), getDepth(node.right)) + 1;
}

function isBalanced(node) {
    return isBalancedNode(node).isBalanced;
}

function isBalancedNode(node) {
    if (!node) {
        return { isBalanced: true, depth: -1 };
    }

    let left = isBalancedNode(node.left);
    let right = isBalancedNode(node.right);

    if (left.isBalanced && right.isBalanced &&
        Math.abs(left.depth - right.depth) <= 1) {
        return { isBalanced: true, depth: Math.max(right.depth, left.depth) + 1 };
    } else {
        return { isBalanced: false, depth: 0 };
    }
}

// O(log(n))
function findCommonAncestor(root, nodeA, nodeB) {
    var currentNode = root;
    while true {
        if (currentNode == nodeA || currentNode == nodeB) {
            // one is the descendent of the other.
            return currentNode;
        }

        // is one of the nodes on the left, and the other on the right?
        var bothOnRight = ((currentNode.value < nodeA.value) &&
            (currentNode.value < nodeB.value));
        var bothOnLeft = ((currentNode.value > nodeA.value) &&
            (currentNode.value > nodeB.value));
        var onSameSide = bothOnRight || bothOnLeft;

        if (!onSameSide) {
            // the two nodes are on different sides.
            return currentNode;
        }

        currentNode = bothOnRight ? currentNode.right : currentNode.left;
    }
}

function maxValue(node, visited=new Set()) {
    if (visited.has(node)) return -Infinity;
    visited.add(node);
    let neighborMaxes = node.neighbors.map((neighbor) => maxValue(neighbor, visited));
    return Math.max(node.val, ...neighborMaxes);
}

module.exports = {
    maxValue
};


function numRegions(graph) {
    let visited = new Set();
    let regions = 0;

    for (let node in graph) {
        if (isNewRegion(node, graph, visited)) regions++;
    }

    return regions;
}

function isNewRegion(node, graph, visited) {
    if (visited.has(node)) return false;

    visited.add(node);

    graph[node].forEach((neighbor) => {
        isNewRegion(neighbor, graph, visited);
    });

    return true;
}


module.exports = {
    numRegions
};


class Link {
    constructor(value) {
        this.next = null;
        this.prev = null;
        this.value = value;
    }
}

class LinkedList {
    constructor() {
        this.head = new Link();
        this.tail = new Link();
        this.head.next = this.tail;
        this.tail.prev = this.head;
    }

    isEmpty() {
        return this.head.next === this.tail;
    }

    first() {
        if (this.isEmpty()) return null;
        return this.head.next;
    }

    last() {
        if (this.isEmpty()) return null;
        return this.tail.prev;
    }

    find(val) {
        let link = this.first();
        while (link) {
            if (link.value === val) {
                return link;
            }

            link = link.next;
        }
    }

    remove(val) {
        let nodeToRemove = this.find(val);
        if (!nodeToRemove) return;
        let before = nodeToRemove.prev;
        let after = nodeToRemove.next;

        before.next = after;
        after.prev = before;
        nodeToRemove.prev = null;
        nodeToRemove.next = null;

        return nodeToRemove;
    }

    push(val) {
        const link = new Link(val);
        let last = this.tail.prev;
        last.next = link;
        link.prev = last;
        link.next = this.tail;
        this.tail.prev = link;
    }

    pop() {
        if (this.isEmpty()) return;
        const last = this.last();
        const newLast = last.prev;

        newLast.next = this.tail;
        this.tail.prev = newLast;
        last.next = null;
        last.prev = null;
        return last;
    }

    removeAll(val) {
        let link = this.head.next;

        while (link !== this.tail) {
            if (link.value === val) {
                let before = link.prev;
                let after = link.next;

                before.next = after;
                after.prev = before;
                link.prev = null;
                link.next = null;
                link = after;
            } else {
                link = link.next;
            }
        }
    }
}