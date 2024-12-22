import { Expect, Equal } from 'type-testing';

type TrimWhitespace<S extends string> = S extends
	| `\n${infer R}`
	| `\r${infer R}`
	| `\t${infer R}`
	| `${infer R}\n`
	| `${infer R}\r`
	| `${infer R}\t`
	| ` ${infer R}`
	| `${infer R} `
	? TrimWhitespace<R>
	: S;

type ParseValue<T extends string> = T extends `'${infer Str}'` | `"${infer Str}"` | `\`${infer Str}\``
  ? Str
  : T extends `${infer Number extends number}`
    ? Number
    : T extends `${infer Bool extends boolean}`
      ? Bool
      : T extends `null`
        ? null
        : T extends 'undefined'
          ? undefined
          : T extends 'any'
            ? any
            : T;

type Helper<T extends string, Result extends unknown[] = [], Temp extends string = ''> = T extends `${infer Char}${infer Rest}`
    ? Char extends ']'
      ? [...Result, ParseValue<TrimWhitespace<Temp>>]
      : Char extends ','
        ? Helper<Rest, [...Result, ParseValue<TrimWhitespace<Temp>>], ''>
        : Helper<Rest, Result, `${Temp}${Char}`> 
    : [];

type ParseAsArray<T extends string> = T extends `[${infer Rest}`
  ? Rest extends `${string}]`
    ? Helper<Rest>
    : never
  : never;

type Case1 = '["foo",`bar`,         \'baz\']';
type Case2 = '[""]';
type Case3 = '[true, false, "NORMAL SUMMON MOYE"]';
type Case4 = '[1, -1,2, 2.31,]';
type Case5 = '[string, number]'

type a = ParseAsArray<Case5>;

Expect<ParseAsArray<Case1>, Equal<['foo', 'bar', 'baz']>>;
Expect<ParseAsArray<Case2>, Equal<['']>>;
Expect<ParseAsArray<Case3>, Equal<[true]>>;
Expect<ParseAsArray<Case4>, Equal<[1, -1, 2]>>;
