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

type ParseLine<T extends string> = T extends ""
	? []
	: T extends `${"let" | "const" | "var"} ${infer Variable} = ${string};`
		? [{ id: Variable; type: "VariableDeclaration" }]
		: T extends `${string}(${infer Call});`
			? [{ argument: Call; type: "CallExpression" }]
			: [];

type Parse<T extends string> = T extends `${infer Line}\n${infer Rest}`
	? [...ParseLine<TrimWhitespace<Line>>, ...Parse<Rest>]
	: [...ParseLine<TrimWhitespace<T>>];
