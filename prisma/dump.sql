-- Experiencia não pode ser negativa
ALTER TABLE players
ADD CONSTRAINT exp_non_negative CHECK (exp >= 0);

-- Popula a tabela de experiência até o level 100
DO $$
DECLARE
    level INT;
    increment INT = 100; -- Começa com 100 para o segundo nível
    exp_required INT = 0; -- Inicial para o primeiro nível é 0
    group_counter INT = 1; -- Contador para mudança de grupo de 10 níveis
    increment_before_group_counter_reset INT = 0; -- O incremento antes de resetar o grupo de níveis
BEGIN
    FOR level IN 1..100 LOOP
        INSERT INTO experience_table (level, exp_required) VALUES (level, exp_required);

        exp_required := exp_required + increment * group_counter + increment_before_group_counter_reset;

        group_counter := group_counter + 1;

        IF group_counter > 10 THEN
        	increment_before_group_counter_reset := increment * 10 + increment_before_group_counter_reset;
            increment := increment * 2;
            group_counter := 1;
        END IF;
    END LOOP;
END $$;

-- Popula a tabela de classes
INSERT INTO classes 
(id, name, rank, required_class, required_level, base_hp, hp_lv, base_mp, mp_lv, base_p_atk, p_atk_lv, base_m_atk, m_Atk_lv)
VALUES (
    (1, 'Knight', 1, NULL, 1, 200, 40, 80, 16, 30, 6, 10, 2),
    (2, 'Mage', 1, NULL, 1, 100, 20, 180, 36, 10, 2, 30, 6),
    (3, 'Archer', 1, NULL, 1, 150, 30, 130, 26, 20, 4, 20, 4),
    (4, 'Crusader', 2, 1, 30, 2000, 160, 160, 40, 150, 28, 50, 12),
    (5, 'Templar', 2, 1, 30, 1600, 120, 320, 80, 150, 16, 50, 24),
    (6, 'Rogue', 2, 1, 30, 1200, 110, 480, 90, 150, 36, 50, 4),
    (7, 'Enchanter', 2, 1, 30, 1000, 90, 560, 110, 150, 12, 50, 28),
    (8, 'Wizard', 2, 2, 30, 200, 40, 1800, 160, 50, 2, 150, 38),
    (10, 'Priest', 2, 2, 30, 600, 60, 1080, 140, 50, 15, 150, 25),
    (11, 'Sage', 2, 2, 30, 300, 50, 1620, 150, 50, 10, 150, 30),
    (12, 'Alchemist', 2, 2, 30, 700, 80, 900, 120, 50, 18, 150, 22),
    (13, 'Sniper', 2, 3, 30, 600, 75, 1040, 125, 100, 36, 100, 4),
    (14, 'Hunter', 2, 3, 30, 900, 115, 780, 85, 100, 20, 100, 20),
    (15, 'Gunner', 2, 3, 30, 750, 85, 910, 115, 100, 26, 100, 14),
    (16, 'Specialist', 2, 3, 30, 1800, 165, 0, 35, 100, 32, 100, 8)
);

-- Função de atualização do level do player
CREATE OR REPLACE FUNCTION update_player_level()
RETURNS TRIGGER AS $$
DECLARE
    current_level INT;
    hp INT;
    mp INT;
    p_atk INT;
    m_atk INT;
BEGIN
    SELECT MAX(level) INTO current_level FROM experience_table
    WHERE exp_required <= NEW.exp;

    IF NEW.level <> current_level THEN
        NEW.level := current_level;

        SELECT 
        base_hp + (hp_lv * current_level),
        base_mp + (mp_lv * current_level),
        base_p_atk + (p_atk_lv * current_level),
        base_m_atk + (m_atk_lv * current_level)
        INTO hp, mp, p_atk, m_atk
        FROM classes
        WHERE name = NEW.class_name;

        NEW.hp := hp;
        NEW.mp := mp;
        NEW.p_atk := p_atk;
        NEW.m_atk := m_atk;    
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Função de atualização dos atributos do player
CREATE OR REPLACE FUNCTION update_player_attributes()
RETURNS TRIGGER AS $$
DECLARE
    hp INT;
    mp INT;
    p_atk INT;
    m_atk INT;
BEGIN
    SELECT 
    base_hp + (hp_lv * current_level),
    base_mp + (mp_lv * current_level),
    base_p_atk + (p_atk_lv * current_level),
    base_m_atk + (m_atk_lv * current_level)
    INTO hp, mp, p_atk, m_atk
    FROM classes
    WHERE name = NEW.class_name;

    NEW.hp := hp;
    NEW.mp := mp;
    NEW.p_atk := p_atk;
    NEW.m_atk := m_atk;  

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger para atualizar o level do player
CREATE OR REPLACE TRIGGER level_up_down_trigger
BEFORE UPDATE OF exp ON players
FOR EACH ROW
EXECUTE FUNCTION update_player_level();

-- Trigger para atualizar os atributos do player após a criação dele
CREATE OR REPLACE TRIGGER setup_new_player
BEFORE INSERT ON players
FOR EACH ROW
EXECUTE FUNCTION update_player_attributes();