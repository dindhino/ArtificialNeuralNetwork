function [y1] = myNeuralNetworkFunction(x1)
%MYNEURALNETWORKFUNCTION neural network simulation function.
%
% Generated by Neural Network Toolbox function genFunction, 24-Nov-2017 02:43:45.
%
% [y1] = myNeuralNetworkFunction(x1) takes these arguments:
%   x = Qx10 matrix, input #1
% and returns:
%   y = Qx4 matrix, output #1
% where Q is the number of samples.

%#ok<*RPMT0>

% ===== NEURAL NETWORK CONSTANTS =====

% Input 1
x1_step1.xoffset = [1;-6;-32;-85;75;10;-39;24;17;45];
x1_step1.gain = [0.00735294117647059;0.00704225352112676;0.00609756097560976;0.00163132137030995;0.00775193798449612;0.01;0.0104712041884817;0.0198019801980198;0.0165289256198347;0.0256410256410256];
x1_step1.ymin = -1;

% Layer 1
b1 = [-0.85366170343099457;0.056085290806603752;1.7812463507979288;-2.7779049558517936];
IW1_1 = [1.3169008387208703 0.61870504906222346 -0.64744388102392114 -1.888316791760988 -0.17047137007102095 -0.20739808993996434 0.86934756105259547 1.3668110251973857 1.1372237188052325 -0.55589949070620115;-1.6508497213375204 -0.22799354430342428 -0.15819232256332824 0.39792736227525277 -1.2240839884148413 0.56172725358597131 0.65924951625869965 -3.2504987268015095 -0.72379507166238732 0.048223662107552696;-0.44885058718596393 -0.095318738079997245 -3.8599048103405051 -0.83875861702795551 4.1105650264955091 3.9067821333279151 -2.383178416218886 -3.137873774594691 6.8101565462294404 -0.163451046439439;2.4008563922610948 -0.71833825948258001 -1.5483123958944802 5.9061131849372366 0.27472853574451772 1.7619593957531001 0.89081571164066642 0.19825582702391498 -1.6018855349885113 -1.9333052169070848];

% Layer 2
b2 = [2.3814739450654798;-1.5206959225416445;4.1407865458634827;-7.11056569588931];
LW2_1 = [11.189748703375285 15.026423913013144 -9.1106772982613435 2.9993989516413242;0.32232825641761831 -12.822942146710217 5.7494914067625027 6.2648381844931853;-0.34952687658335047 -2.4124330800478271 0.5130876864449605 1.0445017258706097;-11.307689901493589 -2.116073473926519 4.9136766982676656 -8.120046660461524];

% ===== SIMULATION ========

% Dimensions
Q = size(x1,1); % samples

% Input 1
x1 = x1';
xp1 = mapminmax_apply(x1,x1_step1);

% Layer 1
a1 = tansig_apply(repmat(b1,1,Q) + IW1_1*xp1);

% Layer 2
a2 = softmax_apply(repmat(b2,1,Q) + LW2_1*a1);

% Output 1
y1 = a2;
y1 = y1';
end

% ===== MODULE FUNCTIONS ========

% Map Minimum and Maximum Input Processing Function
function y = mapminmax_apply(x,settings)
y = bsxfun(@minus,x,settings.xoffset);
y = bsxfun(@times,y,settings.gain);
y = bsxfun(@plus,y,settings.ymin);
end

% Competitive Soft Transfer Function
function a = softmax_apply(n,~)
if isa(n,'gpuArray')
    a = iSoftmaxApplyGPU(n);
else
    a = iSoftmaxApplyCPU(n);
end
end
function a = iSoftmaxApplyCPU(n)
nmax = max(n,[],1);
n = bsxfun(@minus,n,nmax);
numerator = exp(n);
denominator = sum(numerator,1);
denominator(denominator == 0) = 1;
a = bsxfun(@rdivide,numerator,denominator);
end
function a = iSoftmaxApplyGPU(n)
nmax = max(n,[],1);
numerator = arrayfun(@iSoftmaxApplyGPUHelper1,n,nmax);
denominator = sum(numerator,1);
a = arrayfun(@iSoftmaxApplyGPUHelper2,numerator,denominator);
end
function numerator = iSoftmaxApplyGPUHelper1(n,nmax)
numerator = exp(n - nmax);
end
function a = iSoftmaxApplyGPUHelper2(numerator,denominator)
if (denominator == 0)
    a = numerator;
else
    a = numerator ./ denominator;
end
end

% Sigmoid Symmetric Transfer Function
function a = tansig_apply(n,~)
a = 2 ./ (1 + exp(-2*n)) - 1;
end