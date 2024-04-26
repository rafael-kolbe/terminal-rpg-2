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