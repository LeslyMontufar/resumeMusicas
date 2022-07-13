clc; clear variables; close all; clear sound;
fs = 44.1e3;        % frequência de amostragem
nbits = 16;         % nro de bits da quantização do sinal
ncanais = 1;        % nro de canais: mono, estéreo

% GRAVAR = 0;
MULTISELECT = 2;

filename = 'sound1.mp4';
duration = 60;      % gravar por 60 seg = 1 min
startSec = 60;
add = 5;
selection_mode = MULTISELECT;

secStart = startSec*fs;
secStop = (startSec+duration)*fs;

if selection_mode == MULTISELECT
    [filename, path] = uigetfile('*', 'Select music', 'MultiSelect', 'on');
end
musicas = strcat(path, filename)';
if ~iscell(musicas)
    musicas = {musicas};
end 

for i = 1:length(musicas)
    filename = musicas{i,1};

    [dadosDouble,Fs] = audioread(filename);          
    dadosDouble = dadosDouble';
    
    if (secStop>size(dadosDouble,2))
        stop = size(dadosDouble,2);
    else
        stop = secStop;
    end
    
    tic;
    fprintf("Tocando ... ",i);
    sound(dadosDouble(:,(secStart:stop)),Fs,nbits);
    fprintf("a música %d\n",i);
    
    timer = toc;
    ponto = add;
    while (timer < duration) && (timer < stop/fs) 
        timer = toc;
        if(timer >= ponto)
            fprintf('.',timer);
            ponto=ponto+add;
        end
    end
    clear sound;
    fprintf("\nFim da música %d\n\n",i);
end
