function [] = trainingJST(datatraining, target)
    % parameter
    neuroninput = size(datatraining,2); %banyaknya atribut
    neuronhidden = 10; %set random (trial & error)
    neuronoutput = 4; %soalnya ada 4 kelas
    epoch = 150; %set random
    learningrate = 0.15; %kalau kekecilan perubahan bobotnya kecil, tapi kalau kegedean bisa kurang optimal
    totalMSE = [];
    ndata = size(datatraining,1);

    % step 1: random decision boundaries / hyperplane
%     % random
%     bobot1 = rand(neuroninput, neuronhidden);
%     bobot2 = rand(neuronhidden, neuronoutput);
%     bias1 = rand(1, neuronhidden);
%     bias2 = rand(1, neuronoutput);
    
    % nguyen widrow
    beta1 = 0.7*(neuronhidden^(1/neuroninput));
    bobot1 = rand(neuroninput, neuronhidden)*range([-0.5 0.5])+(-0.5);
    vj1 = sqrt(sum(bobot1.^2));
    bobot1 = (beta1*bobot1);
    for i=1:neuronhidden
        bobot1(:,i) = bobot1(:,i)/vj1(i);
    end
    bias1 = rand(1, neuronhidden)*range([-beta1 beta1])+(-beta1);
    
    beta2 = 0.7*(neuronoutput^(1/neuronhidden));
    bobot2 = rand(neuronhidden, neuronoutput)*range([-0.5 0.5])+(-0.5);
    vj2 = sqrt(sum(bobot2.^2));
    bobot2 = (beta2*bobot2);
    for i=1:neuronoutput
        bobot2(:,i) = bobot2(:,i)/vj2(i);
    end
    bias2 = rand(1, neuronoutput)*range([-beta2 beta2])+(-beta2);

    % training, pake backpro 
    for i=1:epoch
%         i
        totalerror = [];
    %     mendapatkan error per data
        for j=1:ndata
    %         forward
            v1 = datatraining(j,:)*bobot1+bias1;
    %         fungsi aktivasi tanh dari input ke hidden
            A1 = (2./(1+exp(-2*v1)))-1;
    %         A1
            v2 = A1*bobot2+bias2;
    %         fungsi aktivasi softmax dari hidden ke output
            A2 = exp(v2)/sum(exp(v2));
    %         A2
            error = target(j,:) - A2;
            totalerror = [totalerror error];

    %         backward
            D2 = (A2.*(1-A2)).*error; % D2 pake turunan pertama dari softmax
    %         D1 pake turunan pertama dari tanh
            D1 = (1-A1.^2).*(bobot2*D2')';
            dBobot1 = learningrate * datatraining(j,:)'*D1;
            dBobot2 = (learningrate * D2' * A1)';
            dBias1 = learningrate * D1;
            dBias2 = learningrate * D2;

    %         perbaikan bobot
            bobot1 = bobot1 + dBobot1;
            bobot2 = bobot2 + dBobot2;

    %         perbaikan bias
            bias1 = bias1 + dBias1;
            bias2 = bias2 + dBias2;
        end
        MSE = mean(totalerror.^2);
        totalMSE = [totalMSE MSE];
    end
    hold on
    plot(totalMSE);
    save hasilTrainingJST bobot1 bobot2 bias1 bias2 totalMSE;
end