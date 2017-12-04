close all;
clear;
clc;

% load data set
settrain = xlsread('Trainset.xls');
% data training
datatrain = settrain(:,1:10);
% kelas tiap data object
kelastrain = encode(settrain(:,11));