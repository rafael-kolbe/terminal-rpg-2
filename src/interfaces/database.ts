export interface DatabaseError extends Error {
	code: string;
	message: string;
}
