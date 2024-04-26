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