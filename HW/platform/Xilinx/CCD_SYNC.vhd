------------------------------------------------------------------------------
-- Copyright [2014] [Ztachip Technologies Inc]
--
-- Author: Vuong Nguyen
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
-- http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
------------------------------------------------------------------------------

---
-- Synchronize a signal accross different clock domain
---

library std;
use std.standard.all;
LIBRARY ieee;
Library xpm;
USE ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
use xpm.vcomponents.all;

entity CCD_SYNC is
   generic 
   (
      WIDTH  : natural
   );
   port 
   (
      SIGNAL reset_in    : in std_logic;
      SIGNAL inclock_in  : in std_logic;
      SIGNAL outclock_in : in std_logic;
      SIGNAL input_in    : in std_logic_vector(WIDTH-1 downto 0);
      SIGNAL output_out  : out std_logic_vector(WIDTH-1 downto 0)
   );
end CCD_SYNC;

architecture rtl of CCD_SYNC is
--signal input_r:std_logic_vector(WIDTH-1 downto 0);
--signal input_rr:std_logic_vector(WIDTH-1 downto 0);
--signal input_rrr:std_logic_vector(WIDTH-1 downto 0);
begin

xpm_cdc_array_single_inst : xpm_cdc_array_single
   generic map (
      DEST_SYNC_FF => 3,   -- DECIMAL; range: 2-10
      INIT_SYNC_FF => 0,   -- DECIMAL; 0=disable simulation init values, 1=enable simulation init values
      SIM_ASSERT_CHK => 0, -- DECIMAL; 0=disable simulation messages, 1=enable simulation messages
      SRC_INPUT_REG => 0,  -- DECIMAL; 0=do not register input, 1=register input
      WIDTH => WIDTH           -- DECIMAL; range: 1-1024
   )
   port map (
      dest_out => output_out, -- WIDTH-bit output: src_in synchronized to the destination clock domain. This
                              -- output is registered.
      dest_clk => outclock_in, -- 1-bit input: Clock signal for the destination clock domain.
      src_clk => inclock_in,   -- 1-bit input: optional; required when SRC_INPUT_REG = 1
      src_in => input_in      -- WIDTH-bit input: Input single-bit array to be synchronized to destination clock
                              -- domain. It is assumed that each bit of the array is unrelated to the others.
                              -- This is reflected in the constraints applied to this macro. To transfer a binary
                              -- value losslessly across the two clock domains, use the XPM_CDC_GRAY macro
                              -- instead.
   );

--output_out <= input_rrr;

--process(clock_in,reset_in)
--begin
--   if(reset_in='0') then
--      input_r <= (others=>'0');
--      input_rr <= (others=>'0');
--      input_rrr <= (others=>'0');
--   else
--      if(rising_edge(clock_in)) then 
--         input_r <= input_in;
--         input_rr <= input_r;
--         input_rrr <= input_rr;     
--      end if;
--   end if;
--end process;

end rtl;