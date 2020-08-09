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