import chalk from "chalk";
import { bootGame } from "./boot/bootGame.js";
import { db } from "./connections/connection.js";
import { executeGame } from "./game/gameloop.js";

async function main() {
	let booting = true;
	let activeCharacter;

	while (booting) {
		const { success, character } = await bootGame();

		if (success) {
			activeCharacter = character;
			booting = false;
		}
	}

	while (activeCharacter) {
		activeCharacter = await executeGame(activeCharacter);
	}

	await db.query("UPDATE players SET active = FALSE;");
	db.end();
	console.log(chalk.bold.yellow("Game closed. Thanks for Playing!"));
}

main().catch(async (error) => {
	await db.query("UPDATE players SET active = FALSE;");
	db.end();
	console.error(`Oops, something went wrong!\n${error}`);
});
