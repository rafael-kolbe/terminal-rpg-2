import chalk from "chalk";
import { executeGame } from "./boot/init";
import { db } from "./connections/connection";

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
