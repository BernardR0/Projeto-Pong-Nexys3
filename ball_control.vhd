library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ball_control is
    Port (
        clk      : in  std_logic;
        p_tick   : in  std_logic;
        ball_x   : out integer range 0 to 639;
        ball_y   : out integer range 0 to 479;
        paddle_y : in  integer range 0 to 439
    );
end ball_control;

architecture Behavioral of ball_control is

    signal x : integer range 0 to 639 := 300;
    signal y : integer range 0 to 479 := 200;
    signal dx : integer := 1;
    signal dy : integer := 1;

begin

    process(clk)
    begin
        if rising_edge(clk) then
            if p_tick = '1' then
                -- Movimento
                x <= x + dx;
                y <= y + dy;

                -- Colisão vertical
                if y <= 0 or y >= 472 then
                    dy <= -dy;
                end if;

                -- Colisão com raquete
                if x = 15 and y >= paddle_y and y <= paddle_y + 40 then
                    dx <= -dx;
                end if;

                -- Perdeu (reinicia no centro)
                if x <= 0 then
                    x <= 320;
                    y <= 240;
                    dx <= 1;
                    dy <= 1;
                end if;

                -- Borda direita
                if x >= 632 then
                    dx <= -dx;
                end if;
            end if;
        end if;
    end process;

    ball_x <= x;
    ball_y <= y;

end Behavioral;
