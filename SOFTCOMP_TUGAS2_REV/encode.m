function [dataout] = encode(datain)
%     untuk klasifikasi ada 4 kelas -> 1 2 3 4
%     di encode menjadi:
%     1 = 1 0 0 0
%     2 = 0 1 0 0
%     3 = 0 0 1 0
%     4 = 0 0 0 1
    dataout = zeros(size(datain,1), 4);
    for i=1:size(datain,1)
        dataout(i, datain(i)) = 1;
    end
end

