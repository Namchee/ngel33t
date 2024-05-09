/**
 * @param {Array} arr1
 * @param {Array} arr2
 * @return {Array}
 */
var join = function(arr1, arr2) {
    const map = {};
    for (const item of arr1) {
        map[item.id] = item;
    }

    for (const item of arr2) {
        if (item.id in map) {
            map[item.id] = { ...map[item.id], ...item };
        } else {
            map[item.id] = item;
        }
    }

    const result = [];
    for (const item of Object.values(map)) {
        result.push(item);
    }

    return result;
};
