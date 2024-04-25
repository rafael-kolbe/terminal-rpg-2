import chalk from "chalk";

export async function getProfile(activeCharacter: any) {
	try {
		console.log(chalk.bold.green(`${activeCharacter.name} | ${activeCharacter.className}`));
		console.log(chalk.bold.green(`Lv: ${activeCharacter.level} | Exp: ${activeCharacter.exp} / 100`));
		console.log(chalk.bold.green(`Hp: 200 / 200 | Mp: 50 / 50`));
		console.log();
		console.log(chalk.bold.green(`Nationality: Valkyrie Empire`));
		console.log(chalk.bold.green(`Residence: Carlin - Valkyrie Empire`));
	} catch (error) {
		throw new Error(`getProfile crashed.\nLog: ${error}`);
	}
}
