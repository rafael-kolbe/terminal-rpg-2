import chalk from "chalk";
import { setTimeout } from "timers/promises";

export async function executeGame(activeCharacter: any) {
	console.log(chalk.bold.green("Game Running"));

	await setTimeout(10000);

	return false;
}
