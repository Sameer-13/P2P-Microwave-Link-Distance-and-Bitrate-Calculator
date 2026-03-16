fc = 5e9; % Carrier frequency in Hz
T = 10000; % Receiver noise temperature in Kelvin
B = 2e6; % Bandwidth in Hz
h1 = 12; % Tower height in meters
h2 = 12; % Tower height in meters
Pt = 40; % Transmit power in Watts
Gt_dB = 20; % Transmit antenna gain in dB
Gr_dB = 20; % Receive antenna gain in dB

% Print the menu
choice = input('Choose a function:\n1. Maximum separation between towers d (km)\n2. Maximum possible bit rate R (Mb/s)');

function d = computeMaxSpacing(R)
    fc = 5e9; % Carrier frequency in Hz
    T = 10000; % Receiver noise temperature in Kelvin
    B = 2e6; % Bandwidth in Hz
    h1 = 12; % Tower height in meters
    h2 = 12; % Tower height in meters
    Pt = 40; % Transmit power in Watts
    Gt_dB = 20; % Transmit antenna gain in dB
    Gr_dB = 20; % Receive antenna gain in dB
    % Convert R from Mb/s to b/s
    R = R * 1e6;
    % Find lambda:
    c = 3e8; % Speed of light in m/s
    lambda = c / fc;
    
    % Gain in linear scale
    Gt = 10^(Gt_dB / 10);
    Gr = 10^(Gr_dB / 10);

    % Find N0:
    k = 1.38e-23; % Boltzmann constant in J/K
    NO = k * T * B;

    % Find Pr:
    Pr = (2^(R/B) - 1) * NO;

    % Find d1:
    d1 = lambda/(4*pi * sqrt((Pr/Pt)/(Gr*Gt)));
    d1_km = d1/1000; % Convert to Km

    % Find d2 in Km:
    d2 =  3.57 * (sqrt(4/3*h1) + sqrt(4/3*h2));

    % Find the minimum of d1 and d2:
    d = min(d1_km, d2);

    fprintf('\n| Maximum separation between towers d (km) = min(d1, d2)\n|\n|_ d1 is the distance between txer and rxer in the free space formula\n| |_ L = Pt/Pr = [(4pi*d1)/lambda]^2\n| | |_ d1 = Lambda/(4pi * sqrt((Pr/Pt)/GrGt))\n| |   |_ To find d1, we have to find Pr,using Shannon capacity formula:\n| |     |_ R = B * log2(1 + (SNR))\n| |       |_ SNR = 2^R/B - 1\n| |       |_ SNR = Pr/N0, where N is the noise power = T * B * k(Blotzman constant)\n| |              |_ Pr = (2^R/B - 1) * N0 = %f watts', Pr);
    
    if(Pr > Pt)
        fprintf('\n|_ Since Pr > Pt, The System is infeasible.\n|_ Suggestions: Increase power or gain.\n');
        d = 0;
        return;
    else
        fprintf('\n| |\n| |_ d1 = %f m\n| |_ d1_km = %f km\n|\n|_ d2 is the max distance allowed by Earths curvature:\n| |_ d2  = 3.57 * [sqrt(4/3*h1) + sqrt(4/3*h2)], where h1 and h2 are the heights of the towers\n| |_ d2 = %f km \n|\n|_ Maximum separation = %f km', d1, d1_km, d2, d);
    end
end

function R = computeMaxBitRate(d)
fc = 5e9; % Carrier frequency in Hz
T = 10000; % Receiver noise temperature in Kelvin
B = 2e6; % Bandwidth in Hz
h1 = 12; % Tower height in meters
h2 = 12; % Tower height in meters
Pt = 40; % Transmit power in Watts
Gt_dB = 20; % Transmit antenna gain in dB
Gr_dB = 20; % Receive antenna gain in dB
    % Find d2 in Km:
    d2 =  3.57 * (sqrt(4/3*h1) + sqrt(4/3*h2));
    if(d > d2)
        disp('|_ Since d is larger than the maximum distance allowed by Earths curvature, The System is infeasible.\n|_ Suggestions: Decrease tower spacing.\n');
        R = 0;
        return;
    end
    % Convert d to meters
    d_m = d * 1000;
    
    % Gain in linear scale
    Gt = 10^(Gt_dB / 10);
    Gr = 10^(Gr_dB / 10);
    
    % Friis Transmission Equation
    c=3e8;
    lambda = c / fc;
    
    % Finds Pr:
    k = 1.38e-23; % Boltzmann constant in J/K
    NO = k * T * B;

    % Calculate Pr using the Friis transmission equation
    Pr = Pt * Gt * Gr * (lambda / (4 * pi * d_m))^2; % d1 converted to meters

    fprintf('\n| Maximum possible bit rate 𝑅 (Mb/s), using Shannon capacity formula:\n| |_ R = B * log2(1 + (SNR))\n|   |_ SNR = 2^R/B - 1 \n|     |_ SNR = Pr/N0, where N is the noise power = T * B * k(Blotzman constant) \n|       |_ using the Friis transmission equation:\n|       |_ Pr = Pt * Gt * Gr * (lambda / (4 * pi * d_m))^2 = %f watts \n', Pr);
    
    if(Pr > Pt)
        disp('|_ Since Pr > Pt, The System is infeasible.\n|_ Suggestions: Increase power or gain.\n');
        R = 0;
        return;
    else
        SNR = Pr / NO;
        % Calculate the maximum possible bit rate in Mb/s
        R = B * log2(1 + SNR) / 1e6;
        fprintf('|_ Maximum possible bit rate R = %f Mb/s\n', R);
    end
end


switch choice
    case 1
        R = input('Enter target bit rate R (Mb/s): ');
        % Call the function for minimum tower spacing
        d = computeMaxSpacing(R);
    case 2
        d = input('Enter tower spacing d (km): ');
        % Call the function for maximum possible bit rate
        R = computeMaxBitRate(d);
end