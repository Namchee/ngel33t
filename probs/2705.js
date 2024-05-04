/**
 * @param {Object|Array} obj
 * @return {Object|Array}
 */
var compactObject = function(obj) {
    if (Array.isArray(obj)) {
        return obj.filter(Boolean).map(val =>typeof val === 'object' ? compactObject(val) : val);
    }

    if (typeof obj === 'object') {
        const newObj = {};
        for (const [key, value] of Object.entries(obj)) {
            if (value) {
                newObj[key] = compactObject(value);
            }
        }

        return newObj;
    }
    
    return obj;
};
