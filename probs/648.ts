function replaceWords(dictionary: string[], sentence: string): string {
    const words = sentence.split(/\s+/);
    for (let i = 0; i < words.length; i++) {
        const word = words[i];
        let best = word;

        for (const dict of dictionary) {
            if (word.startsWith(dict)) {
                best = dict.length < best.length ? dict : best;
            }
        }

        words[i] = best;
    }

    return words.join(' ');
};
