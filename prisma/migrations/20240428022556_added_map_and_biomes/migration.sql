/*
  Warnings:

  - Added the required column `instance_id` to the `players` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "Biome" AS ENUM ('Forest', 'Desert', 'Tundra', 'Grassland', 'Mountain', 'Swamp', 'Urban', 'Coastal', 'Jungle', 'Savanna', 'Volcanic', 'Ice', 'Ocean');

-- CreateEnum
CREATE TYPE "InstanceType" AS ENUM ('City', 'Building', 'Field', 'Dungeon');

-- AlterTable
ALTER TABLE "players" ADD COLUMN     "instance_id" INTEGER NOT NULL;

-- CreateTable
CREATE TABLE "countries" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "countries_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "territories" (
    "id" SERIAL NOT NULL,
    "country_id" INTEGER,
    "biome" "Biome" NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "territories_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "instances" (
    "id" SERIAL NOT NULL,
    "territory_id" INTEGER NOT NULL,
    "type" "InstanceType" NOT NULL,
    "floor" VARCHAR(2) NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "instances_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "connections" (
    "id" SERIAL NOT NULL,
    "origin_id" INTEGER NOT NULL,
    "destination_id" INTEGER NOT NULL,
    "required_quest_id" INTEGER,
    "required_key_id" INTEGER,
    "required_item_id" INTEGER,
    "locked" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "connections_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "players" ADD CONSTRAINT "players_instance_id_fkey" FOREIGN KEY ("instance_id") REFERENCES "instances"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "territories" ADD CONSTRAINT "territories_country_id_fkey" FOREIGN KEY ("country_id") REFERENCES "countries"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "instances" ADD CONSTRAINT "instances_territory_id_fkey" FOREIGN KEY ("territory_id") REFERENCES "territories"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "connections" ADD CONSTRAINT "connections_origin_id_fkey" FOREIGN KEY ("origin_id") REFERENCES "instances"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "connections" ADD CONSTRAINT "connections_destination_id_fkey" FOREIGN KEY ("destination_id") REFERENCES "instances"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
