instvar.URL = 'https://github.com/ETMC-Exponenta/LEDControlApp/archive/master.zip';
instvar.Name = 'LED-Control-App';
% Main routine
fprintf('Downloading %s...\n', instvar.Name);
websave(instvar.Name, instvar.URL);
disp('Installing...')
disp('Download complete, installing...')
instvar.Fs = unzip(instvar.Name);
instvar.DName = instvar.Fs{1}(1:end-1);
movefile(instvar.DName, instvar.Name);
cd(instvar.Name)
disp('Install complete, have fun!')
clear instvar
% Post-install tasks
startup