import chalk from "chalk";
import inquirer from "inquirer";
import { getCharacterCount } from "../repository/character.js";
import { characterCreation } from "./characterCreation.js";
import { characterDeletion } from "./characterDeletion.js";
import { characterSelection } from "./characterSelection.js";

export async function bootGame() {
	let activeCharacter;

	try {
		console.log(chalk.bold.yellow(`Welcome to the Terminal-RPG!`));

		const characterCount = await getCharacterCount();

		if (characterCount > 0) {
			const chosen = await inquirer.prompt([
				{
					name: "menuOption",
					type: "list",
					message: "What would you like to do?",
					choices: ["Select a character", "Create a new character", "Delete a character"],
				},
			]);

			if (chosen.menuOption === "Select a character") {
				activeCharacter = await characterSelection();
			}

			if (chosen.menuOption === "Create a new character") {
				activeCharacter = await characterCreation();
			}

			if (chosen.menuOption === "Delete a character") {
				await characterDeletion();

				return { success: false, character: null };
			}
		} else {
			const chosen = await inquirer.prompt([
				{
					name: "create",
					type: "confirm",
					message: "Create a new character?",
				},
			]);

			if (chosen.create) {
				activeCharacter = await characterCreation();
			}
		}

		return { success: true, character: activeCharacter };
	} catch (error) {
		throw new Error(`executeGame crashed.\nLog: ${error}`);
	}
}
