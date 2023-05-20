declare global {
    interface Array<T> {
        groupBy(fn: (item: T) => string): Record<string, T[]>
    }
}

Array.prototype.groupBy = function(fn) {
    const result = {};
    for (const val of this) {
        const key = fn(val);
        if (result[key]) {
            result[key].push(val);
        } else {
            result[key] = [val];
        }
    }

    return result;
}

/**
 * [1,2,3].groupBy(String) // {"1":[1],"2":[2],"3":[3]}
 */