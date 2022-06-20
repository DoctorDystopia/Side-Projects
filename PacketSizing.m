%%------------------------------------------------------------------------%
% ASEN 5148 Spacecraft Design
% HERMES Frame Sizing
% Nicholas Hobar
%%------------------------------------------------------------------------%

clc
clear
close all

%% Sizing DTN Bundle Protocol Bundles
% Using Licklider Transmission Protocol blocks to segment bundles at
% convergence layer

%% Sizing Licklider Transmission Protocol (LTP) Blocks and Window
% Window is maximum number of transmit sessions allowed at one time. If it
% is too low, the system is not efficient, if it is too high, then too many
% LTP blocks will be incomplete at the end of a communication pass

%% Sizing Space Packet Protocol Packets ----------------------------------%

%Packet = ; % Space Packet Protocol: "at least 7 and at most 65542 octets"
% Packet Primary Header = 6 octets, Packet Data Field = 1 to 65536 octets

PVN = 3; % Packet Version Number, 3 bits
PcktType = 1; % Packet Type, 1 bit
ScHdrFlag = 1; % Secondary Header Flag, 1 bit
APID = 11; % Application Process ID, 11 bits
SqFlag = 2; % Sequence Flags, 2 bits
PcktSqCnt = 14; % Packet Sequence Count or Packet Name, 14 bits
PcktDataLength = 16; % Packet Data Length, 16 bits

PacketHeader = PVN + PcktType + ScHdrFlag + APID + SqFlag + PcktSqCnt +...
    PcktDataLength; % Packet Header Length, bits

%% Sizing Advanced Orbiting Systems (AOS) Frames -------------------------%
% We are assuming the use of the Space Data Link Security Protocol which
% provides data authentication an data confidentiality at Data Link Layer
%-------------------------------------------------------------------------%

dataRate = 1; % mbps
dataRateBPS = dataRate * 1E6; % bps

% Sizing for Engineering Data Virtual Channel
TF_PrimaryHeader = 8; % octets
%TF_InsertZone = ; % octets

SecurityHeader = 64; % octets, "less than or equal to 64 octets"
% 16 bit Secuirty Parameter Index + Initialization Vector + Sequence
% Number + Pad Length

TF_DataField = 922; % octets, integer number of octets = fixed TF length
% selected for a physical channel - (length of TF Primary Header +
% length of Security Header) - (length of TF Insert Zone of Sercurity
% Trailer + Insert Zone of TF Trailer)

%SecurityTrailer = ; % octets
OpControlField = 4; % octets
FrameErrorControlField = 2; % octets