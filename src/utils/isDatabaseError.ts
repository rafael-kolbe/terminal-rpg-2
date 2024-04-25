import { DatabaseError } from "pg";

export function isDatabaseError(error: unknown): error is DatabaseError {
	return typeof error === "object" && error !== null && "code" in error && "message" in error;
}
