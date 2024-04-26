/*
  Warnings:

  - A unique constraint covering the columns `[id]` on the table `classes` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "classes" ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "required_class" DROP NOT NULL;
DROP SEQUENCE "classes_id_seq";

-- CreateIndex
CREATE UNIQUE INDEX "classes_id_key" ON "classes"("id");
