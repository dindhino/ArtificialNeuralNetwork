function [kelas] = prediksikelas(datatesting)
    % parameter
    ndata = size(datatesting,1);
    kelas = zeros(ndata, 4);

    load hasilTrainingJST;

    for i=1:ndata
    %     forward
        v1 = datatesting(i,:)*bobot1+bias1;
    %         fungsi aktivasi tanh dari input ke hidden
        A1 = (2./(1+exp(-2*v1)))-1;
        v2 = A1*bobot2+bias2;
    %     fungsi aktivasi softmax dari hidden ke output
        A2 = exp(v2)/sum(exp(v2));
        
        kelas(i,:) = A2;
    end

end

