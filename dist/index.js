"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
const connection_1 = require("./connections/connection");
function testConnection() {
    return __awaiter(this, void 0, void 0, function* () {
        try {
            const res = yield connection_1.db.query("SELECT NOW()");
            console.log("Conexão estabelecida com sucesso:", res.rows[0]);
        }
        catch (err) {
            console.error("Erro ao conectar ao banco de dados:", err);
        }
        finally {
            yield connection_1.db.end();
        }
    });
}
testConnection();
