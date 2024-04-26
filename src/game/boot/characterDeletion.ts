import chalk from "chalk";
import inquirer from "inquirer";
import { deleteCharacter, getCharacterList } from "../../repository/character.js";

export async function characterDeletion() {
	try {
		const characterList = await getCharacterList();

		const chosen = await inquirer.prompt([
			{
				name: "character",
				type: "list",
				message: "Choose a character to delete:",
				choices: characterList,
			},
		]);

		const confirm = await inquirer.prompt([
			{
				name: "delete",
				type: "confirm",
				message: `Are you sure you want to delete ${chosen.character}?`,
			},
		]);

		if (confirm.delete) {
			const characterName = chosen.character.split("|")[1].trim();
			const deleted = await deleteCharacter(characterName);

			if (deleted) {
				console.log(chalk.bold.yellow(`${characterName} was deleted.`));
			}
		}
	} catch (error) {
		throw new Error(`characterDeletion crashed.\nLog: ${error}`);
	}
}
