-- CreateEnum
CREATE TYPE "Class" AS ENUM ('Knight', 'Mage', 'Archer');

-- CreateTable
CREATE TABLE "Player" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "class" "Class" NOT NULL,

    CONSTRAINT "Player_pkey" PRIMARY KEY ("id")
);
