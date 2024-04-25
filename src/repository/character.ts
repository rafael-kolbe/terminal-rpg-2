import chalk from "chalk";
import { db } from "../connections/connection.js";
import { formatCharacterName } from "../utils/formatCharacterName.js";
import { isDatabaseError } from "../utils/isDatabaseError.js";

export async function getCharacterCount(): Promise<number> {
	try {
		const query = `
            SELECT
            COUNT(*) AS character_count
            FROM players
            WHERE deleted_at IS NULL;
        `;

		const { rows } = await db.query(query);

		return rows[0].character_count;
	} catch (error) {
		throw new Error(`getCharacterCount crashed.\nLog: ${error}`);
	}
}

export async function getCharacterList() {
	try {
		const query = `
            SELECT
            level,
            className,
            name
            FROM players
            WHERE deleted_at IS NULL
            ORDER BY 1 DESC;
        `;

		const { rows: characters } = await db.query(query);

		return characters.map((character) => `Lv: ${character.level} ${character.className} | ${character.name}`);
	} catch (error) {
		throw new Error(`getCharacterList crashed.\nLog: ${error}`);
	}
}

export async function createCharacter(character: { name: string; className: string }) {
	try {
		const query = `
            INSERT INTO players(name, className)
            VALUES($1, $2)
            RETURNING *;
        `;

		character.name = formatCharacterName(character.name);

		const { rows: createdCharacter } = await db.query(query, [character.name, character.className]);

		return createdCharacter[0];
	} catch (error: unknown) {
		if (isDatabaseError(error) && error.code === "23505") {
			console.log(chalk.bold.red("A character with this name already exists."));
			return false;
		}

		if (isDatabaseError(error) && error.code === "22001") {
			console.log(chalk.bold.red("The character name is too long. It must be 20 characters or less."));
			return false;
		}

		throw new Error(`createCharacter crashed.\nLog: ${error}`);
	}
}

export async function updateActiveCharacter(characterName: string) {
	try {
		const query = `
            UPDATE players
            SET active = TRUE
            WHERE name = $1
            RETURNING *;
        `;

		const { rows: activeCharacter } = await db.query(query, [characterName]);

		return activeCharacter[0];
	} catch (error) {
		throw new Error(`updateActiveCharacter crashed.\nLog: ${error}`);
	}
}

export async function deleteCharacter(characterName: string) {
	try {
		const query = `
            UPDATE players
            SET deleted_at = NOW()
            WHERE name = $1;
        `;

		await db.query(query, [characterName]);

		return true;
	} catch (error) {
		throw new Error(`deleteCharacter crashed.\nLog: ${error}`);
	}
}
