-- Experiencia não pode ser negativa
ALTER TABLE players
ADD CONSTRAINT exp_non_negative CHECK (exp >= 0);

-- Hp não pode ser negativo
ALTER TABLE players
ADD CONSTRAINT hp_non_negative CHECK (hp >= 0);

-- Mp não pode ser negativo
ALTER TABLE players
ADD CONSTRAINT mp_non_negative CHECK (mp >= 0);