function [error_check] = decode1(encoded_word, divisor_input)
% decode1 takes an encoded_word and divisor_input as inputs
% and outputs if there is an error (syndrome) or not

word_len = length(encoded_word); % Length of the encoded word
div_len = length(divisor_input) - 1; % Degree of the divisor
encoded_word = bin2dec(encoded_word); % Convert encoded word to decimal
divisor_input = bin2dec(divisor_input); % Convert divisor to decimal
divisor_input = bitshift(divisor_input, word_len - div_len - 1); % Align divisor with encoded word
divisor_input = bitshift(divisor_input, div_len); % Shift divisor to the appropriate degree
remainder = bitshift(encoded_word, div_len); % Shift encoded word for division

% Perform division to check for errors
for i = 1:word_len
    if bitget(remainder, word_len + div_len)
        remainder = bitxor(remainder, divisor_input); % XOR remainder with divisor if necessary
    end
    remainder = bitshift(remainder, 1); % Shift remainder to the left by 1
end

% Calculate the remainder to check for errors
remainder = bitshift(remainder, -word_len); % Shift back the remainder
error_check = dec2bin(remainder); % Convert remainder to binary to output error status

end
