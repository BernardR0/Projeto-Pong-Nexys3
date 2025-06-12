library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top is
    Port (
        clk      : in  std_logic;
        btn_up   : in  std_logic;
        btn_down : in  std_logic;
        hsync    : out std_logic;
        vsync    : out std_logic;
        rgb      : out std_logic_vector(2 downto 0)
    );
end top;

architecture Behavioral of top is

    -- Sinais VGA
    signal pix_x     : integer range 0 to 799 := 0;
    signal pix_y     : integer range 0 to 524 := 0;
    signal video_on  : std_logic;
    signal p_tick    : std_logic;

    -- Lógica do jogo
    signal ball_x    : integer range 0 to 639 := 300;
    signal ball_y    : integer range 0 to 479 := 200;
    signal paddle_y  : integer range 0 to 439 := 200;

    -- Sinais debounce dos botões
    signal btn_up_db, btn_down_db : std_logic;

begin

    -- Gerador VGA
    vga_gen: entity work.vga_controller
        port map (
            clk       => clk,
            hsync     => hsync,
            vsync     => vsync,
            video_on  => video_on,
            pixel_x   => pix_x,
            pixel_y   => pix_y,
            p_tick    => p_tick
        );

    -- Debounce dos botões
    debounce_up: entity work.debounce
        port map (
            clk     => clk,
            btn_in  => btn_up,
            btn_out => btn_up_db
        );

    debounce_down: entity work.debounce
        port map (
            clk     => clk,
            btn_in  => btn_down,
            btn_out => btn_down_db
        );

    -- Movimento da raquete
    process(clk)
    begin
        if rising_edge(clk) then
            if p_tick = '1' then
                if btn_up_db = '1' and paddle_y > 0 then
                    paddle_y <= paddle_y - 2;
                elsif btn_down_db = '1' and paddle_y < 439 then
                    paddle_y <= paddle_y + 2;
                end if;
            end if;
        end if;
    end process;

    -- Controle da bola
    ball_logic: entity work.ball_control
        port map (
            clk      => clk,
            p_tick   => p_tick,
            ball_x   => ball_x,
            ball_y   => ball_y,
            paddle_y => paddle_y
        );

    -- Renderização da tela
    renderer: entity work.renderer
        port map (
            pixel_x   => pix_x,
            pixel_y   => pix_y,
            video_on  => video_on,
            ball_x    => ball_x,
            ball_y    => ball_y,
            paddle_y  => paddle_y,
            rgb       => rgb
        );

end Behavioral;
