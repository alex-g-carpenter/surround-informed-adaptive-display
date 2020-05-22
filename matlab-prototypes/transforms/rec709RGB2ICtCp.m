% function [outputArg1,outputArg2] = rec709RGB2ICtCp(inputArg1,inputArg2)
% %RGB2ICTCP Summary of this function goes here
% %   Detailed explanation goes here
% outputArg1 = inputArg1;
% outputArg2 = inputArg2;

rgbs = [0, 0, 0;
        255, 0, 0;
        0, 255, 0;
        0, 0, 255;
        255, 255, 255];


rec709pm = [ 0.412453, 0.357580, 0.180423;
             0.212671, 0.715160, 0.072169;
             0.019334, 0.119193, 0.950227];

XYZ = rgbs*rec709pm;
         
% Define EOTF functions
EOTF = @(PQ) (max(PQ.^(32/2523)-(3424/4096),0) ./ ...
((2413/128)-(2392/128)*PQ.^(32/2523))).^(16384/2610)*10000;
invEOTF = @(Lin) (((3424/4096)+(2413/128)*(max(0,Lin)/10000).^(2610/16384)) ./ ...
(1+(2392/128)*(max(0,Lin)/10000).^(2610/16384))).^(2523/32);

XYZ2LMSmat = [0.3593 -0.1921 0.0071; 0.6976 1.1005 0.0748; -0.0359 0.0754 0.8433];
LMS2ICTCPmat = [2048 2048 0; 6610 -13613 7003; 17933 -17390 -543]'/4096;
ICTCP = bsxfun(@times, invEOTF(XYZ * XYZ2LMSmat) * LMS2ICTCPmat, [720, 360, 720]);



% end

