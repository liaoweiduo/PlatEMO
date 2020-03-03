objSet = result{100,2}.objs;
varargin = {'-algorithm', @SMSEMOA, '-problem', @DTLZ3, '-N', 100, '-M', 3};
Global = GLOBAL(varargin{:});
PF = Global.problem.PF(10000);
igd = IGD(objSet, PF);

figure()
Draw(objSet);
title(['IGD:', num2str(igd)])