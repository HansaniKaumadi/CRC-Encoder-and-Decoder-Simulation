% Generate 10000 random data values
randomData = randi([0 2^9-1],1,10^4,"uint16"); 
errorRates = zeros(1,8);
probabilityOfError = [0.5 0.4 0.3 0.2 0.1 0.01 0.00 0.0001];
for m = 1:8
    errorCount = 0;
    for n = 1:10^4
        % Add zeros to make the binary representation 9 bits long
        binaryData = pad(num2str(dec2bin(randomData(n))),9,'left','0'); 
        % Call the encode function
        encodedWord = encode1(binaryData,'10111'); 
        codeWordArray = zeros(1,13);
        % Store the encoded bits in an array
        for p = 1:length(encodedWord)
            codeWordArray(p) = str2double(encodedWord(p));
        end       
        % Pass the codeword through a binary symmetric channel
        modifiedCodewordArray = bsc(codeWordArray,probabilityOfError(m)); 
        modifiedCodeword = '';
        % Convert the modified codeword back to a string
        for q = 1:length(encodedWord)
            modifiedCodeword = append(modifiedCodeword, num2str(modifiedCodewordArray(q)));
        end
        % Decode the modified codeword
        decodedSyndrome = decode1(modifiedCodeword,'10111');
        % Check if an error occurred
        if decodedSyndrome ~= '0'
            errorCount = errorCount + 1;
        end
    end
    % Calculate and store the error rate
    newErrorRate = errorCount / 10000; 
    errorRates(m) = newErrorRate;
end

% Plot error rate vs. channel error probability
figure; % Open a new figure window
plot(probabilityOfError, errorRates, '-o'); % Plot with line and markers
xlabel('Channel Error Probability'); % X-axis label
ylabel('Error Rate'); % Y-axis label
title('Error Rate vs Channel Error Probability'); % Plot title
grid on; % Enable grid
