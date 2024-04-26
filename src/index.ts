import chalk from "chalk";
import { db } from "./connections/connection.js";
import { bootGame } from "./game/boot/bootGame.js";
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

	db.end();
	console.log(chalk.bold.yellow("Game closed. Thanks for Playing!"));
}

main().catch(async (error) => {
	db.end();
	console.error(`Oops, something went wrong!\n${error}`);
});
