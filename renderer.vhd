library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity renderer is
    Port (
        pixel_x   : in  integer range 0 to 799;
        pixel_y   : in  integer range 0 to 524;
        video_on  : in  std_logic;
        ball_x    : in  integer range 0 to 639;
        ball_y    : in  integer range 0 to 479;
        paddle_y  : in  integer range 0 to 439;
        rgb       : out std_logic_vector(2 downto 0)
    );
end renderer;

architecture Behavioral of renderer is
begin
    process(pixel_x, pixel_y, video_on, ball_x, ball_y, paddle_y)
    begin
        if video_on = '1' then
            if (pixel_x >= ball_x and pixel_x < ball_x + 8 and
                pixel_y >= ball_y and pixel_y < ball_y + 8) then
                rgb <= "111";  -- Branco: bola
            elsif (pixel_x >= 10 and pixel_x < 15 and
                   pixel_y >= paddle_y and pixel_y < paddle_y + 40) then
                rgb <= "010";  -- Verde: raquete
            else
                rgb <= "000";  -- Preto: fundo
            end if;
        else
            rgb <= "000";
        end if;
    end process;
end Behavioral;
