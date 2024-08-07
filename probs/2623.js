/**
 * @param {Function} fn
 * @return {Function}
 */
function memoize(fn) {
    let call = 1;
    const mp = {};
    return function(...args) {
        const key = JSON.stringify(args);

        if (key in mp) {
            return mp[key];
        }

        const result = fn.apply(this, args);
        mp[key] = result;
        call++;

        return result;
    }
}


/** 
 * let callCount = 0;
 * const memoizedFn = memoize(function (a, b) {
 *	 callCount += 1;
 *   return a + b;
 * })
 * memoizedFn(2, 3) // 5
 * memoizedFn(2, 3) // 5
 * console.log(callCount) // 1 
 */
