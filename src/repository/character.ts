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
            class_name,
            name
            FROM players
            WHERE deleted_at IS NULL
            ORDER BY 1 DESC;
        `;

		const { rows: characters } = await db.query(query);

		return characters.map((character) => `Lv: ${character.level} ${character.class_name} | ${character.name}`);
	} catch (error) {
		throw new Error(`getCharacterList crashed.\nLog: ${error}`);
	}
}

export async function createCharacter(character: { name: string; className: string }) {
	try {
		const query = `
            INSERT INTO players(name, class_name)
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

export async function selectCharacter(characterName: string) {
	try {
		const query = `
            SELECT
			p.id,
			p.name,
			p.class_name,
			p.level,
			p.exp,
			p.hp,
			c.base_hp + (c.hp_lv * p.level) AS "max_hp",
			p.mp,
			c.base_mp + (c.mp_lv * p.level) AS "max_map",
			p.p_atk,
			p.m_atk,
			i.name AS "location",
			i.floor AS "floor",
			t.name AS "territory",
			t.biome,
			co.name AS "country"
			FROM players p
			LEFT JOIN classes c ON c.name = p.class_name
			LEFT JOIN instances i ON i.id = p.instance_id
			LEFT JOIN territories t ON t.id = i.territory_id
			LEFT JOIN countries co ON co.id = t.country_id
			WHERE p.name = $1
        `;

		const player_spells_query = `
            SELECT
			s.*
			FROM spells s
			LEFT JOIN player_spells ps ON ps.spell_id = s.id
			LEFT JOIN players p ON p.id = ps.player_id
			WHERE p.name = $1
        `;

		const { rows: activeCharacter } = await db.query(query, [characterName]);
		const { rows: playerSpells } = await db.query(player_spells_query, [characterName]);

		activeCharacter[0].spells = playerSpells;

		return activeCharacter[0];
	} catch (error) {
		throw new Error(`selectCharacter crashed.\nLog: ${error}`);
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
