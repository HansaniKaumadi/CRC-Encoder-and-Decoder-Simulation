p = 0.5; % Probability of bit flip in the binary symmetric channel (BSC)
encodedData = encode1('101001111', '10111'); % Encode the data using the given divisor

% Convert the encodedData (binary string) to a logical array
encodedDataLogical = encodedData - '0'; % This converts the character array to a logical array

% Transmit the encoded data through a binary symmetric channel
receivedData = bsc(encodedDataLogical, p);

% Convert the received data back to a binary string for decoding
receivedDataString = char(receivedData + '0'); % Convert logical array back to string

% Decode the received data and get the syndrome value
syndrome = decode1(receivedDataString, '10111');

% Display the syndrome to check if there is an error
disp('Syndrome (Error Check Value):');
disp(syndrome);
