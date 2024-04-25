import chalk from "chalk";
import inquirer from "inquirer";
import { createCharacter, updateActiveCharacter } from "../repository/character.js";

export async function characterCreation() {
	try {
		let createdCharacter;
		let creating = true;

		while (creating) {
			const character = await inquirer.prompt([
				{
					name: "name",
					type: "input",
					message: "Choose your name:",
				},
				{
					name: "className",
					type: "list",
					message: "Choose your class:",
					choices: ["Knight", "Mage", "Archer"],
				},
			]);

			createdCharacter = await createCharacter(character);

			if (createdCharacter) {
				console.log(chalk.bold.green(`Welcome to the game, ${createdCharacter.name}!`));
				console.log(chalk.bold.green(`ID: ${createdCharacter.id}\nName: ${createdCharacter.name}\nClass: ${createdCharacter.className}`));
				creating = false;
			}
		}

		const activeCharacter = await updateActiveCharacter(createdCharacter.name);

		console.log(chalk.bold.yellow(`Welcome ${activeCharacter.name}!`));

		return activeCharacter;
	} catch (error) {
		throw new Error(`characterCreation crashed.\nLog: ${error}`);
	}
}
