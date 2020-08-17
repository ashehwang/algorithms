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