close all;
clear;
clc;

% read data
datatest = xlsread('Testset.xls');
% testing jst
y_prediksi = myNeuralNetworkFunction(datatest);
% decode
y_prediksi = decode(y_prediksi);

% save hasilTesting y_prediksi
% write to excel file
filename = 'TestsetTugas2.xlsx';
xlswrite(filename,y_prediksi);