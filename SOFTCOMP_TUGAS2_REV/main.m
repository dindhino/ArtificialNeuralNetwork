close all;
clear;
clc;

datasettrain = xlsread('Trainset.xls');
dtrain = datasettrain(:,1:10);
ktrain = datasettrain(:,11);
% preprocessing
dtrain = normalisasi(dtrain);

k = 10;
[dataval,datatrain, kelasval, kelastrain] = KFoldCrossValidation(dtrain, ktrain, k);

for fold=1:k
    fprintf('k=%i\n',fold);
    trainingJST(cell2mat(datatrain(fold)), encode(cell2mat(kelastrain(fold))));
    testingJST(cell2mat(dataval(fold)), cell2mat(kelasval(fold)));
end