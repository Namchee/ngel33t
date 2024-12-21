type Scope = {
	declared: string[];
	used: string[];
};

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

type GetResult<Line extends string, Result extends Scope> = Line extends `${
	| "let"
	| "const"
	| "var"} ${infer Variable} = ${string};`
	? {
			declared: [...Result["declared"], Variable];
			used: Result["used"];
		}
	: Line extends `${string}(${infer Call});`
		? {
				declared: Result["declared"];
				used: [...Result["used"], Call];
			}
		: Result;

type FilterUnused<Declared extends string[], Used extends string[]> = Declared extends [infer El extends string, ...infer Rest extends string[]]
	? El extends Used[number]
		? FilterUnused<Rest, Used>
		: [El, ...FilterUnused<Rest, Used>]
	: [];

type GetUnused<Result extends Scope> = {
	scope: Result;
	unused: FilterUnused<Result['declared'], Result['used']>
}

type Lint<
	T extends string,
	Result extends Scope = {
		declared: [];
		used: [];
	},
> = T extends `${infer Line}\n${infer Rest}`
	? Lint<Rest, GetResult<TrimWhitespace<Line>, Result>>
	: GetUnused<GetResult<TrimWhitespace<T>, Result>>;
