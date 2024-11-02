function [final_codeword] = encode1(data_input, divisor_input)
% encode1 takes a data_input and divisor_input as inputs
% encode1 outputs the CRC value final_codeword

data_len = length(data_input);
div_len = length(divisor_input) - 1;
data_input = bin2dec(data_input); % Convert binary string to decimal
divisor_input = bin2dec(divisor_input);
divisor_input = bitshift(divisor_input, data_len - div_len - 1); % Align divisor with data_input
divisor_input = bitshift(divisor_input, div_len); % Shift divisor to the appropriate degree
remainder = bitshift(data_input, div_len); % Shift data_input for division

% Perform division to calculate the remainder
for i = 1:data_len
    if bitget(remainder, data_len + div_len)
        remainder = bitxor(remainder, divisor_input); % XOR the remainder with the divisor
    end
    remainder = bitshift(remainder, 1); % Shift remainder to the left by 1
end

% Calculate the CRC check value
crc_value = bitshift(remainder, -data_len);
crc_value = dec2bin(crc_value); % Convert remainder back to binary
crc_value = pad(crc_value, div_len, 'left', '0'); % Pad the CRC value with leading zeros if necessary
data_input = dec2bin(data_input); % Convert data_input back to binary

% Append the CRC value to the original data to form the final codeword
final_codeword = append(data_input, crc_value);
end
