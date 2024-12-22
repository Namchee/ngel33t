// Code is not mine.
// All credits goes to the TS god: ggrandi

type Parse<T extends string> =
  // tokenize then interpret the tokens
  Tokenize<T> extends { ok: true; data: infer Tokens extends Token[] }
    ? GetValue<Tokens, []> extends { ok: true; data: infer data }
      ? data
      : never
    : never;

//===== tokenizing =====

// type that represents tokens
type Token = ObjToDiscUnion<{
  lcurly: {};
  rcurly: {};
  lbracket: {};
  rbracket: {};
  comma: {};
  property: { name: string | number };
  data: { data: string | boolean | number | null };
}>;

// transforms a string into a list of tokens
type Tokenize<
  JSON extends string,
  Tokens extends Token[] = [],
  // when you pass a value to this function, it will get
  Trimmed extends string = TrimStart<JSON>,
> =
  // parse single character tokens
  Trimmed extends `{${infer rest}`
    ? Tokenize<rest, [...Tokens, { type: "lcurly" }]>
    : Trimmed extends `}${infer rest}`
      ? Tokenize<rest, [...Tokens, { type: "rcurly" }]>
      : Trimmed extends `[${infer rest}`
        ? Tokenize<rest, [...Tokens, { type: "lbracket" }]>
        : Trimmed extends `]${infer rest}`
          ? Tokenize<rest, [...Tokens, { type: "rbracket" }]>
          : Trimmed extends `,${infer rest}`
            ? Tokenize<rest, [...Tokens, { type: "comma" }]>
            : // parsing a string is special
              TryParseString<Trimmed> extends [
                  infer t extends Token,
                  infer rest extends string,
                ]
              ? Tokenize<rest, [...Tokens, t]>
              : Trimmed extends `false${infer rest}`
                ? Tokenize<rest, [...Tokens, { type: "data"; data: false }]>
                : Trimmed extends `true${infer rest}`
                  ? Tokenize<rest, [...Tokens, { type: "data"; data: true }]>
                  : Trimmed extends `null${infer rest}`
                    ? Tokenize<rest, [...Tokens, { type: "data"; data: null }]>
                    : // parsing a number is also special
                      TryParseNumber<Trimmed> extends [
                          infer t extends Token,
                          infer rest extends string,
                        ]
                      ? Tokenize<rest, [...Tokens, t]>
                      : // if done
                        Trimmed extends ""
                        ? { ok: true; data: Tokens }
                        : // or error message
                          {
                            ok: false;
                            err: "Tokenizing: couldn't match anything";
                            rest: Trimmed;
                          };

type Digit = "-" | "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9";

type TryParseNumber<Trimmed extends string, N extends string = ""> =
  // have to use digits because for some reason with " ", n will be number
  // the naïve approach doesn't work because it will only grab a single digit
  Trimmed extends `${infer n extends Digit}${infer rest}`
    ? TryParseNumber<rest, `${N}${n}`>
    : N extends `${infer num extends number}`
      ? TrimStart<Trimmed> extends `:${infer rest}`
        ? [{ type: "property"; name: num }, rest]
        : [{ type: "data"; data: num }, Trimmed]
      : [];

type TryParseString<Trimmed extends string> =
  // if starts with a '"' try to parse a string
  Trimmed extends `"${infer rest}` ? $TryParseString<rest> : [];

// go through string character by characted and see if it is a valid string or property
type $TryParseString<
  Trimmed extends string,
  Acc extends string = "",
  Escaped extends boolean = false,
> = Trimmed extends `${infer next}${infer rest}`
  ? Escaped extends true
    ? $TryParseString<rest, `${Acc}${Escape<next>}`>
    : next extends '"'
      ? TrimStart<rest> extends `:${infer rest}`
        ? [{ type: "property"; name: Acc }, rest]
        : [{ type: "data"; data: Acc }, rest]
      : next extends "\\"
        ? $TryParseString<rest, Acc, true>
        : $TryParseString<rest, `${Acc}${next}`>
  : [];

// escapes a character C
type Escape<C extends string> =
  //prettier-ignore
  Switch<C, [
		["r", "\r"], 
		["n", "\n"], 
		["b", "\b"], 
		["f", "\f"], 
		['"', '"'], 
		["\\", "\\"]
	], `\\${C}`>;

// ===== interpreting the tokens =====

// type to help build up an object
type Building = ObjToDiscUnion<{
  object: { obj: object };
  array: { arr: unknown[] };
  property: { name: string | number };
  kv: { key: string | number; val: unknown };
  val: { val: unknown };
}>;

// gets a value (`{ ... }`, `[ ... ]`, `"..."`, `true`, `false`, `null`) from the list of tokens
type GetValue<T extends Token[], Acc extends Building[] = []> =
  // look at the next token
  T extends [infer next extends Token, ...infer rest extends Token[]]
    ? // if it is a {
      next extends { type: "lcurly" }
      ? // check if instantly closed
        rest extends [{ type: "rcurly" }, ...infer rest extends Token[]]
        ? MergeIn<rest, Acc, { type: "val"; val: {} }>
        : // or get a property
          GetProperty<rest, [...Acc, { type: "object"; obj: {} }]>
      : // same but for arrays
        next extends { type: "lbracket" }
        ? rest extends [{ type: "rbracket" }, ...infer rest extends Token[]]
          ? MergeIn<rest, Acc, { type: "val"; val: [] }>
          : GetValue<rest, [...Acc, { type: "array"; arr: [] }]>
        : // or if it is a value, try to merge it into the previous value
          next extends { type: "data"; data: infer val }
          ? MergeIn<rest, Acc, { type: "val"; val: val }>
          : // if not error
            { ok: false; err: "unexpected token"; tokens: T }
    : { ok: false; err: "unexpected end of tokens" };

// gets a property from the list of tokens
type GetProperty<T extends Token[], Acc extends Building[]> =
  // check the next token
  T extends [infer next extends Token, ...infer rest extends Token[]]
    ? // if it is a property
      next extends { type: "property"; name: string | number }
      ? // add it to the stack
        GetValue<rest, [...Acc, next]>
      : { ok: false; err: "expected a property"; tokens: T }
    : { ok: false; err: "unexpected end of tokens" };

// merge values into the thing before it
type MergeIn<T extends Token[], Acc extends Building[], Val extends Building> =
  // check the value on top of the
  Acc extends [...infer rest extends Building[], infer last extends Building]
    ? // if it is an object
      last extends { type: "object"; obj: infer Obj extends object }
      ? // and trying to merge a kv pair
        Val extends {
          type: "kv";
          key: infer key extends string | number;
          val: infer val;
        }
        ? // add it to the object and look for a continuing token
          GetContinuing<
            T,
            [...rest, { type: "object"; obj: Obj & Record<key, val> }]
          >
        : // else error
          {
            ok: false;
            err: "tried to merge a non-kv pair into an obj";
            data: Val;
            acc: Acc;
          }
      : // if it is a property
        last extends {
            type: "property";
            name: infer name extends string | number;
          }
        ? // add the value to the property
          Val extends { type: "val"; val: infer val }
          ? // and merge it in again
            MergeIn<T, rest, { type: "kv"; key: name; val: val }>
          : {
              ok: false;
              err: "tried merging a non value into a property";
              data: Val;
              acc: Acc;
            }
        : // if it is an array
          last extends { type: "array"; arr: infer arr extends unknown[] }
          ? // merge the value into the array
            Val extends { type: "val"; val: infer val }
            ? // and look for a continuing token
              GetContinuing<T, [...rest, { type: "array"; arr: [...arr, val] }]>
            : {
                ok: false;
                err: "tried a merging a non value into an array";
                data: Val;
                acc: Acc;
              }
          : { ok: false; err: "unknown type of last"; last: last }
    : // if you cannot merge into anything,
      Val extends { type: "val"; val: infer val }
      ? // either you have successfully parsed
        { ok: true; data: val }
      : // or you have errored
        { ok: false; err: "the last value should be of type value"; val: Val };

type GetContinuing<T extends Token[], Acc extends Building[]> =
  // handles ",", "}" and "]"
  T extends [infer next extends Token, ...infer rest extends Token[]]
    ? // if it is a comma
      next extends { type: "comma" }
      ? rest extends [{ type: "rcurly" | "rbracket" }, ...Token[]]
        ? GetContinuing<rest, Acc>
        : // if we are in an object, get a property
          Acc extends [...unknown[], { type: "object" }]
          ? GetProperty<rest, Acc>
          : // if we are in an array, get a value
            Acc extends [...unknown[], { type: "array" }]
            ? GetValue<rest, Acc>
            : // else error
              {
                ok: false;
                err: "unexpected comma not in array or object";
                acc: Acc;
              }
      : // close an object
        next extends { type: "rcurly" }
        ? Acc extends [
            ...infer acc extends Building[],
            { type: "object"; obj: infer obj },
          ]
          ? // and merge it
            MergeIn<rest, acc, { type: "val"; val: Prettify<obj> }>
          : {
              ok: false;
              err: "attempted to close a non object with }";
              acc: Acc;
            }
        : // close an array
          next extends { type: "rbracket" }
          ? Acc extends [
              ...infer acc extends Building[],
              { type: "array"; arr: infer arr },
            ]
            ? // and merge it in
              MergeIn<rest, acc, { type: "val"; val: arr }>
            : {
                ok: false;
                err: "attempted to close a non array with ]";
                acc: Acc;
              }
          : { ok: false; err: "unexpected next token"; tokens: T }
    : { ok: false; err: "unexpected end of input" };

// ===== type helpers =====

// turns an object into a discriminated union
type ObjToDiscUnion<
  T,
  Disc extends PropertyKey = "type",
  K extends keyof T = keyof T,
> = K extends unknown ? Prettify<Record<Disc, K> & T[K]> : never;

// Prettify coming in clutch
type Prettify<T> = { [K in keyof T]: T[K] } & {};

// trims the start of a string (removes whitespace)
type TrimStart<
  S extends string,
  T extends string = " " | "\n" | "\t",
> = S extends `${T}${infer Rest}` ? TrimStart<Rest> : S;

type Switch<
  T,
  Cases extends [match: unknown, value: unknown][],
  Default = never,
> =
  // effectively a switch statement
  Cases extends [
    [infer match, infer value],
    ...infer rest extends [unknown, unknown][],
  ]
    ? // if T matches `match` return `value` or try to find the next one that matches
      T extends match
      ? value
      : Switch<T, rest, Default>
    : Default;
