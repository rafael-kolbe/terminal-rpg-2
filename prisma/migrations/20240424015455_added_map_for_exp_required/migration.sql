/*
  Warnings:

  - You are about to drop the column `expRequired` on the `experience_table` table. All the data in the column will be lost.
  - Added the required column `exp_required` to the `experience_table` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "experience_table" DROP COLUMN "expRequired",
ADD COLUMN     "exp_required" INTEGER NOT NULL;
