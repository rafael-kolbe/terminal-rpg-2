import chalk from "chalk";
import { executeGame } from "./boot/init.js";
import { db } from "./connections/connection.js";

async function main() {
	let running = true;

	while (running) {
		running = await executeGame();
	}

	console.log(chalk.bold.yellow("Game closed. Thanks for Playing!"));
}

main().catch((error) => {
	db.end();
	console.error(`Oops, something went wrong!\n${error}`);
});
