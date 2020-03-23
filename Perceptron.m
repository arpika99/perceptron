clear all;
close all;
% az AND kapu bemenetei
in = [0, 0; 0, 1; 1, 0; 1, 1];
% az AND kapu kimenetei
out = [0, 0, 0, 1];
% H vagy I bemenet
in2 = [1,0,1,1,1,1,1,0,1;0,1,0,0,1,0,0,1,0];
% H vagy I kimenet
out2 = [1,0];
    
% az AND kapunal (in, out) a H vagy I betuknel (in2,out2)
w = train_network(in, out);

%teszt
%az AND kapunal 'in'-ig megyunk a H vagy I betuknel 'in2'-ig
for i = 1 : size(in, 1)
    hardlim(w'*[1, in(i, :)]')
end

function [w] = train_network(train_data, expected_output)
    w = rand(size(train_data, 2) + 1, 1);
    lr = .001;
    E = 1;
    % kirajzolom a hibák számát, hogy lássam a tanulás mukodik
    figure(); hold on; q = 0;
   	while E ~= 0
        E = 0;
        for i = 1 : size(train_data, 1)
            d = expected_output(i);
            x = [1, train_data(i, :)]';
            s = w'*x;
            y = hardlim(s);
            err = d - y;
            E = E + err*err';
            w = w + lr*err*x;
        end
        q = q + 1;
        plot(q, E, '*-');
    end
end