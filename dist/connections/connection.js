"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.db = void 0;
require("dotenv").config({ path: "../../.env" });
const pg_1 = require("pg");
exports.db = new pg_1.Pool({
    user: process.env.USER,
    password: process.env.PASSWORD,
    host: process.env.HOST,
    port: Number(process.env.PORT),
    database: process.env.DATABASE,
});
