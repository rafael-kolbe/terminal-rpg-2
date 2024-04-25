import chalk from "chalk";
import { bootGame } from "./boot/bootGame.js";
import { db } from "./connections/connection.js";
import { executeGame } from "./game/gameloop.js";

async function main() {
	let booting = true;
	let running = false;
	let activeCharacter;

	while (booting) {
		const { success, character } = await bootGame();

		if (success) {
			activeCharacter = character;
			running = true;
			booting = false;
		}
	}

	while (running) {
		if (!activeCharacter) running = false;

		running = await executeGame(activeCharacter);
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
