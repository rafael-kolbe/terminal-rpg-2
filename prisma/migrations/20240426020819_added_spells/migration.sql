-- CreateEnum
CREATE TYPE "SpellType" AS ENUM ('Offense', 'Support', 'Buff', 'Debuff');

-- CreateEnum
CREATE TYPE "SpellTarget" AS ENUM ('Ally', 'Enemy');

-- CreateTable
CREATE TABLE "spells" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "type" "SpellType" NOT NULL,
    "target" "SpellTarget" NOT NULL,
    "target_number" INTEGER NOT NULL,
    "required_class" INTEGER,
    "required_level" INTEGER NOT NULL,
    "hp_cost" INTEGER NOT NULL,
    "mp_cost" INTEGER NOT NULL,
    "cooldown" INTEGER NOT NULL,
    "base_p_atk" DOUBLE PRECISION NOT NULL,
    "p_atk_lv" INTEGER NOT NULL,
    "base_m_atk" DOUBLE PRECISION NOT NULL,
    "m_atk_lv" INTEGER NOT NULL,
    "buy_price" INTEGER NOT NULL,

    CONSTRAINT "spells_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "player_spells" (
    "player_id" INTEGER NOT NULL,
    "spell_id" INTEGER NOT NULL,

    CONSTRAINT "player_spells_pkey" PRIMARY KEY ("player_id","spell_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "spells_name_key" ON "spells"("name");

-- AddForeignKey
ALTER TABLE "spells" ADD CONSTRAINT "spells_required_class_fkey" FOREIGN KEY ("required_class") REFERENCES "classes"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "player_spells" ADD CONSTRAINT "player_spells_player_id_fkey" FOREIGN KEY ("player_id") REFERENCES "players"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "player_spells" ADD CONSTRAINT "player_spells_spell_id_fkey" FOREIGN KEY ("spell_id") REFERENCES "spells"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
