const compose = <T, U, V, X>(f: (arg: T) => U, g: (arg: U) => V, h: (arg: V) => X) => (a: T) => (
    h(g(f(a)))
);

type FirstChar<T extends string> = T extends `${infer Front}${infer _}` ? Front : never;

const upperCase = <T extends string>(x: T) => x.toUpperCase() as Uppercase<T>;
const lowerCase = <T extends string>(x: T) => x.toLowerCase() as Lowercase<T>;
const firstChar = <T extends string>(x: T) => x[0] as FirstChar<T>;
const firstItem = <T>(x: T[]) => x[0];
const makeTuple = <T>(x: T) => [x];
const makeBox = <T>(value: T) => ({ value });
