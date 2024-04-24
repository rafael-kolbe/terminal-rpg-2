-- AlterTable
ALTER TABLE "players" ADD COLUMN     "exp" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "level" INTEGER NOT NULL DEFAULT 1;

-- CreateTable
CREATE TABLE "experience_table" (
    "level" INTEGER NOT NULL,
    "expRequired" INTEGER NOT NULL,

    CONSTRAINT "experience_table_pkey" PRIMARY KEY ("level")
);
