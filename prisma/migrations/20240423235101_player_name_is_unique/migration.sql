/*
  Warnings:

  - A unique constraint covering the columns `[name]` on the table `players` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "players_name_key" ON "players"("name");
