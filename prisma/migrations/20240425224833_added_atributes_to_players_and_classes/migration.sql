/*
  Warnings:

  - You are about to drop the column `class` on the `players` table. All the data in the column will be lost.
  - Added the required column `className` to the `players` table without a default value. This is not possible if the table is not empty.
  - Added the required column `hp` to the `players` table without a default value. This is not possible if the table is not empty.
  - Added the required column `m_atk` to the `players` table without a default value. This is not possible if the table is not empty.
  - Added the required column `mp` to the `players` table without a default value. This is not possible if the table is not empty.
  - Added the required column `p_atk` to the `players` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "players" DROP COLUMN "class",
ADD COLUMN     "className" TEXT NOT NULL,
ADD COLUMN     "hp" INTEGER NOT NULL,
ADD COLUMN     "m_atk" INTEGER NOT NULL,
ADD COLUMN     "mp" INTEGER NOT NULL,
ADD COLUMN     "p_atk" INTEGER NOT NULL;

-- DropEnum
DROP TYPE "Class";

-- CreateTable
CREATE TABLE "classes" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "rank" INTEGER NOT NULL,
    "required_class" INTEGER NOT NULL,
    "required_level" INTEGER NOT NULL,
    "base_hp" INTEGER NOT NULL,
    "hp_lv" INTEGER NOT NULL,
    "base_mp" INTEGER NOT NULL,
    "mp_lv" INTEGER NOT NULL,
    "base_p_atk" INTEGER NOT NULL,
    "p_atk_lv" INTEGER NOT NULL,
    "base_m_atk" INTEGER NOT NULL,
    "m_atk_lv" INTEGER NOT NULL,

    CONSTRAINT "classes_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "classes_name_key" ON "classes"("name");

-- AddForeignKey
ALTER TABLE "players" ADD CONSTRAINT "players_className_fkey" FOREIGN KEY ("className") REFERENCES "classes"("name") ON DELETE RESTRICT ON UPDATE CASCADE;
