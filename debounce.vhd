library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity debounce is
    generic (
        CLK_FREQ_HZ : integer := 100_000_000;  -- 100 MHz
        DEBOUNCE_TIME_MS : integer := 10       -- 10 milissegundos
    );
    Port (
        clk      : in  std_logic;
        btn_in   : in  std_logic;
        btn_out  : out std_logic
    );
end debounce;

architecture Behavioral of debounce is
    constant MAX_COUNT : integer := CLK_FREQ_HZ / 1000 * DEBOUNCE_TIME_MS;
    signal counter : integer range 0 to MAX_COUNT := 0;
    signal btn_sync_0, btn_sync_1 : std_logic := '0';
    signal btn_state : std_logic := '0';
begin

    -- Sincroniza o botão ao clock
    process(clk)
    begin
        if rising_edge(clk) then
            btn_sync_0 <= btn_in;
            btn_sync_1 <= btn_sync_0;
        end if;
    end process;

    -- Debounce
    process(clk)
    begin
        if rising_edge(clk) then
            if btn_sync_1 /= btn_state then
                counter <= counter + 1;
                if counter = MAX_COUNT then
                    btn_state <= btn_sync_1;
                    counter <= 0;
                end if;
            else
                counter <= 0;
            end if;
        end if;
    end process;

    btn_out <= btn_state;
end Behavioral;
