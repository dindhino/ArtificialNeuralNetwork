function [inputan] = normalisasi(inputan)
    minimal = min(inputan);
    maximal = max(inputan);
    newmin = 0.1;
    newmax = 0.9;
    for i=1:size(inputan,2)
        inputan(:,i) = ((inputan(:,i)-minimal(i))*(newmax-newmin)/(maximal(i)-minimal(i)))+newmin;
    end
end

