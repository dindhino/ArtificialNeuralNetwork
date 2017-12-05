function [output] = decode(input)
%     untuk klasifikasi ada 4 kelas -> 1 2 3 4
%     di encode menjadi:
%     1 = 1 0 0 0
%     2 = 0 1 0 0
%     3 = 0 0 1 0
%     4 = 0 0 0 1
%     untuk decode, kelas adalah indeks yg memiliki nilai maksimum
    output = zeros(size(input,1),1);
    for i=1:size(input,1)
        [maks indeks] = max(input(i,:));
        output(i,1) = indeks;
    end
end

