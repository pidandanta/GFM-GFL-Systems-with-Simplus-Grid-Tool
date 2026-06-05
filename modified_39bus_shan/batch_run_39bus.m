clear all; clc; close all;

% 1. 指向根目录与输出文件夹
root_path = 'D:\82261\Simplus-Grid-Tool-master';
cd(root_path);
output_dir = fullfile(root_path, 'modified_39bus_shan'); % 指向 39 节点工程文件夹
addpath(genpath(output_dir));

% 2. 依次遍历刚才生成的 5 个 39 节点高鲁棒性文件
ScenarioFiles = {'IEEE_39Bus_GFM_20pct', 'IEEE_39Bus_GFM_40pct', ...
                 'IEEE_39Bus_GFM_60pct', 'IEEE_39Bus_GFM_80pct', ...
                 'IEEE_39Bus_GFM_100pct'};

for i = 1:length(ScenarioFiles)
    UserDataName = ScenarioFiles{i};
    fprintf('\n==========================================\n');
    fprintf('正在解析并生成 Simulink 模型: %s (%d/%d)\n', UserDataName, i, length(ScenarioFiles));
    fprintf('==========================================\n');
    
    % 设置数据类型，SimplusGT 内部 Main() 会据此静默运行
    UserDataType = 1; 
    SimplusGT.Toolbox.Main(); 
    
    % 3. 保存并重命名 Simulink 模型
    NewModelName = ['Model_', UserDataName];
    if bdIsLoaded('mymodel_v1')
        % 另存为指定的 slx 文件
        save_system('mymodel_v1', fullfile(output_dir, [NewModelName, '.slx']));
        % 强制关闭内存中的原始模型，防止下一次循环冲突或内存溢出
        close_system('mymodel_v1', 0); 
    end
    
    % 4. 清理庞大的无用变量，避免保存 .mat 时文件过大
    clear GsysDss GsysSs YsysDss YsysSs ObjGsysDss ObjGsysSs; 
    
    % 保存当前工作区核心数据 (极点poles、A矩阵等) 到 .mat 文件
    DataFileName = ['Data_', UserDataName, '.mat'];
    save(fullfile(output_dir, DataFileName));
    
    % 5. 清理工作区，仅保留外层循环变量，进入下个场景
    clearvars -except ScenarioFiles i UserDataType root_path output_dir;
end

fprintf('\n🎉 所有 %d 个 39 节点 GFM 场景的模型 (.slx) 与数据 (.mat) 生成完毕！\n', length(ScenarioFiles));