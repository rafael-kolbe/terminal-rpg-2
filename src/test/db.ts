import { db } from "../connections/connection";

async function testConnection() {
	try {
		const res = await db.query("SELECT NOW()");
		console.log("Conexão estabelecida com sucesso:", res.rows[0]);
	} catch (err) {
		console.error("Erro ao conectar ao banco de dados:", err);
	} finally {
		await db.end();
	}
}

testConnection();
