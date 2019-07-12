% Convert MATLAB live scripts and Simulink models to PDF
% By Pavel Roslovets, ETMC Exponenta
dirs = [".."];
formats = [".mlx" ".slx"];
target = pwd;

dirs = fullfile(pwd, dirs);
for i = 1 : length(dirs)
    cd(dirs(i));
    fs = table;
    for k = 1 : length(formats)
        fs = [fs; struct2table(dir("*" + formats(k)), 'AsArray', 1)];
    end
    for j = 1 : height(fs)
        [~, name, format] = fileparts(fs.name{j});
        if ~checkpdf(name, format, target)
            disp("Converting " + name + format);
            switch format
                case ".mlx"
                    mlx2pdf(name, target);
                case ".slx"
                    slx2pdf(name, target);
            end
        end
    end
    disp('All done');
end
cd(target);

function ok = checkpdf(name, format, target)
ok = false;
fpath = fullfile(target, name + ".pdf");
if isfile(fpath)
    pdf = dir(fpath);
    src = dir(name + string(format));
    ok = pdf.datenum >= src.datenum;
end
end

function slx2pdf(model, target)
open_system(model);
sim(model);
saveas(get_param(model, 'Handle'), fullfile(target, model + ".pdf"));
close_system(model);
end

function mlx2pdf(name, target)
sname = char(name + ".mlx");
tname = char(fullfile(target, name + ".pdf"));
matlab.internal.liveeditor.openAndConvert(sname, tname);
end