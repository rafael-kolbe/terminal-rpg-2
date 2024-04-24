import chalk from "chalk";
import inquirer from "inquirer";
import { db } from "../connections/connection.js";

export async function executeGame() {
	const choice = await inquirer.prompt([
		{
			name: "createCharacter",
			type: "confirm",
			message: "Create a new Character?",
		},
	]);

	try {
		if (choice.createCharacter) {
			const character = await inquirer.prompt([
				{
					name: "name",
					type: "input",
					message: "Choose your name:",
				},
				{
					name: "class",
					type: "list",
					message: "Choose your class:",
					choices: ["Knight", "Mage", "Archer"],
				},
			]);

			const query = `
                INSERT INTO players(name, class)
                VALUES($1, $2)
                RETURNING *;
            `;

			await db
				.query(query, [character.name, character.class])
				.then(({ rows }) => {
					console.log(chalk.bold.green(`Welcome to the game, ${rows[0].name}!`));
					console.log(chalk.bold.green(`ID: ${rows[0].id}\nName: ${rows[0].name}\nClass: ${rows[0].class}`));
				})
				.catch(() => {
					console.log(chalk.bold.red(`A player with this name already exists.`));
				});
		} else {
			return false;
		}

		return true;
	} catch (error) {
		throw Error(`executeGame crashed.\nLog: ${error}`);
	}
}
