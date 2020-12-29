clear 

Problem = 'Musk1';
coreNumber = 8;
Algorithm = ['oipMOEA/D-FS-',num2str(coreNumber)];
timeCostCore_oip = [
[89930,    34510, 46672, 65779, 84745, 81173, 87124, 86905, 89918,]
[104280,  37722, 47472, 61834, 74874, 96115, 104270, 103618, 101228,]
[94384,    37258, 48120, 62212, 74835, 86695, 94376, 86748, 82764,]
[97401,    37240, 47035, 62321, 78408, 89198, 94782, 97392, 92414,]
[96403,    33761, 44390, 62085, 75021, 84703, 94433, 94932, 96393,]
[98347,    40106, 46969, 66395, 86707, 86691, 89168, 98337, 94784,]
[88519,    34431, 46117, 59606, 70090, 80048, 88509, 86292, 83891,]
[92003,    35678, 46230, 68752, 82575, 85117, 82924, 85034, 91993,]
[101414,  37050, 44422, 61084, 79830, 98247, 101406, 100371, 96378,]
[97959,    32419, 44554, 60461, 74584, 91643, 96965, 97949, 94911,]
[90712,    38538, 45121, 56897, 79195, 88440, 90705, 81595, 79062,]
[97564,    39707, 47842, 65992, 83717, 91070, 97556, 95589, 90045,]
[82095,    40234, 45302, 62678, 76761, 81415, 79373, 81113, 82086,]
[95085,    34431, 48043, 61947, 84880, 95074, 92219, 83799, 85100,]
[102228,  38565, 46516, 63131, 76199, 87579, 102218, 99173, 91911,]
[97312,    36041, 47791, 61029, 81801, 88080, 97303, 83481, 82046,]];
Algorithm = ['aspMOEA/D-FS-',num2str(coreNumber)];
timeCostCore_asp = [
[87091,    87083, 72619, 77966, 72155, 70643, 78777, 70051, 68526,]
[83535,    83531, 72474, 77921, 82554, 78579, 74342, 68302, 63235,]
[92298,    92290, 71515, 78354, 92024, 80443, 68959, 62224, 62498,]
[84988,    84982, 71594, 75128, 74899, 69656, 69297, 58702, 61671,]
[84875,    84869, 67331, 81158, 71985, 75567, 73436, 65626, 58875,]
[90565,    90560, 75146, 84664, 84915, 87994, 77900, 65628, 64118,]
[86172,    86166, 69467, 81980, 81718, 77801, 76025, 66373, 68244,]
[91459,    91454, 72371, 87984, 78816, 76914, 72307, 61421, 62661,]
[85144,    84284, 68986, 76405, 82144, 85135, 83804, 73904, 77568,]
[91391,    91386, 71481, 82339, 79467, 74999, 69652, 61054, 61078,]
[87793,    87786, 69826, 76332, 83043, 74921, 69184, 61950, 63476,]
[86125,    86118, 68872, 79331, 75526, 72831, 80115, 72051, 69224,]
[82645,    82638, 66036, 79848, 74315, 75418, 67685, 60775, 60067,]
[88593,    88589, 71105, 81018, 76309, 77884, 78055, 67268, 69409,]
[89460,    89454, 70945, 79510, 74632, 73454, 70176, 68054, 63403,]
[86554,    86548, 68260, 78183, 81740, 76724, 76063, 68800, 66321,]
[83140,    83135, 65757, 80459, 80502, 70952, 72340, 63869, 67156,]
[84077,    84072, 70144, 78460, 73396, 67983, 60258, 55672, 56427,]
[85261,    85255, 66155, 77366, 80276, 75392, 74493, 67201, 65086,]
[91127,    84919, 70542, 81721, 84730, 91119, 82182, 71171, 73422,]
[90985,    90979, 69021, 80588, 78722, 74500, 76077, 73898, 66200,]];
Algorithm = ['rdpMOEA/D-FS-',num2str(coreNumber)];
timeCostCore_rdp = [
[79885,    65691, 71593, 68139, 68674, 74011, 79839, 79875, 76722,]
[88227,    61232, 66203, 67127, 73919, 78520, 83643, 86627, 88216,]
[86865,    62899, 65889, 68691, 71073, 74430, 81444, 82111, 86854,]
[90682,    70262, 73547, 77632, 79432, 83750, 84066, 90674, 89864,]
[82778,    67787, 67870, 65850, 65516, 73349, 76242, 82218, 82770,]
[88342,    59915, 64088, 68613, 73376, 79976, 83405, 84932, 88335,]
[83395,    59419, 65233, 70966, 77935, 81987, 83332, 83385, 79586,]
[79180,    58719, 56038, 61335, 64196, 76142, 78078, 78419, 79175,]
[91801,    64741, 67738, 74320, 75037, 78117, 81324, 91789, 88416,]];
AverageTimeCostCore = [mean(timeCostCore_oip(:,2:end));
%                        mean(timeCostCore_asp(:,2:end));
%                        mean(timeCostCore_rdp(:,2:end));
                       ];

figure()
hold on
title([Problem,' processor number:', num2str(coreNumber)])
bar(AverageTimeCostCore')
legend(['oipMOEA/D-FS-',num2str(coreNumber)])%,['aspMOEA/D-FS-',num2str(coreNumber)],['rdpMOEA/D-FS-',num2str(coreNumber)])
xlabel('processor index')
ylabel('average computation time')