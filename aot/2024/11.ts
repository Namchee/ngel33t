type Excuse<T extends object> = {
	new(obj: T): {
		[Key in keyof T]: `${Key extends string ? Key : never}: ${T[Key] extends string ? T[Key] : never}`
	}[keyof T];
}
