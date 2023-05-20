function curry(fn: Function): Function {
    return function curried(...args: any[]) {
        return args.length >= fn.length ?
            fn.apply(this, args) :
            function (...moreArgs: any[]) {
                return curried.apply(this, args.concat(moreArgs));
            }
    };
};

/**
 * function sum(a, b) { return a + b; }
 * const csum = curry(sum);
 * csum(1)(2) // 3
 */