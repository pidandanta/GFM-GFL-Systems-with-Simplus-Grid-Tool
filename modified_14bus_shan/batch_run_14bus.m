clear all; clc; close all;

root_path = 'D:\82261\Simplus-Grid-Tool-master';
cd(root_path);
output_dir = fullfile(root_path, 'modified_14bus_shan');
addpath(genpath(output_dir));

% 指向 Robust 鲁棒系列文件
ScenarioFiles = {'Robust_14Bus_20pct', 'Robust_14Bus_40pct', ...
                 'Robust_14Bus_60pct', 'Robust_14Bus_80pct', ...
                 'Robust_14Bus_100pct'};

for i = 1:length(ScenarioFiles)
    UserDataName = ScenarioFiles{i};
    fprintf('\n==========================================\n');
    fprintf('正在解析并生成 Simulink 模型: %s (%d/%d)\n', UserDataName, i, length(ScenarioFiles));
    fprintf('==========================================\n');
    
    UserDataType = 1; 
    SimplusGT.Toolbox.Main(); 
    
    NewModelName = ['Model_', UserDataName];
    if bdIsLoaded('mymodel_v1')
        save_system('mymodel_v1', fullfile(output_dir, [NewModelName, '.slx']));
        close_system(NewModelName);
    end
    
    clear GsysDss GsysSs YsysDss YsysSs ObjGsysDss ObjGsysSs; 
    DataFileName = ['Data_', UserDataName, '.mat'];
    save(fullfile(output_dir, DataFileName));
    
    clearvars -except ScenarioFiles i UserDataType root_path output_dir;
end

fprintf('\n所有 %d 个鲁棒场景生成完毕！\n', length(ScenarioFiles));