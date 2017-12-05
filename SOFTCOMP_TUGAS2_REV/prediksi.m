close all;
clear;
clc;

datatest = xlsread('Testset.xls');
% preprocessing
datatest = normalisasi(datatest);

% prediksi kelas
y_prediksi = prediksikelas(datatest);
kelasprediksi = decode(y_prediksi);

% save hasilTesting kelasprediksi
% write to excel file
filename = 'TestsetTugas2.xlsx';
xlswrite(filename, kelasprediksi);