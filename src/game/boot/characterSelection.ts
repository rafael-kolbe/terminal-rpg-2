import chalk from "chalk";
import inquirer from "inquirer";
import { getCharacterList, updateActiveCharacter } from "../../repository/character.js";

export async function characterSelection() {
	try {
		const characterList = await getCharacterList();

		const chosen = await inquirer.prompt([
			{
				name: "character",
				type: "list",
				message: "Choose a character to play:",
				choices: characterList,
			},
		]);

		const characterName = chosen.character.split("|")[1].trim();
		const activeCharacter = await updateActiveCharacter(characterName);

		console.log(chalk.bold.yellow(`Welcome ${activeCharacter.name}!`));

		return activeCharacter;
	} catch (error) {
		throw Error(`characterSelection crashed.\nLog: ${error}`);
	}
}
