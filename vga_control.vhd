library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity vga_controller is
    Port (
        clk       : in  std_logic;
        hsync     : out std_logic;
        vsync     : out std_logic;
        video_on  : out std_logic;
        pixel_x   : out integer range 0 to 799;
        pixel_y   : out integer range 0 to 524;
        p_tick    : out std_logic
    );
end vga_controller;

architecture Behavioral of vga_controller is

    constant H_DISPLAY : integer := 640;
    constant H_FRONT   : integer := 16;
    constant H_SYNC    : integer := 96;
    constant H_BACK    : integer := 48;
    constant H_TOTAL   : integer := H_DISPLAY + H_FRONT + H_SYNC + H_BACK;

    constant V_DISPLAY : integer := 480;
    constant V_FRONT   : integer := 10;
    constant V_SYNC    : integer := 2;
    constant V_BACK    : integer := 33;
    constant V_TOTAL   : integer := V_DISPLAY + V_FRONT + V_SYNC + V_BACK;

    signal h_count : integer range 0 to H_TOTAL - 1 := 0;
    signal v_count : integer range 0 to V_TOTAL - 1 := 0;

    signal clk_div : integer := 0;
    signal pix_tick : std_logic := '0';

begin

    -- Geração do pixel clock ~25MHz (divisor simples do clk de 100MHz)
    process(clk)
    begin
        if rising_edge(clk) then
            if clk_div = 3 then
                clk_div <= 0;
                pix_tick <= '1';
            else
                clk_div <= clk_div + 1;
                pix_tick <= '0';
            end if;
        end if;
    end process;

    process(clk)
    begin
        if rising_edge(clk) then
            if pix_tick = '1' then
                if h_count = H_TOTAL - 1 then
                    h_count <= 0;
                    if v_count = V_TOTAL - 1 then
                        v_count <= 0;
                    else
                        v_count <= v_count + 1;
                    end if;
                else
                    h_count <= h_count + 1;
                end if;
            end if;
        end if;
    end process;

    hsync <= '0' when (h_count >= H_DISPLAY + H_FRONT and h_count < H_DISPLAY + H_FRONT + H_SYNC) else '1';
    vsync <= '0' when (v_count >= V_DISPLAY + V_FRONT and v_count < V_DISPLAY + V_FRONT + V_SYNC) else '1';

    video_on <= '1' when (h_count < H_DISPLAY and v_count < V_DISPLAY) else '0';

    pixel_x <= h_count;
    pixel_y <= v_count;
    p_tick  <= pix_tick;

end Behavioral;
