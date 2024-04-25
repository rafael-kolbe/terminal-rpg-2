import chalk from "chalk";
import inquirer from "inquirer";
import { getProfile } from "../repository/mainMenuOptions.js";

export async function executeGame(activeCharacter: any) {
	try {
		const chosen = await inquirer.prompt([
			{
				name: "menuOption",
				type: "list",
				message: "Select an action:",
				choices: ["Check profile", "Open backpack", "Talk to someone where you are", "Go somewhere", "Close Game"],
			},
		]);

		switch (chosen.menuOption) {
			case "Check profile":
				await getProfile(activeCharacter);
				break;
			case "Open backpack":
				console.log(chalk.bold.yellow("Opening Backpack"));
				break;
			case "Talk to someone where you are":
				console.log(chalk.bold.yellow("Talking to someone"));
				break;
			case "Go somewhere":
				console.log(chalk.bold.yellow("Going somewhere"));
				break;
			case "Close Game":
				activeCharacter = null;
				break;
			default:
				console.log(chalk.bold.red("Not a valid option."));
				break;
		}

		return activeCharacter;
	} catch (error) {
		throw new Error(`executeGame crashed.\nLog: ${error}`);
	}
}
