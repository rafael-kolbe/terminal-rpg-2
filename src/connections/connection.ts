import dotenv from "dotenv";
import pg from "pg";

const { Pool } = pg;
dotenv.config();

export const db = new Pool({
	user: process.env.USER,
	password: process.env.PASSWORD,
	host: process.env.HOST,
	port: Number(process.env.PORT),
	database: process.env.DATABASE,
});
