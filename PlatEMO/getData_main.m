parfor run = 1:20
main('-algorithm', {@SMSEMOA_optimal},'-problem', @MPDMP,... 
    '-N', 30, '-M', 10, '-evaluation', 10000,...
    '-save', 100, '-run', run);
end
