% ------------------------------------------------------------------------
% Nicholas Hobar
% ASEN 5148 Spacecraft Design
% Homework 1
% Problem 2
% ------------------------------------------------------------------------

%% A)
varFilepathSize = 60; % 60 bytes = 480 bits
varFileLoadSize = 2; % 16 bit command
varStartSize = 2; % 16 bits
varDestinationSize = 2; % 16 bits
varPrecedingByte = 1;
varStartCom = varStartSize + varDestinationSize + varPrecedingByte; % Start command with preceding byte
varStopSize = 2; % 16 bits
varStopCom = varStopSize + varDestinationSize + varPrecedingByte;
varFileLoadCom = varFileLoadSize + varDestinationSize + varFilepathSize + (2*varPrecedingByte);
varSeqMax = (12*varFileLoadCom) + (100*varStartCom) + (100*varStopCom);

fixFilepathSize = 60;
fixFileLoadSize = 2;
fixStartSize = 2;
fixStopSize = 2;
fixDestinationSize = 2;
fixStartCom = fixStartSize + fixDestinationSize;
fixStopCom = fixStopSize + fixDestinationSize;
fixFileLoadCom = fixFileLoadSize + fixDestinationSize + fixFilepathSize;
fixSeqMax = (12*fixFileLoadCom) + (100*fixStartCom) + (100*fixStopCom);

varFilepathSize = 1:0.001:60;
varFileLoadCom = varFileLoadSize + varDestinationSize + varFilepathSize + (2*varPrecedingByte);
varSeq = (12*varFileLoadCom) + (100*varStartCom) + (100*varStopCom);

hold on
figure(1)
plot (varFilepathSize, varSeq)
yline(fixSeqMax,'--')
plot (varFilepathSize(40335),varSeq(40335),'*')

title('Problem 2A — Avg Filepath Size vs. Total Sequence Size')
xlabel('Average Filepath Size (bytes)')
ylabel('Total Sequence File Size (bytes)')
hold off

%% B)
% Only difference from the above is no preceding byte on START/STOP
varFilepathSize = 60; % 60 bytes = 480 bits
varFileLoadSize = 2; % 16 bit command
varStartSize = 2; % 16 bits
varDestinationSize = 2; % 16 bits
varPrecedingByte = 1;
varStartCom = varStartSize + varDestinationSize; % Start command with preceding byte
varStopSize = 2; % 16 bits
varStopCom = varStopSize + varDestinationSize;
varFileLoadCom = varFileLoadSize + varDestinationSize + varFilepathSize + (2*varPrecedingByte);
varSeqMax = (12*varFileLoadCom) + (100*varStartCom) + (100*varStopCom);

fixFilepathSize = 60;
fixFileLoadSize = 2;
fixStartSize = 2;
fixStopSize = 2;
fixDestinationSize = 2;
fixStartCom = fixStartSize + fixDestinationSize;
fixStopCom = fixStopSize + fixDestinationSize;
fixFileLoadCom = fixFileLoadSize + fixDestinationSize + fixFilepathSize;
fixSeqMax = (12*fixFileLoadCom) + (100*fixStartCom) + (100*fixStopCom);

varFilepathSize = 1:0.001:60;
varFileLoadCom = varFileLoadSize + varDestinationSize + varFilepathSize + (2*varPrecedingByte);
varSeq = (12*varFileLoadCom) + (100*varStartCom) + (100*varStopCom);

figure(2)
hold on
plot (varFilepathSize, varSeq)
yline(fixSeqMax,'--')
plot (varFilepathSize(56997),varSeq(56997),'*')

title('Problem 2B — Avg Filepath Size vs. Total Sequence Size')
xlabel('Average Filepath Size (bytes)')
ylabel('Total Sequence File Size (bytes)')
hold off