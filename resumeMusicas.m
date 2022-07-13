clc; clear variables; close all;
fs = 44.1e3;        % frequ�ncia de amostragem
nbits = 16;         % nro de bits da quantiza��o do sinal
ncanais = 1;        % nro de canais: mono, est�reo

GRAVAR = 0;
LER = 1;
MULTISELECT = 2;

filename = 'sound1.mp4';
duration = 60;      % gravar por 60 seg = 1 min
startSec = 60;
mode = LER;
selection_mode = MULTISELECT;

secStart = startSec*fs;
secStop = (startSec+duration)*fs;

if selection_mode == MULTISELECT
    [filename, path] = uigetfile('*', 'Select music', 'MultiSelect', 'on');
end
musicas = strcat(path, filename);

for filename = musicas(:)
if mode == GRAVAR
    somObj = audiorecorder(fs,nbits,ncanais);
    disp('In�cio ...');
    recordblocking(somObj, duration); % gravar 
    disp('Fim da grava��o.');
    dadosDouble = getaudiodata(somObj)';
elseif mode == LER
    [dadosDouble,Fs] = audioread(filename, [secStart secStop]);          
    dadosDouble = dadosDouble';
end

% if input("Ler grava��o? (y/n)",'s')~='n'
if 1
   if mode == GRAVAR
       play(somObj); 
   elseif mode == LER
       disp("Tocando ...");
       sound(dadosDouble,Fs,nbits);
       disp("Fim.");
   end
end
pause(duration);
end
