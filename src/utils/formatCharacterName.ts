export function formatCharacterName(fullName: string): string {
	const words = fullName.split(/\s+/);

	const capitalizedWords = words.map((word) => {
		return word.charAt(0).toUpperCase() + word.slice(1).toLowerCase();
	});

	return capitalizedWords.join(" ");
}
