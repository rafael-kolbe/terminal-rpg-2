/*
  Warnings:

  - You are about to drop the column `className` on the `players` table. All the data in the column will be lost.
  - Added the required column `class_name` to the `players` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "players" DROP CONSTRAINT "players_className_fkey";

-- AlterTable
ALTER TABLE "players" DROP COLUMN "className",
ADD COLUMN     "class_name" TEXT NOT NULL;

-- AddForeignKey
ALTER TABLE "players" ADD CONSTRAINT "players_class_name_fkey" FOREIGN KEY ("class_name") REFERENCES "classes"("name") ON DELETE RESTRICT ON UPDATE CASCADE;
