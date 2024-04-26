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
