/**
 * @param {number[]} arr
 * @param {Function} fn
 * @return {number[]}
 */
var map = function(arr, fn) {
    const newArr = [];
    for (const [idx, val] of arr.entries()) {
        newArr.push(fn(val, idx));
    }

    return newArr;
};
