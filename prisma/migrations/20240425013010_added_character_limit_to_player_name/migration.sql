/*
  Warnings:

  - You are about to alter the column `name` on the `players` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(20)`.

*/
-- AlterTable
ALTER TABLE "players" ALTER COLUMN "name" SET DATA TYPE VARCHAR(20);
